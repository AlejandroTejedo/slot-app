//
//  AuthViewModel.swift
//  GoSlotNativa
//
//  Created by Alejandro on 24/10/21.
//

import SwiftUI
import Firebase
import GoogleSignIn
import AVFoundation

class AuthViewModel: ObservableObject {
    
    @Published var userSession: Firebase.User?
    @Published var currentUser: User?
    @Published var authenticated = 0
    @State private var idToken = ""
    
    
    
    static let shared = AuthViewModel()
    
    init(){
        userSession = Auth.auth().currentUser
        fetchUser()
    }
    
    func login(withEmail email: String, password: String){
        Auth.auth().signIn(withEmail: email, password: password) { (result, err) in
            if let err = err {
                print(err.localizedDescription)
                return
            }
            
            guard let user = result?.user else { return }
            self.userSession = user
            self.fetchUser()
            
        }
    }
    
    func register(withEmail email: String, password: String, username: String) {
        Auth.auth().createUser(withEmail: email, password: password) { (result,err) in
            if let err = err {
                print(err.localizedDescription)
                return
            }
            
            guard let user = result?.user else { return }
            
            let data = ["email": email,
                        "username": username,
                        "uid": user.uid]
            
            Firestore.firestore().collection("usuarios").document(user.uid).setData(data) { err in
                if let err = err {
                    print(err.localizedDescription)
                    return
                }
                
                self.userSession = user
                self.fetchUser()
                
                
                print("DEBUG: USER CREATED")
            }
         
        }
    }
    
    func loginGoogle(){
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }

        // Create Google Sign In configuration object.
        let config = GIDConfiguration(clientID: clientID)
        
        GIDSignIn.sharedInstance.signIn(with: config, presenting: getRootViewController()) {
            [self] user, err in
            
              guard
                let authentication = user?.authentication,
                let idToken = authentication.idToken
              else {
                return
              }

              let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                             accessToken: authentication.accessToken)

            Auth.auth().signIn(with: credential) { result, err in
                
                if let error = err {
                    print(error.localizedDescription)
                    return
                  }
                
                guard let user = result?.user else { return }
                tokenSignIn(idToken: authentication.idToken ?? "")
                self.userSession = user
                self.fetchUser()
                            
                
                
                print (user.displayName ?? "Logueado!")
            }
            
        }
    }
    
    func logout() {
        self.userSession = nil
        GIDSignIn.sharedInstance.signOut()
        try? Auth.auth().signOut()
    }
    
    func fetchUser() {
        
        guard let uid = userSession?.uid else { return }
        
        Firestore.firestore().collection("usuarios").document(uid).getDocument { (snap, err) in
            if let err = err {
                print(err.localizedDescription)
                return
            }
            
            guard let user = try? snap?.data(as: User.self) else { return }
            self.currentUser = user
        }
    }
    
    func tokenSignIn(idToken: String) {
    guard let authData = try? JSONEncoder().encode(["authCode": idToken]) else {
    return
    }
     
    guard let url = URL(string: "https://api.goslot.es/user/glogin") else {return}
     
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
     
    let task = URLSession.shared.uploadTask(with: request, from: authData) { data, response, error in
    print(response!)
    do {
        let json = try JSONSerialization.jsonObject(with: data!) as! Dictionary<String, AnyObject>
        DispatchQueue.main.async {
            self.authenticated = 1
        }
        print(json["token"])
        self.getBearer(idToken: json["token"] as! String)
    } catch {
        print("error")
        DispatchQueue.main.async {
            self.authenticated = 2
        }
    }
}
        task.resume()
    }
    
    
    
    
    //BEARER
    func getBearer(idToken: String) {
        
        
        guard let url = URL(string: "https://api.goslot.es/user/status") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("bearer \(idToken)", forHTTPHeaderField: "Authorization")

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            print(response!)
                do {
                    let json = try JSONSerialization.jsonObject(with: data!) as! Dictionary<String, AnyObject>
                    DispatchQueue.main.async {
                        self.authenticated = 1
                        self.getRootViewController()
                    }
                    print(json)
                } catch {
                    print("error")
                    DispatchQueue.main.async {
                        self.authenticated = 2
                    }
                }
        }
        task.resume()
    }
    
}

extension AuthViewModel {
    func getRect()->CGRect{
        return UIScreen.main.bounds
    }
    
    func getRootViewController() -> UIViewController {
        guard let screen = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
            return .init()
        }
        
        guard let root = screen.windows.first?.rootViewController else {
            return .init()
        }
        
        return root
    }
}

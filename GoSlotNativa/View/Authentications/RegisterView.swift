//
//  RegisterView.swift
//  GoSlotNativa
//
//  Created by Alejandro on 24/10/21.
//

import SwiftUI

struct RegisterView: View {
    
    @State var email = ""
    @State var username = ""
    @State var password = ""
    
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        NavigationView {
            VStack {
                Image("logo_slot_transparente")
                    .renderingMode(.template)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 180, height: 180)
                    .foregroundColor(.black)
                
                VStack(spacing: -15) {
                    CustomTextField(text: $username, placeholder: Text("Nombre de usuario"), imageName: "person")
                        .padding()
                        .cornerRadius(10)
                        .foregroundColor(.black)
                        .padding(.horizontal, 32)
                    
                    CustomTextField(text: $email, placeholder: Text("Email"), imageName: "envelope")
                        .padding()
                        .cornerRadius(10)
                        .foregroundColor(.black)
                        .padding(.horizontal, 32)
                    
                    CustomSecureField(text: $password, placeholder: Text("Contraseña"), imageName: "envelope")
                        .padding()
                        .padding(.horizontal, 32)
                        .foregroundColor(.black)
                    
                    
                }
                
                Button(action: {
                    viewModel.register(withEmail: email, password: password, username: username)
                }, label: {
                    Text("Registrarse")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(width: 360, height: 50)
                        .background(Color.blue)
                        .clipShape(Capsule())
                        .padding()
                })
                
                Spacer()
                
                NavigationLink(destination: SignInView().navigationBarHidden(true), label: {
                    HStack {
                        Text("¿Ya tienes una cuenta?")
                            .font(.system(size: 14, weight: .semibold))
                        
                        Text("Conectate")
                            .font(.system(size: 14))
                    }
                })
                
            }.padding(.top, -100)
        }
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}

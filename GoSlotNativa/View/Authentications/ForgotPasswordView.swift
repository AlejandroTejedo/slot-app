//
//  ForgotPasswordView.swift
//  GoSlotNativa
//
//  Created by Alejandro on 24/10/21.
//

import SwiftUI

struct ForgotPasswordView: View {
    
    @Binding var email: String
    
    init(email: Binding<String>){
        self._email = email
    }
    
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
                    
                    CustomTextField(text: $email, placeholder: Text("Email"), imageName: "envelope")
                        .padding()
                        .cornerRadius(10)
                        .foregroundColor(.black)
                        .padding(.horizontal, 32)
                }
                
                HStack {
                    Spacer()
                    
                    NavigationLink(destination: SignInView().navigationBarHidden(true), label: {
                        Text("Atras")
                            .font(.system(size: 13, weight: .semibold))
                            .foregroundColor(.gray)
                            .padding(.top)
                            .padding(.trailing, 28)
                    })
                }
                
                Button(action: {
                    
                }, label: {
                    Text("Reestablecer la contraseña")
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

struct ForgotPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ForgotPasswordView(email: .constant("email"))
    }
}

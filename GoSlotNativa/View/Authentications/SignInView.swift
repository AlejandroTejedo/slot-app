//
//  SignInView.swift
//  GoSlotNativa
//
//  Created by Alejandro on 24/10/21.
//

import SwiftUI

struct SignInView: View {
    
    @EnvironmentObject var viewModel: AuthViewModel
    @Environment(\.colorScheme) var colorScheme
    
    @State var email = ""
    @State var password = ""
    @State var isLoading: Bool = false
    
    var body: some View {
        NavigationView {
            VStack {
                if(colorScheme == .dark){
                    Image("logo_slot_transparente")
                        .renderingMode(.template)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 180, height: 180)
                        .foregroundColor(.white)
                    
                    Text("Encuentra los clubs de Slot más cercanos a tí.")
                        .foregroundColor(.white)
                } else {
                    Image("logo_slot_transparente")
                        .renderingMode(.template)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 180, height: 180)
                        .foregroundColor(.black)
                    
                    Text("Encuentra los clubs de Slot más cercanos a tí.")
                        .foregroundColor(.black)
                }
                
                
                VStack(spacing: -15) {
                    
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
                
                HStack {
                    Spacer()
                    
                    NavigationLink(destination: ForgotPasswordView(email: $email).navigationBarHidden(true), label: {
                        Text("¿Has olvidado la contraseña?")
                            .font(.system(size: 13, weight: .semibold))
                            .foregroundColor(.black)
                            .padding(.top)
                            .padding(.trailing, 28)
                    })
                }
                
                Button(action: {
                    viewModel.login(withEmail: email, password: password)
                }, label: {
                    Text("Conectate")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(width: 360, height: 50)
                        .background(Color.blue)
                        .clipShape(Capsule())
                        .padding()
                })
                
                //Google button
                Button {
                    viewModel.loginGoogle()
                } label: {
                    
                    HStack(spacing: 15){
                        
                        Image("google")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 28, height: 28)
                        
                        Text("Iniciar sesión con Google")
                            .font(.title3)
                            .fontWeight(.medium)
                            .kerning(1.1)
                    }
                    .foregroundColor(Color("White"))
                    .padding()
                    .frame(maxWidth: .infinity)
                    //Marco
                    .background(
                        Capsule()
                            .strokeBorder(Color("Red"))
                    )
                }

                
                Spacer()
                
                NavigationLink(destination: RegisterView().navigationBarHidden(true), label: {
                    HStack {
                        Text("¿No tienes una cuenta?")
                            .font(.system(size: 14, weight: .semibold))
                        
                        Text("Registrate")
                            .font(.system(size: 14))
                    }
                })
                
            }.padding(.top, -100)
        }
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}

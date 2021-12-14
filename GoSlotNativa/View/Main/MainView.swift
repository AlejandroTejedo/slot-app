//
//  MainView.swift
//  GoSlotNativa
//
//  Created by Alejandro on 24/10/21.
//

import SwiftUI

struct MainView: View {
    let user: User
    
    @Binding var selectedIndex: Int
    
    var body: some View {
        NavigationView {
            TabView(selection: $selectedIndex) {
                FeedView()
                    .onTapGesture {
                        selectedIndex = 0
                    }
                    .tabItem{
                        Image(systemName: "house")
                    }.tag(0)
                
                SearchView()
                    .onTapGesture {
                        selectedIndex = 1
                    }
                    .tabItem{
                        Image(systemName: "magnifyingglass")
                    }.tag(1)
                
                UploadPostView()
                    .onTapGesture {
                        selectedIndex = 2
                    }
                    .tabItem{
                        Image(systemName: "plus.square")
                    }.tag(2)
                              
                
                NotificationView()
                    .onTapGesture {
                        selectedIndex = 3
                    }
                    .tabItem{
                        Image(systemName: "bell.fill")
                    }.tag(3)
                
                ProfileView(user: user)
                    .onTapGesture {
                        selectedIndex = 4
                    }
                    .tabItem{
                        Image(systemName: "person")
                    }.tag(4)
            }
            .navigationTitle(tabTitle)
      //      .navigationBarItems(trailing: NotificationButton)
            .accentColor(.black)
        }
    }
    
  /*  var NotificationButton: some View {
        Button {
            NotificationView()
                    selectedIndex = 3
                
        } label: {
            Image(systemName: "bell.fill").foregroundColor(.black)
        }
    }*/
    
  /*  var logOutButton: some View {
        Button {
            AuthViewModel.shared.logout()
        } label: {
            Text("Desconectarse").foregroundColor(.blue)
        }
    }*/
    
    var tabTitle: String {
        switch selectedIndex {
        case 0:
            return "Publicaciones"
        case 1:
            return "Buscar"
        case 2:
            return "Subir"
        case 3:
            return "Notificaciones"
        case 4:
            return "Perfil"
        default:
            return ""
        }
    }
    
}

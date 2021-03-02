//
//  ContentView.swift
//  ReFresh
//
//  Created by Sergiu Corbu on 1/20/21.
//

import SwiftUI
import Firebase

struct ContentView: View {
    
    @State var logged = false
    
    var body: some View {
        
        VStack{
            if User.currentUser() != nil && User.currentUser()!.onBoarding{
                TabView{
                    
                    Drinks() .tabItem { Image("t2")
                        Text("Produse")}
                    Search() .tabItem { Image(systemName: "magnifyingglass")
                        Text("Cauta")}
                    Basket() .tabItem { Image(systemName: "bag")
                        Text("Comanda") }
                    Settings() .tabItem { Image(systemName: "gear")
                        Text("Setari")}
                }
                .accentColor(.red)
            } else if User.currentUser() != nil{
                FinishRegistration()
            } else { SignUp()}
            
            
        }
            
        }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
    }
}

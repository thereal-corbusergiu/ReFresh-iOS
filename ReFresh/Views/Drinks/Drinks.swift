//
//  Drinks.swift
//  ReFresh
//
//  Created by Sergiu Corbu on 1/24/21.
//

import SwiftUI

struct Drinks: View {
    
    @ObservedObject var drinkListener = DrinkListener()
    
    var categories: [String: [Drink]]{
        .init(grouping: drinkListener.drinks, by: {$0.category.rawValue})
    }
    
    var body: some View {
        NavigationView{
            
            List(categories.keys.sorted(), id:\String.self){
                key in DrinkRow(categoryName: "\(key)".uppercased(), drinks: self.categories[key]!)
                    .frame(height: 320)
                    .padding(.top, -2)
                    .padding(.bottom, -5)
            }
            .navigationBarTitle(Text("Produsele ReFresh"))
        }
    }
}

struct Drinks_Previews: PreviewProvider {
    static var previews: some View {
        Drinks()
    }
}

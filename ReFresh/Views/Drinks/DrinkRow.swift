//
//  DrinkRow.swift
//  ReFresh
//
//  Created by Sergiu Corbu on 1/24/21.
//

import SwiftUI

struct DrinkRow: View {
    
    var categoryName: String
    var drinks: [Drink]
    
    var body: some View {
        
        VStack(alignment: .leading) {
            Text(self.categoryName)
                .font(.title)
                .foregroundColor(.primary)
            
            ScrollView(.horizontal, showsIndicators: true){
                HStack{
                    ForEach(self.drinks) { drink in
                        NavigationLink(
                            destination: DrinkDetail(drink: drink)){
                            DrinkItem(drink: drink)
                                .frame(width: 300)
                                .padding(.trailing, 30)
                        }
                       
                    }
                }
            }
            
        }
    }
}

struct DrinkRow_Previews: PreviewProvider {
    static var previews: some View {
        DrinkRow(categoryName: "Sucuri simple", drinks: DrinkMenu)
    }
}

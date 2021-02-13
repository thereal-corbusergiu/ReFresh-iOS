//
//  CustomOrders.swift
//  ReFresh
//
//  Created by Sergiu Corbu on 2/3/21.
//

import SwiftUI

struct CustomOrders: View {
    var body: some View {
        NavigationView{
            ScrollView{
                
                GroupBox{ //VStack(alignment: .leading){
                    HStack{
                        Text("Comenzi personalizate")
                            .padding([.leading,.trailing], 20)
                        Image(systemName: "info.circle")
                    }
                    Divider()
                    HStack{
                        Image(systemName: "chevron.right")
                            .frame(width: 50, height: 50)
                            .padding(.all, 20)
                        Text("oferim serivitii de ijsifsj vojvvnv nvudjnvudvudfsnvuosdvnsoudvnsoudvnsouvnuosvnsuovnuosvnuosvnuofjoesifjewoifje")
                    }
                    .padding(.top, 10)
                }.padding([.leading, .trailing, .bottom], 30)
                
            }
            .navigationBarTitle(Text("Comanzi extra"))
        }
    }
}

struct CustomOrders_Previews: PreviewProvider {
    static var previews: some View {
        CustomOrders()
    }
}

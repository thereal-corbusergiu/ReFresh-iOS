//
//  Basket.swift
//  ReFresh
//
//  Created by Sergiu Corbu on 1/24/21.
//

import SwiftUI

struct Basket: View {
    
    @ObservedObject var basketListener = BasketListener()
    @State private var showOrderAlert = false
    @State var orderDate: Date = Date()
    @State private var toGo = false

    let minDate = Calendar.current.date(byAdding: .day, value: 0 ,to: Date())!
    let maxDate = Calendar.current.date(byAdding: .day, value: 1 ,to: Date())!
    var totalPrice: Double{
        let total = basketListener.orderBasket.total
        return total
    }

    var dateFormatter: DateFormatter{
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM , HH:mm"
        return formatter
    }
    
    var orderDateString: String{
        return dateFormatter.string(from: orderDate)
    }
    
    var body: some View {

        NavigationView{
            Form{
                Section{
                    ForEach(self.basketListener.orderBasket?.items ?? []){
                        drink in HStack{
                            Image(drink.imageName)
                                .resizable()
                                .frame(width: 70, height: 50)
                                .cornerRadius(10)
                            VStack(alignment: .leading){
                                Text(drink.name)
                                    .padding(.bottom, -2)
                                    .font(.title3)
                                Text("\(drink.price.clean) lei / pahar") .font(.footnote)
                            } .padding(.leading, 10)
                        } //hstack end
                    }.onDelete(perform: { (indexSet) in
                    self.deleteItems(at: indexSet)
                })
                }
                HStack{
                    Text("Data ridicare")
                    DatePicker("",selection: $orderDate, in: minDate...maxDate)
                        .padding(.leading, -5)
                }
               
                Toggle(isOn: $toGo){ Text("Comanda to Go")}
                Label("Plata se va efectua la ridicarea comenzii", systemImage: "info.circle")
                    //.foregroundColor(.yellow)
                    .shadow(radius: 9)
                    .font(.footnote)
                    
                Section(header: Text("Total: \(totalPrice.clean) lei") .font(.title2) .padding(.leading, 10) .padding(.bottom, 10)){
                        Button(action:{
                                self.showOrderAlert.toggle()
                                self.createOrder()
                                self.emptyBasket()
                            }) {Text("Plaseaza comanda")}
                    }.disabled(self.basketListener.orderBasket?.items.isEmpty ?? true)
            }//form end
            .navigationBarTitle(Text("Comanda ta")) .listStyle(GroupedListStyle())
        } .alert(isPresented: $showOrderAlert){ Alert(title: Text("Comanda a fost plasata"), message: Text("Va multumim!"))}
    } //body end
   
    private func createOrder(){
        let order = OnlineOrder()
        order.amount = totalPrice
        order.id = UUID().uuidString
        order.customerFullName = User.currentUser()!.fullName
        order.customerPhone = User.currentUser()!.phoneNumber
        order.orderDate = orderDateString
        order.toGo = toGo
        order.orderItems = self.basketListener.orderBasket.items
        order.saveOnlineOrderToFirestore()
    }
    private func emptyBasket(){
        self.basketListener.orderBasket.emptyBasket()
        self.orderDate = Date()
        self.toGo = false
    }
    func deleteItems(at offsets: IndexSet){
        self.basketListener.orderBasket.items.remove(at: offsets.first!)
        self.basketListener.orderBasket.saveBasketToFirestore()}
}

struct Basket_Previews: PreviewProvider {
    static var previews: some View {
        Basket()
    }
}

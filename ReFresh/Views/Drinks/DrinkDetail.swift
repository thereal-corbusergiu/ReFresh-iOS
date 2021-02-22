//
//  DrinkDetail.swift
//  ReFresh
//
//  Created by Sergiu Corbu on 1/25/21.
//

import SwiftUI

struct DrinkDetail: View {
    
    @Environment(\.presentationMode) var presentationMode
    var drink: Drink
    var ingredients: Int{
        return drink.ingredients.count
    }
    @State private var showingAlert = false
    var type: String{
        if drink.category.rawValue == "Sucuri"{
            return "Sucul contine"
        }
        else{
            return "Smoothie-ul contine"
        }
    }
    
    var body: some View {
        
        ScrollView(.vertical, showsIndicators: true){
            
            Image(drink.imageName)
                .resizable()
                // .aspectRatio(contentMode: .fit)
                .frame(height: UIScreen.main.bounds.height / 2.8)
            
            VStack{
                
                VStack(alignment: .leading){
                    Text(drink.name)
                        .font(.title)
                        .fontWeight(.bold)
                        .padding(.top, 1)
                } //vstack end
                .frame(maxWidth: .infinity,alignment: .leading)
           
                HStack{
                    Text("\(drink.price.clean) lei")
                        .font(.title) .fontWeight(.bold)
                        .padding(.bottom, 3)
                    Text("/ 330 ml")
                        .font(.subheadline)
                        .fontWeight(.bold)
                    Spacer()
                    Label(drink.priceInfo, systemImage: "info.circle")
                        .foregroundColor(.yellow)
                        .shadow(radius: 9)
                        .frame(width: 80)
                        .font(.footnote)
                        .padding(.leading, -5)
                }
                .padding(.top, 1)
                .frame(maxWidth: .infinity,alignment: .leading)
                
                Divider()
                
                VStack(alignment: .leading){
                    Text(drink.description) .foregroundColor(.primary) .font(.body) .lineLimit(4) .fixedSize(horizontal: false, vertical: /*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/) .padding(.top, -5)
                    
                } //3rd zstack end
                .padding(.top)
                .frame(maxWidth: .infinity,alignment: .leading)
                
                Label(type, systemImage: "tag")
                    .foregroundColor(.yellow) .shadow(radius: 9)
                    .padding(.top, 20) .padding(.bottom, 5)
               
                HStack(spacing: 20){
                    
                    if ingredients == 2{
                        VStack{
                            
                            Text(drink.ingredients[0])
                                .foregroundColor(.orange)
                                .font(.title3)
                            Text(drink.ingredients[1])
                                .foregroundColor(.red)
                                .font(.caption)
                        }
                        .padding()
                        .background(Color.black)
                        .cornerRadius(15)
                        .shadow(radius: 9)
                    }
                    
                    else if ingredients == 4{
                        VStack{
                            
                            Text(drink.ingredients[0])
                                .foregroundColor(.orange)
                                .font(.title3)
                            Text(drink.ingredients[1])
                                .foregroundColor(.red)
                                .font(.caption)
                        }
                        .padding()
                        .background(Color.black)
                        .cornerRadius(15)
                        .shadow(radius: 9)
                        
                        VStack{
                            
                            Text(drink.ingredients[2])
                                .foregroundColor(.green)
                                .font(.title3)
                            Text(drink.ingredients[3])
                                .foregroundColor(.red)
                                .font(.caption)
                        }
                        .padding()
                        .background(Color.black)
                        .cornerRadius(15)
                        .shadow(radius: 9)
                    }
                    
                    else if ingredients == 6{
                        VStack{
                            
                            Text(drink.ingredients[0])
                                .font(.title3)
                                .foregroundColor(.purple)
                            Text(drink.ingredients[1])
                                .font(.caption)
                                .foregroundColor(.red)
                            
                        }
                        .padding()
                        .background(Color.black)
                        .cornerRadius(15)
                        .shadow(radius: 9)
                        
                        VStack{
                            
                            Text(drink.ingredients[2])
                                .foregroundColor(.orange)
                                .font(.title3)
                            
                            Text(drink.ingredients[3])
                                .font(.caption)
                                .foregroundColor(.red)
                        }
                        .padding()
                        .background(Color.black)
                        .cornerRadius(15)
                        .shadow(radius: 9)
                        
                        VStack{
                            
                            Text(drink.ingredients[4])
                                .font(.title3)
                                .foregroundColor(.yellow)
                            Text(drink.ingredients[5])
                                .foregroundColor(.red)
                                .font(.caption)
                            
                        }
                        .padding()
                        .background(Color.black)
                        .cornerRadius(15)
                        .shadow(radius: 9)
                    }
                    
                } // hstack end
                .padding(.bottom,10)
                
                HStack{
                    Spacer()
                    OrderButton(showAlert: $showingAlert, drink: drink)
                    Spacer()
                }
                .padding(.top, 25)
                .padding(.bottom, UIScreen.main.bounds.height / 7)
            } //vstack end
            .padding()
            .background(Color.red)
            .cornerRadius(25, corners: [.topLeft, .topRight])
            .edgesIgnoringSafeArea(.bottom)
            .padding(.top, 90)
            .frame(height: UIScreen.main.bounds.width - 10)
            .navigationBarItems(trailing: Button(action:{
                self.presentationMode.wrappedValue.dismiss()
            }){
                Image(systemName: "xmark.circle")
                    .font(.system(size: 25))
            })
        
        } //scroll end
        .edgesIgnoringSafeArea(.top)
        .navigationBarHidden(false)
        .alert(isPresented: $showingAlert){
            Alert(title: Text("Produsul a fost adaugat in cos"),dismissButton: .default(Text("Ok")))}
    }
}

struct DrinkDetail_Previews: PreviewProvider {
    static var previews: some View {
        DrinkDetail(drink: DrinkMenu.first!)
            .preferredColorScheme(.light)
    }
}

struct OrderButton: View{
    
    @Binding var showAlert: Bool
    @ObservedObject var basketListener = BasketListener()
    var drink: Drink
    var body: some View{
        Button(action: {
            self.showAlert.toggle()
            self.addItemToBasket()
        }){Text("Adauga in cos")} .frame(width: 200, height: 50) .foregroundColor(.white) .font(.headline) .background(Color.orange) .cornerRadius(20.0)
    }
    
    private func addItemToBasket(){
        var orderBasket: Order!
        
        if self.basketListener.orderBasket != nil{
            orderBasket = self.basketListener.orderBasket
        } else{
            orderBasket = Order()
            orderBasket.customerFullName = User.currentUser()?.fullName
            orderBasket.id = UUID().uuidString
        }
        orderBasket.add(self.drink)
        orderBasket.saveBasketToFirestore()
    }
}

struct CustomShape : Shape {
    
    func path(in rect: CGRect) -> Path {
        
        return Path{path in
            
            path.move(to: CGPoint(x: 0, y: 0))
            path.addLine(to: CGPoint(x: rect.width, y: 0))
            path.addLine(to: CGPoint(x: rect.width, y: rect.height))
            path.addLine(to: CGPoint(x: 0, y: rect.height - 40))
            
        }
    }
}

struct Corners : Shape {
    
    func path(in rect: CGRect) -> Path {
        
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: [.topLeft,.topRight], cornerRadii: CGSize(width: 35, height: 35))
        
        return Path(path.cgPath)
    }
}


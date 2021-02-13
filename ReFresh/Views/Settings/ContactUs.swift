//
//  ContactUS.swift
//  ReFresh
//
//  Created by Sergiu Corbu on 2/2/21.
//

import SwiftUI
import CoreLocation

struct ContactUs: View {
    var body: some View {
        NavigationView{
            ScrollView{
                
                
                VStack{
                    MapView(coordinate: CLLocationCoordinate2D(latitude:46.775439, longitude: 23.587062))
                        .frame(width: 350, height: 250, alignment: .center)
                }
            }
        }
    }
}



struct ContactUs_Previews: PreviewProvider {
    static var previews: some View {
        ContactUs()
    }
}

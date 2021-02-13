//
//  dw.swift
//  ReFresh
//
//  Created by Sergiu Corbu on 2/10/21.
//

import SwiftUI

struct dw: View {
    
   
    @State var date = Date()
    var dateFormatter: DateFormatter{
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter
    }
    
    var stringfromdate: String{
        return dateFormatter.string(from: date)
    }
    
    var body: some View {
        
        VStack{
            Text("\(stringfromdate)")
            DatePicker("", selection: $date)
        }
    }
}

struct dw_Previews: PreviewProvider {
    static var previews: some View {
        dw()
    }
}

//
//  Account.swift
//  ReFresh
//
//  Created by Sergiu Corbu on 2/8/21.
//

import SwiftUI

struct Account: View {
    var body: some View {
        
        Button(action: {
            User.logOutUser { (error) in
                print("error logging out user", error?.localizedDescription)
            }
        }, label: {
            Text("Deconectare")
        })

    }
}

struct Account_Previews: PreviewProvider {
    static var previews: some View {
        Account()
    }
}

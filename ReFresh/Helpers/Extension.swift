//
//  Extension.swift
//  ReFresh
//
//  Created by Sergiu Corbu on 1/25/21.
//

import Foundation

extension Double{
    var clean: String{
        return self.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%..0f", self) : String(self)
    }
}

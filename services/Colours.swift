//
//  Colours.swift
//  SnapMap
//
//  Created by Barnaby Gordon on 20/05/2018.
//  Copyright © 2018 Barney Gordon. All rights reserved.
//

import UIKit


extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(rgb: Int) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF
        )
    }
}


class CoreColour: NSObject {
    
    static let green = UIColor(red: 0x60, green: 0xd3, blue: 0x94)
    static let red = UIColor(red: 0xee, green: 0x60, blue: 0x55)
    static let lightGreen = UIColor(red: 0xaa, green: 0xf6, blue: 0x83)
    static let orange = UIColor(red: 0xff, green: 0xd9, blue: 0x7d)
    static let lightRed = UIColor(red: 0xff, green: 0x9b, blue: 0x85)
    
//    static let green = UIColor(red: 56/255, green: 228/255, blue: 174/255, alpha: 1)
//    static let red = UIColor(red: 255/255, green: 73/255, blue: 92/255, alpha: 1)
//    static let lightRed = UIColor(red: 255/255, green: 106/255, blue: 121/255, alpha: 1)
//    static let white = UIColor(red: 252/255, green: 252/255, blue: 252/255, alpha: 1)
//    static  let purple = UIColor(red: 70/255, green: 35/255, blue: 122/255, alpha: 1)
//    static let blue = UIColor(red: 37/255, green: 110/255, blue: 255/255, alpha: 1)
}


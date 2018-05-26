//
//  keys.swift
//  SnapMap
//
//  Created by Barnaby Gordon on 24/05/2018.
//  Copyright © 2018 Barney Gordon. All rights reserved.
//

import Foundation


func valueForAPIKey(keyname:String) -> String {
    let filePath = Bundle.main.path(forResource: "keys", ofType: "plist")
    let plist = NSDictionary(contentsOfFile: filePath!)
    let value:String = plist?.object(forKey: keyname) as! String
    
    return value
}

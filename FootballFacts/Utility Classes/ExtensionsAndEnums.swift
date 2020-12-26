//
//  Extensions.swift
//  FootballFacts
//
//  Created by Akanksha Harsh Saxena on 23/12/20.
//

import UIKit


extension UIColor{
    class var hudColor: UIColor {
        return UIColor(red: 25.0/255.0, green: 25.0/255.0, blue: 25.0/255.0, alpha: 1.0)
    }
    
    class var hudBezelColor: UIColor {
        //return UIColor(red: 237.0/255.0, green: 237.0/255.0, blue: 237.0/255.0, alpha: 1.0)
        return UIColor(red: 1/255.0, green: 0/255.0, blue: 0/255.0,
        alpha: 0.5)
    }
    
    
}

extension UIFont{
    class var gillSans: UIFont{
        return UIFont(name: "Gill Sans SemiBold", size: 18.0)!
    }
}

enum FormCase: String {
    case won = "W"
    case lost = "L"
    case draw = "D"
}

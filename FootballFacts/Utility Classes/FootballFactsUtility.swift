//
//  FootballFactsUtility.swift
//  FootballFacts
//
//  Created by Akanksha Harsh Saxena on 22/12/20.
//

import Foundation
import Alamofire

class FootballFactsUtility{
    
    class func appDelegate() -> AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }
    
    class func mainWindow() -> UIWindow {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.window!
    }
    
    class func isNetworkReachable() -> Bool{
        if (NetworkReachabilityManager()?.isReachable)!{
            return true
        }
        return false
    }
}


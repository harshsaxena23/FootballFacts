//
//  FootballFactsLoadView.swift
//  FootballFacts
//
//  Created by Akanksha Harsh Saxena on 22/12/20.
//

import UIKit
import MBProgressHUD


class FootballFactsLoadView{
    class func showLoadingHUD(in view: UIView?){
        if let view = view{
            let hud = MBProgressHUD.showAdded(to: view, animated: true)
            hud.bezelView.color = UIColor.clear
            hud.contentColor = UIColor.hudColor
            hud.bezelView.style = MBProgressHUDBackgroundStyle.solidColor
            view.layoutIfNeeded()
        }        
    }
    
    class func hideLoadingHUD(in view: UIView?){
        if let view = view{
            MBProgressHUD.hide(for: view, animated: true)
            view.layoutIfNeeded()

        }
    }
    
    class func showAlertFor(title: String, message: String, titleAction: String, showCancelAlso: Bool = false) -> UIAlertController{
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: titleAction, style: .default, handler: nil)
        if showCancelAlso{
            let cancelAction = UIAlertAction(title: titleAction, style: .cancel, handler: nil)
            alert.addAction(cancelAction)
        }
        alert.addAction(okAction)
        return alert
    }
    
    class func navigateToDetailScreen(navigationController: UINavigationController, teamDetails: Standings){
    }
}

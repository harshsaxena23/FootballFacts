//
//  FootballFactsLoadView.swift
//  FootballFacts
//
//  Created by Akanksha Harsh Saxena on 22/12/20.
//

import UIKit
import MBProgressHUD
import SDWebImageSVGCoder


class FootballFactsLoadView{
    class func showLoadingHUD(in view: UIView?){
        if let view = view{
            let hud = MBProgressHUD.showAdded(to: view, animated: true)
            hud.bezelView.color = UIColor.hudBezelColor
            hud.label.text = "Loading"
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
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let detailVC = storyBoard.instantiateViewController(identifier: "detailViewController") as! DetailTeamTableViewController
        detailVC.teamDetails = teamDetails
        navigationController.pushViewController(detailVC, animated: true)
        
    }
    
    class func loadCellForStandings(cell: StandingsTableViewCell, indexPath: IndexPath, standings: Standings){
        cell.teamNameLabel.text = standings.name
            let SVGCoder = SDImageSVGCoder.shared
            SDImageCodersManager.shared.addCoder(SVGCoder)
        if let urlString = standings.crest_url{
            let url = URL(string: urlString)
            cell.teamIconImageView.sd_setImage(with: url!, placeholderImage: UIImage(named: "img_background"), completed: nil)
        }else{
            cell.teamIconImageView.contentMode = .scaleAspectFill // has been added only because a proportionate size placeholder image not found
            cell.teamIconImageView.image = UIImage(named: "img_background")
        }
        cell.positionLabel.text = String(standings.position)
        cell.totalPointsLabel.text = String(standings.points)
    }
    
    class func configureSubviewForForm(frame: CGRect, formArray: [String]) -> UIView{
        
        let width  : CGFloat = 20
        let height : CGFloat = 20
        let containerView = UIView(frame: CGRect(x: 0, y: 0, width: frame.width, height: frame.height))
        var xPos: CGFloat = frame.width - width
        for (index, _) in formArray.enumerated().reversed(){
            let view = UIView()
            let formType: FormCase = FormCase(rawValue: formArray[index])!
            view.frame = CGRect(x: xPos, y: frame.height/2 - height/2, width: width, height: height)
            view.layer.cornerRadius = width / 2
            switch formType {
            case .won:
                view.backgroundColor = .systemGreen
            case .lost:
                view.backgroundColor = .systemRed
            case .draw:
                view.backgroundColor = .systemOrange
            }
            xPos = xPos - view.frame.width - 5
            containerView.addSubview(view)
        }
        return containerView
    }
    
    
}

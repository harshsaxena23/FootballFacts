//
//  DetailTeamTableViewController.swift
//  FootballFacts
//
//  Created by Akanksha Harsh Saxena on 24/12/20.
//

import UIKit
import SDWebImageSVGCoder

class DetailTeamTableViewController: UITableViewController {
    
    @IBOutlet weak var teamNameLabel: UILabel!
    @IBOutlet weak var positionNumberLabel: UILabel!
    @IBOutlet weak var gamesPlayedLabel: UILabel!
    @IBOutlet weak var goalsForLabel: UILabel!
    @IBOutlet weak var goalsAgainstLabel: UILabel!
    @IBOutlet weak var goalsDifferenceLabel: UILabel!
    @IBOutlet weak var gamesWonLabel: UILabel!
    @IBOutlet weak var gamesLostLabel: UILabel!
    @IBOutlet weak var gamesDrawnLabel: UILabel!
    @IBOutlet weak var crestImageView: UIImageView!
    @IBOutlet var detailLabelOutletCollection : [UILabel]!
    @IBOutlet weak var formContainerView: UIView!
    @IBOutlet weak var backgroundImageView : UIImageView!
    var teamDetails : Standings!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.updateUIAttributes()
    }
    
    // MARK: - Table view data source
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
    }
    
    fileprivate func updateUIAttributes() {
        teamNameLabel.text = teamDetails.name
        positionNumberLabel.text = String(teamDetails.position)
        gamesPlayedLabel.text = String(teamDetails.played_games)
        gamesWonLabel.text = String(teamDetails.won)
        gamesLostLabel.text = String(teamDetails.lost)
        gamesDrawnLabel.text = String(teamDetails.draw)
        goalsForLabel.text = String(teamDetails.goalsFor)
        goalsAgainstLabel.text = String(teamDetails.goalsAgainst)
        goalsDifferenceLabel.text = String(teamDetails.goalsDifference)
        if let crest_url = teamDetails.crest_url{
            crestImageView.image = FootballFactsUtility.getSvgImage(crest_url)
            let data = crestImageView.image?.pngData()
            let pngImage = UIImage(data: data!)
            backgroundImageView.contentMode = .scaleAspectFill
            backgroundImageView.image = FootballFactsUtility.addBlurToImage(image: pngImage!)
            

        }
        
        detailLabelOutletCollection.forEach{
            $0.font = UIFont.gillSans
            $0.textColor = .darkGray
        }
        self.title = teamDetails.name
        let formArray = teamDetails.form?.components(separatedBy: ",")
        if let formArray = formArray{
            self.formContainerView.addSubview(FootballFactsLoadView.configureSubviewForForm(frame: formContainerView.frame, formArray: formArray))
        }
        
        tableView.tableFooterView = UIView()
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        if section == 0 {
            return 1
        }
        return 40
    }
//    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
//    }
    
    
    /*
     override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     let cell = tableView.dequeueReusableCell(withIdentifier: "detailCell", for: indexPath)
     
     
     // Configure the cell...
     
     return cell
     }
     */
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}

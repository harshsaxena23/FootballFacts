//
//  StandingsTableViewCell.swift
//  FootballFacts
//
//  Created by Akanksha Harsh Saxena on 24/12/20.
//

import UIKit

class StandingsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var positionLabel: UILabel!
    @IBOutlet weak var teamNameLabel: UILabel!
    @IBOutlet weak var totalPointsLabel : UILabel!
    @IBOutlet weak var teamIconImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

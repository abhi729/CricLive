//
//  MatchTableCell.swift
//  CricLive
//
//  Created by Abhishek Agarwal on 28/07/17.
//  Copyright © 2017 Abhishek. All rights reserved.
//

import UIKit


class MatchTableCell: UITableViewCell {
    
    @IBOutlet weak var matchNameLabel: UILabel!
    @IBOutlet weak var homeTeamLabel: UILabel!
    @IBOutlet weak var awayTeamLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var homeScoreLabel: UILabel!
    @IBOutlet weak var awayScoreLabel: UILabel!
    
    var match: Match!
    
}

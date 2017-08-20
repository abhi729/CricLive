//
//  MatchDetailController.swift
//  CricLive
//
//  Created by Abhishek Agarwal on 15/08/17.
//  Copyright © 2017 Abhishek. All rights reserved.
//

import UIKit

class MatchDetailController: UIViewController {
    
    var match: Match!
    var sections = [String]()
    
    @IBOutlet weak var tableView: UITableView!
    
    var scoreUpdateTimer: Timer?
    var refreshControl: UIRefreshControl!

    
    func updateScores() {
        if refreshControl.isRefreshing {
            refreshControl.attributedTitle = NSAttributedString(string: "Fetching scores..")
        }
        SportsieClient.sharedInstance().getMatchScores(forId: match.id) { (matchArray, error) in
            guard error == nil else {
                return
            }
            guard matchArray != nil, matchArray!.count != 0 else {
                return
            }
            self.match = matchArray![0]
            DispatchQueue.main.async {
                self.tableView.reloadData()
                if self.refreshControl.isRefreshing {
                    self.refreshControl.endRefreshing()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                        self.refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh scores!")
                    })
                }
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if match.statusId == MatchStatus.live {
            scoreUpdateTimer = Timer.scheduledTimer(timeInterval: 10.0, target: self, selector: #selector(MatchDetailController.updateScores), userInfo: nil, repeats: true)
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        scoreUpdateTimer?.invalidate()
        scoreUpdateTimer = nil
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sections = [match.status, "", "", "Recent Overs"]
        
        self.navigationItem.title = match.homeTeam! + " vs " + match.awayTeam!
        
        if match.statusId == MatchStatus.live {
            refreshControl = UIRefreshControl()
            refreshControl.tintColor = UIColor.gray
            refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh scores!")
            refreshControl.addTarget(self, action: #selector(MatchDetailController.updateScores), for: UIControlEvents.valueChanged)
            tableView.addSubview(refreshControl)
        }
        
    }
    
}

extension MatchDetailController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return match.previousInnings.count + 1
        } else if section == 1 {
            return match.batsmen.count + 1
        } else if section == 2 {
            return match.bowlers.count + 1
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var identifier = "currentInningsCell"
        if indexPath.section == 0 {
            if indexPath.row != 0 {
                identifier = "pastInningsCell"
            }
        } else if indexPath.section == 1 {
            if indexPath.row == 0 {
                identifier = "batsmanTitleCell"
            } else {
                identifier = "batsmanCell"
            }
        } else if indexPath.section == 2 {
            if indexPath.row == 0 {
                identifier = "bowlerTitleCell"
            } else {
                identifier = "bowlerCell"
            }
        } else {
            identifier = "recentOversCell"
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! MatchDetailTableCell
        if identifier == "currentInningsCell", let battingTeam = match.battingTeam, let runs = match.runs, let wickets = match.wickets, let overs = match.overs {
            cell.teamLabel.text = battingTeam
            cell.scoreLabel.text = "\(runs)/\(wickets) (\(overs))"
        } else if identifier == "pastInningsCell" {
            cell.teamLabel.text = match.previousInnings[indexPath.row - 1].battingTeam
            cell.scoreLabel.text = match.previousInnings[indexPath.row - 1].score
        } else if identifier == "batsmanCell" {
            let batsman = match.batsmen[indexPath.row - 1]
            cell.batsmanNameLabel.text = batsman.name
            cell.batsmanRunsLabel.text = "\(batsman.score) (\(batsman.ballsFaced))"
            cell.batsmanFoursLabel.text = batsman.fours
            cell.batsmanSixesLabel.text = batsman.sixes
            cell.batsmanStrikeRateLabel.text = batsman.strikeRate
        } else if identifier == "bowlerCell" {
            let bowler = match.bowlers[indexPath.row - 1]
            cell.bowlerNameLabel.text = bowler.name
            cell.bowlerRunsLabel.text = bowler.runs
            cell.bowlerOversLabel.text = bowler.overs
            cell.bowlerEconomyLabel.text = bowler.economy
            cell.bowlerWicketLabel.text = bowler.wickets
        } else if identifier == "recentOversCell", let history = match.history {
            cell.recentOversLabel.text = String(String(describing: history).characters)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section]
    }
}

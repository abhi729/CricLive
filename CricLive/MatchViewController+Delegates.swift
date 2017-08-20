//
//  MatchViewController+Delegates.swift
//  CricLive
//
//  Created by Abhishek Agarwal on 28/07/17.
//  Copyright © 2017 Abhishek. All rights reserved.
//

import UIKit

extension MatchViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return matches.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let currentMatch = matches[indexPath.row]
        let cell: MatchTableCell

        switch currentMatch.statusId {
        case .upcoming:
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "E, d MMM, hh:mm a"
            let status = dateFormatter.string(from: currentMatch.startTime!)
            cell = configureMatchCell(forTable: tableView, withIdentifier: "upcomingMatch", havingIndexPath: indexPath, matchName: currentMatch.description, homeTeamName: currentMatch.homeTeamFullName, awayTeamName: currentMatch.awayTeamFullName, status: status, homeTeamScore: nil, awayTeamScore: nil, battingTeam: nil)
            
        case .completed:
            let scores = determineHomeAndAwayScores(forMatch: currentMatch)
            cell = configureMatchCell(forTable: tableView, withIdentifier: "completedMatch", havingIndexPath: indexPath, matchName: currentMatch.description, homeTeamName: currentMatch.homeTeam!, awayTeamName: currentMatch.awayTeam!, status: currentMatch.status, homeTeamScore: scores.0, awayTeamScore: scores.1, battingTeam: currentMatch.battingTeam!)
            
        case .live:
            let scores = determineHomeAndAwayScores(forMatch: currentMatch)
            cell = configureMatchCell(forTable: tableView, withIdentifier: "liveMatch", havingIndexPath: indexPath, matchName: currentMatch.description, homeTeamName: currentMatch.homeTeam!, awayTeamName: currentMatch.awayTeam!, status: currentMatch.status, homeTeamScore: scores.0, awayTeamScore: scores.1, battingTeam: currentMatch.battingTeam!)
        }
        
        cell.matchNameLabel.textColor = UIColor.gray
        cell.selectionStyle = .none
        cell.match = currentMatch
        if cell.statusLabel.text == "" {
            cell.statusLabel.text = currentMatch.toss
        }
        
        return cell
    }
    
    func configureMatchCell(forTable tableView: UITableView, withIdentifier identifier: String, havingIndexPath indexPath: IndexPath, matchName: String, homeTeamName: String, awayTeamName: String, status: String, homeTeamScore: String?, awayTeamScore: String?, battingTeam: String?) -> MatchTableCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! MatchTableCell
        cell.matchNameLabel.text = matchName
        cell.homeTeamLabel.text = homeTeamName
        cell.awayTeamLabel.text = awayTeamName
        cell.statusLabel.text = status
        if let homeScore = homeTeamScore, let awayScore = awayTeamScore, let battingTeam = battingTeam {
            cell.homeScoreLabel.text = homeScore
            cell.awayScoreLabel.text = awayScore
            if homeTeamName == battingTeam {
                cell.homeTeamLabel.textColor = UIColor.black
                cell.homeScoreLabel.textColor = UIColor.black
                cell.awayTeamLabel.textColor = UIColor.gray
                cell.awayScoreLabel.textColor = UIColor.gray
            } else {
                cell.homeTeamLabel.textColor = UIColor.gray
                cell.homeScoreLabel.textColor = UIColor.gray
                cell.awayTeamLabel.textColor = UIColor.black
                cell.awayScoreLabel.textColor = UIColor.black
            }
        }
        return cell
    }
    
    func determineHomeAndAwayScores(forMatch match: Match) -> (String, String) {
        var homeScores = [String]()
        var awayScores = [String]()
        for inning in match.previousInnings {
            if inning.battingTeam == match.homeTeam! {
                homeScores.append(inning.score)
            } else {
                awayScores.append(inning.score)
            }
        }
        if let runs = match.runs, let wickets = match.wickets {
            if match.homeTeam! == match.battingTeam! {
                if wickets != "10" {
                    homeScores.append("\(runs)/\(wickets)")
                } else {
                    homeScores.append("\(runs)")
                }
            } else {
                if wickets != "10" {
                    awayScores.append("\(runs)/\(wickets)")
                } else {
                    awayScores.append("\(runs)")
                }
            }
        }
        return (homeScores.joined(separator: " & "), awayScores.joined(separator: " & "))
    }
    
}

extension MatchViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? MatchTableCell {
            cell.contentView.backgroundColor = UIColor(red: 249/255, green: 249/255, blue: 249/255, alpha: 1)
        }
    }
    
    func tableView(_ tableView: UITableView, didUnhighlightRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? MatchTableCell {
            cell.contentView.backgroundColor = UIColor.white
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? MatchTableCell, cell.match.statusId != MatchStatus.upcoming {
            performSegue(withIdentifier: "SegueToMatch", sender: cell.match)
        }
    }
    
}

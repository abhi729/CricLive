//
//  Match.swift
//  CricLive
//
//  Created by Abhishek Agarwal on 28/07/17.
//  Copyright © 2017 Abhishek. All rights reserved.
//

import Foundation

enum MatchStatus: Int {
    case upcoming = 0, live = 1, completed = 10
}

struct Match {
    // MARK: Properties
    
    let description: String
    let toss: String
    let id: String
    let runs: String?
    let wickets: String?
    let battingTeamUrl: String?
    let statusId: MatchStatus
    let status: String
    let overs: String?
    let crr: String?
    let history: String?
    let homeTeam: String?
    let awayTeam: String?
    let battingTeam: String?
    var batsmen: [Batsman] = []
    var bowlers: [Bowler] = []
    let startTime: Date?
    let pitchReport: String
    let weather: String
    let umpires: String
    let type: String
    let homeTeamFullName: String
    let awayTeamFullName: String
    let homeTeamUrl: String?
    let awayTeamUrl: String?
    let recentHistory: [Over]
    let previousInnings: [Inning]
    
    // MARK: Initializers
    
    init(dictionary: [String:AnyObject]) {
        description = dictionary[SportsieClient.JSONResponseKeys.MatchGameDescription] as! String
        id = dictionary[SportsieClient.JSONResponseKeys.MatchId] as! String
        statusId = MatchStatus(rawValue: dictionary[SportsieClient.JSONResponseKeys.MatchStatusId] as! Int)!
        runs = dictionary[SportsieClient.JSONResponseKeys.MatchRuns] as? String
        wickets = dictionary[SportsieClient.JSONResponseKeys.MatchWickets] as? String
        overs = dictionary[SportsieClient.JSONResponseKeys.MatchOvers] as? String
        crr = dictionary[SportsieClient.JSONResponseKeys.MatchCRR] as? String
        history = dictionary[SportsieClient.JSONResponseKeys.MatchHistory] as? String
        if let value = dictionary[SportsieClient.JSONResponseKeys.MatchStatus] {
            status = String(describing: value)
        } else {
            status = ""
        }
        if let value = dictionary[SportsieClient.JSONResponseKeys.MatchToss] {
            toss = String(describing: value)
        } else {
            toss = ""
        }
        battingTeamUrl = dictionary[SportsieClient.JSONResponseKeys.MatchBattingTeamUrl] as? String
        battingTeam = dictionary[SportsieClient.JSONResponseKeys.MatchBattingTeam] as? String
        homeTeam = dictionary[SportsieClient.JSONResponseKeys.HomeTeamName] as? String
        awayTeam = dictionary[SportsieClient.JSONResponseKeys.AwayTeamName] as? String
        homeTeamUrl = dictionary[SportsieClient.JSONResponseKeys.HomeTeamUrl] as? String
        awayTeamUrl = dictionary[SportsieClient.JSONResponseKeys.AwayTeamUrl] as? String
        
        if let history = dictionary[SportsieClient.JSONResponseKeys.RecentHistory] as? [[String: AnyObject]] {
            recentHistory = Over.oversFromResults(history)
        } else {
            recentHistory = []
        }
        
        if let prevInnings = dictionary[SportsieClient.JSONResponseKeys.PreviousInnings] as? [[String: AnyObject]] {
            previousInnings = Inning.inningsFromResults(prevInnings)
        } else {
            previousInnings = []
        }
        
        if let value = dictionary[SportsieClient.JSONResponseKeys.MatchType] {
            type = String(describing: value)
        } else {
            type = ""
        }
        
        if let value = dictionary[SportsieClient.JSONResponseKeys.HomeTeamFullName] {
            homeTeamFullName = String(describing: value)
        } else {
            homeTeamFullName = ""
        }
        
        if let value = dictionary[SportsieClient.JSONResponseKeys.AwayTeamFullName] {
            awayTeamFullName = String(describing: value)
        } else {
            awayTeamFullName = ""
        }
        
        if let value = dictionary[SportsieClient.JSONResponseKeys.MatchStartTime] {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
            dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
            startTime = dateFormatter.date(from: String(describing: value))
        } else {
            startTime = nil
        }
        
        if let value = dictionary[SportsieClient.JSONResponseKeys.PitchReport] {
            pitchReport = String(describing: value)
        } else {
            pitchReport = ""
        }
        
        if let value = dictionary[SportsieClient.JSONResponseKeys.Umpires] {
            umpires = String(describing: value)
        } else {
            umpires = ""
        }
        
        if let value = dictionary[SportsieClient.JSONResponseKeys.Weather] {
            weather = String(describing: value)
        } else {
            weather = ""
        }
        
        var batsmanDictionary: [String: String] = [:]
        
        if let value = dictionary[SportsieClient.JSONResponseKeys.BatsmanOneName] {
            batsmanDictionary[SportsieClient.JSONResponseKeys.Name] = String(describing: value)
        }
        if let value = dictionary[SportsieClient.JSONResponseKeys.BatsmanOneScore] {
            batsmanDictionary[SportsieClient.JSONResponseKeys.Score] = String(describing: value)
        }
        if let value = dictionary[SportsieClient.JSONResponseKeys.BatsmanOneBallsFaced] {
            batsmanDictionary[SportsieClient.JSONResponseKeys.BallsFaced] = String(describing: value)
        }
        if let value = dictionary[SportsieClient.JSONResponseKeys.BatsmanOneFours] {
            batsmanDictionary[SportsieClient.JSONResponseKeys.Fours] = String(describing: value)
        }
        if let value = dictionary[SportsieClient.JSONResponseKeys.BatsmanOneSixes] {
            batsmanDictionary[SportsieClient.JSONResponseKeys.Sixes] = String(describing: value)
        }
        if let value = dictionary[SportsieClient.JSONResponseKeys.BatsmanOneStrikeRate] {
            batsmanDictionary[SportsieClient.JSONResponseKeys.StrikeRate] = String(describing: value)
        }
        
        batsmen.append(Batsman(dictionary: batsmanDictionary))
        batsmanDictionary = [:]
        
        if let value = dictionary[SportsieClient.JSONResponseKeys.BatsmanTwoName] {
            batsmanDictionary[SportsieClient.JSONResponseKeys.Name] = String(describing: value)
        }
        if let value = dictionary[SportsieClient.JSONResponseKeys.BatsmanTwoScore] {
            batsmanDictionary[SportsieClient.JSONResponseKeys.Score] = String(describing: value)
        }
        if let value = dictionary[SportsieClient.JSONResponseKeys.BatsmanTwoBallsFaced] {
            batsmanDictionary[SportsieClient.JSONResponseKeys.BallsFaced] = String(describing: value)
        }
        if let value = dictionary[SportsieClient.JSONResponseKeys.BatsmanTwoFours] {
            batsmanDictionary[SportsieClient.JSONResponseKeys.Fours] = String(describing: value)
        }
        if let value = dictionary[SportsieClient.JSONResponseKeys.BatsmanTwoSixes] {
            batsmanDictionary[SportsieClient.JSONResponseKeys.Sixes] = String(describing: value)
        }
        if let value = dictionary[SportsieClient.JSONResponseKeys.BatsmanTwoStrikeRate] {
            batsmanDictionary[SportsieClient.JSONResponseKeys.StrikeRate] = String(describing: value)
        }
        
        batsmen.append(Batsman(dictionary: batsmanDictionary))
        var bowlerDictionary: [String: String] = [:]
        
        if let value = dictionary[SportsieClient.JSONResponseKeys.BowlerOneName] {
            bowlerDictionary[SportsieClient.JSONResponseKeys.Name] = String(describing: value)
        }
        if let value = dictionary[SportsieClient.JSONResponseKeys.BowlerOneRuns] {
            bowlerDictionary[SportsieClient.JSONResponseKeys.Runs] = String(describing: value)
        }
        if let value = dictionary[SportsieClient.JSONResponseKeys.BowlerOneOvers] {
            bowlerDictionary[SportsieClient.JSONResponseKeys.Overs] = String(describing: value)
        }
        if let value = dictionary[SportsieClient.JSONResponseKeys.BowlerOneExtras] {
            bowlerDictionary[SportsieClient.JSONResponseKeys.Extras] = String(describing: value)
        }
        if let value = dictionary[SportsieClient.JSONResponseKeys.BowlerOneWickets] {
            bowlerDictionary[SportsieClient.JSONResponseKeys.Wickets] = String(describing: value)
        }
        if let value = dictionary[SportsieClient.JSONResponseKeys.BowlerOneEconomy] {
            bowlerDictionary[SportsieClient.JSONResponseKeys.Economy] = String(describing: value)
        }
        
        bowlers.append(Bowler(dictionary: bowlerDictionary))
        bowlerDictionary = [:]
        
        if let value = dictionary[SportsieClient.JSONResponseKeys.BowlerTwoName] {
            bowlerDictionary[SportsieClient.JSONResponseKeys.Name] = String(describing: value)
        }
        if let value = dictionary[SportsieClient.JSONResponseKeys.BowlerTwoRuns] {
            bowlerDictionary[SportsieClient.JSONResponseKeys.Runs] = String(describing: value)
        }
        if let value = dictionary[SportsieClient.JSONResponseKeys.BowlerTwoOvers] {
            bowlerDictionary[SportsieClient.JSONResponseKeys.Overs] = String(describing: value)
        }
        if let value = dictionary[SportsieClient.JSONResponseKeys.BowlerTwoExtras] {
            bowlerDictionary[SportsieClient.JSONResponseKeys.Extras] = String(describing: value)
        }
        if let value = dictionary[SportsieClient.JSONResponseKeys.BowlerTwoWickets] {
            bowlerDictionary[SportsieClient.JSONResponseKeys.Wickets] = String(describing: value)
        }
        if let value = dictionary[SportsieClient.JSONResponseKeys.BowlerTwoEconomy] {
            bowlerDictionary[SportsieClient.JSONResponseKeys.Economy] = String(describing: value)
        }
        
        bowlers.append(Bowler(dictionary: bowlerDictionary))
    }
    
    static func matchesFromResults(_ results: [[String:AnyObject]]) -> [Match] {
        var matches = [Match]()
        
        for result in results {
            matches.append(Match(dictionary: result))
        }
        
        return matches
    }
}

struct Batsman {
    let name: String
    let score: String
    let ballsFaced: String
    let fours: String
    let sixes: String
    let strikeRate: String
    
    init(dictionary: [String: String]) {
        if let value = dictionary[SportsieClient.JSONResponseKeys.Name] {
            name = String(describing: value)
        } else {
            name = ""
        }
        if let value = dictionary[SportsieClient.JSONResponseKeys.Score] {
            score = String(describing: value)
        } else {
            score = ""
        }
        if let value = dictionary[SportsieClient.JSONResponseKeys.BallsFaced] {
            ballsFaced = String(describing: value)
        } else {
            ballsFaced = ""
        }
        if let value = dictionary[SportsieClient.JSONResponseKeys.Fours] {
            fours = String(describing: value)
        } else {
            fours = ""
        }
        if let value = dictionary[SportsieClient.JSONResponseKeys.Sixes] {
            sixes = String(describing: value)
        } else {
            sixes = ""
        }
        if let value = dictionary[SportsieClient.JSONResponseKeys.StrikeRate] {
            strikeRate = String(describing: value)
        } else {
            strikeRate = ""
        }
    }
}

struct Bowler {
    let name: String
    let overs: String
    let wickets: String
    let runs: String
    let economy: String
    
    init(dictionary: [String: String]) {
        if let value = dictionary[SportsieClient.JSONResponseKeys.Name] {
            name = String(describing: value)
        } else {
            name = ""
        }
        if let value = dictionary[SportsieClient.JSONResponseKeys.Runs] {
            runs = String(describing: value)
        } else {
            runs = ""
        }
        if let value = dictionary[SportsieClient.JSONResponseKeys.Overs] {
            overs = String(describing: value)
        } else {
            overs = ""
        }
        if let value = dictionary[SportsieClient.JSONResponseKeys.Wickets] {
            wickets = String(describing: value)
        } else {
            wickets = ""
        }
        if let value = dictionary[SportsieClient.JSONResponseKeys.Economy] {
            economy = String(describing: value)
        } else {
            economy = ""
        }
    }
    
}

struct Over {
    let over: String
    let runs: String
    let details: String
    
    init(dictionary: [String:AnyObject]) {
        if let value = dictionary[SportsieClient.JSONResponseKeys.Over] {
            over = String(describing: value)
        } else {
            over = ""
        }
        if let value = dictionary[SportsieClient.JSONResponseKeys.Runs] {
            runs = String(describing: value)
        } else {
            runs = ""
        }
        if let value = dictionary[SportsieClient.JSONResponseKeys.Details] {
            details = String(describing: value)
        } else {
            details = ""
        }
    }
    
    static func oversFromResults(_ results: [[String:AnyObject]]) -> [Over] {
        
        var overs = [Over]()
        
        for result in results {
            overs.append(Over(dictionary: result))
        }
        return overs
    }
}

struct Inning {
    let battingTeam: String
    let score: String
    
    init(dictionary: [String: AnyObject]) {
        if let value = dictionary[SportsieClient.JSONResponseKeys.BattingTeam] {
            battingTeam = String(describing: value)
        } else {
            battingTeam = ""
        }
        if let value = dictionary[SportsieClient.JSONResponseKeys.Score] {
            score = String(describing: value)
        } else {
            score = ""
        }
    }
    
    static func inningsFromResults(_ results: [[String:AnyObject]]) -> [Inning] {
        var innings = [Inning]()
        
        for result in results {
            let inning = Inning(dictionary: result)
            if inning.score != "0/0" {
                innings.append(Inning(dictionary: result))
            }
        }
        return innings
    }
}


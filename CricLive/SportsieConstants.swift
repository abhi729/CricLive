//
//  SportsieConstants.swift
//  CricLive
//
//  Created by Abhishek Agarwal on 28/07/17.
//  Copyright © 2017 Abhishek. All rights reserved.
//

import Foundation

extension SportsieClient {
    
    struct Constants {
        static let ApiScheme = "https"
        static let ApiHost = "ccapi.matchupcricket.com"
        static let SolutionCricket = "2"
        static let LanguageEnglish = "en"
        static let VersionTen = "10"
        static let DefaultMatchId = "0"
        static let UserGroupIdDefault = "1"
        static let CategoryDefault = "Video"
        static let CountDefault = "10"
    }
    
    struct Methods {
        static let Scores = "/cric/api/match/scores/"
        static let Articles = "/cric/api/articles/"
    }
    
    struct ParameterKeys {
        static let MatchId = "match_id"
        static let SolutionId = "solution_id"
        static let Version = "version"
        static let Language = "language"
        
        static let Solution = "solution"
        static let Id = "id"
        static let Direction = "direction"
        static let Category = "category"
        static let Count = "count"
        static let UserGroupId = "user_group_id"
    }
    
    // MARK: JSON Response Keys
    struct JSONResponseKeys {
        
        // MARK: General
        static let StatusMessage = "status_message"
        static let StatusCode = "status_code"
        static let IsLocked = "is_locked"
        static let Name = "name"
        
        // MARK: Account
        static let UserID = "id"
        
        // MARK: Article
        static let Category = "category"
        static let Data = "data"
        static let Url = "url"
        static let SummaryImage = "summary_image"
        static let Title = "title"
        static let User = "user"
        static let ImageUrl = "image_url"
        static let PageTime = "page_time"
        static let LookupId = "lookup_id"
        static let PageId = "page_id"
        
        //MARK: Match
        static let MatchGameDescription = "game_description"
        static let MatchToss = "toss"
        static let MatchStartTimeString = "start_time_string"
        static let MatchStartTime = "start_time"
        static let MatchCurrentScore = "current_score"
        static let MatchId = "match_id"
        static let MatchBattingTeamUrl = "batting_team_url"
        static let MatchBattingTeam = "batting_team"
        static let MatchRuns = "current_runs"
        static let MatchWickets = "current_total_wicket"
        static let MatchStatus = "status"
        static let MatchStatusId = "status_id"
        static let MatchHistory = "match_history_rev"
        static let MatchCRR = "crr"
        static let MatchRRR = "rrr"
        static let MatchBowlingTeam = "bowling_team"
        static let MatchTarget = "target"
        static let MatchOvers = "current_overs"
        static let HomeTeamName = "home_team_name"
        static let AwayTeamName = "away_team_name"
        static let HomeTeamUrl = "home_team_url"
        static let AwayTeamUrl = "away_team_url"
        
        //MARK: Scorecard
        static let MiniScorecard = "mini"
        static let FullScorecard = "fsc"
        static let MatchType = "match_type"
        static let RecentHistory = "recent_history"
        static let PreviousInnings = "previous_innings"
        static let Toss = "toss"
        static let Innings = "innings"
        static let HomeTeam = "home_team"
        static let AwayTeam = "away_team"
        static let OtherInfo = "other_info"
        static let PlayingEleven = "playing_xi"
        static let MatchInfo = "match_info"
        static let DidNotBat = "did_not_bat"
        static let CurrentScore = "currentscore"
        static let Partnership = "partnership"
        static let CurrentOver = "currentover"
        static let Wickets = "wickets"
        static let ExtrasText = "extras_txt"
        static let TeamFlagUrl = "team_flag_url"
        static let Team = "team"
        static let Bowling = "bowling"
        static let Batting = "batting"
        static let TotalExtras = "total_extras"
        static let Venue = "venue"
        static let PitchReport = "pitch_report"
        static let Umpires = "umpires"
        static let Weather = "weather"
        static let HomeTeamFullName = "home_team_full_name"
        static let AwayTeamFullName = "away_team_full_name"
        static let Score = "score"
        
        static let HowOut = "how_out"
        static let OutBatsmanName = "out_batsman_name"
        static let Runs = "runs"
        static let Wicket = "wicket"
        static let Overs = "overs"
        static let Over = "over"
        static let Details = "details"
        
        static let Bowler = "bowler"
        static let Extras = "extras"
        static let Economy = "economy"
        
        static let Sixes = "sixes"
        static let Batsman = "batsman"
        static let Fours = "fours"
        static let StrikeRate = "strike_rate"
        static let BallsFaced = "balls_faced"
        static let RunsScored = "runs_scored"
        
        static let ThirdUmpire = "third_umpire"
        static let OnFieldUmpires = "on_field_umpires"
        static let MatchReferee = "match_referee"
        
        static let AwayPlayers = "away_players"
        static let HomePlayers = "home_players"
        
        static let CompetitionName = "competition_name"
        static let MatchDateTime = "match_date_time"
        static let MatchDateTimeString = "match_date_time_str"
        
        static let BatsmanOneName = "batsman_1_name"
        static let BatsmanOneStrikeRate = "batsman_1_strike_rate"
        static let BatsmanOneScore = "batsman_1_score"
        static let BatsmanOneBallsFaced = "batsman_1_fb"
        static let BatsmanOneFours = "batsman_1_fours"
        static let BatsmanOneSixes = "batsman_1_sixes"
        
        static let BatsmanTwoName = "batsman_2_name"
        static let BatsmanTwoScore = "batsman_2_score"
        static let BatsmanTwoBallsFaced = "batsman_2_fb"
        static let BatsmanTwoStrikeRate = "batsman_2_strike_rate"
        static let BatsmanTwoFours = "batsman_2_fours"
        static let BatsmanTwoSixes = "batsman_2_sixes"
        
        static let BowlerOneName = "bowler_1_name"
        static let BowlerOneWickets = "bowler_1_wickets"
        static let BowlerOneExtras = "bowler_1_extras"
        static let BowlerOneOvers = "bowler_1_overs"
        static let BowlerOneRuns = "bowler_1_runs"
        static let BowlerOneEconomy = "bowler_1_economy"
        
        static let BowlerTwoExtras = "bowler_2_extras"
        static let BowlerTwoName = "bowler_2_name"
        static let BowlerTwoWickets = "bowler_2_wickets"
        static let BowlerTwoOvers = "bowler_2_overs"
        static let BowlerTwoRuns = "bowler_2_runs"
        static let BowlerTwoEconomy = "bowler_2_economy"
        
        static let BattingTeam = "batting_team"
    
    }
}

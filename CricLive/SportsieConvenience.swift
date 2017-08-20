//
//  SportsieConvenience.swift
//  CricLive
//
//  Created by Abhishek Agarwal on 28/07/17.
//  Copyright © 2017 Abhishek. All rights reserved.
//

import Foundation

extension SportsieClient {
    
    func getMatchScores(forId matchId: String, completionHandlerForMatch: @escaping (_ result: [Match]?, _ error: NSError?) -> Void) {
        
        let parameters = [
            ParameterKeys.MatchId: matchId,
            ParameterKeys.SolutionId: Constants.SolutionCricket,
            ParameterKeys.Version: Constants.VersionTen,
            ParameterKeys.Language: Constants.LanguageEnglish
        ]
        
        let _ = taskForGETMethod(Methods.Scores, parameters: parameters as [String: AnyObject]) { (results, error) in
            if let error = error {
                completionHandlerForMatch(nil, error)
            } else {
                
                if let results = results as? [[String: AnyObject]] {
                    let matches = Match.matchesFromResults(results)
                    completionHandlerForMatch(matches, nil)
                } else {
                    completionHandlerForMatch(nil, NSError(domain: "getMatchScores parsing", code: 0, userInfo: [NSLocalizedDescriptionKey: "Could not parse getMatchScores"]))
                }
            }
        }
    }
    
    func getArticles(forId id: String, direction: String, completionHandlerForArticles: @escaping (_ result: [NewsArticle]?, _ error: NSError?) -> Void) {
        
        let parameters = [
            ParameterKeys.Id: id,
            ParameterKeys.Solution: Constants.SolutionCricket,
            ParameterKeys.Direction: direction,
            ParameterKeys.Category: Constants.CategoryDefault,
            ParameterKeys.Count: Constants.CountDefault,
            ParameterKeys.UserGroupId: Constants.UserGroupIdDefault
        ]
        
        let _ = taskForGETMethod(Methods.Articles, parameters: parameters as [String: AnyObject]) { (results, error) in
            if let error = error {
                completionHandlerForArticles(nil, error)
            } else {
                
                if let results = results as? [[String: AnyObject]] {
                    let articles = NewsArticle.articlesFromResults(results)
                    completionHandlerForArticles(articles, nil)
                } else {
                    completionHandlerForArticles(nil, NSError(domain: "getArticles parsing", code: 0, userInfo: [NSLocalizedDescriptionKey: "Could not parse getArticles"]))
                }
            }
        }
    }
}

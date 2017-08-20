//
//  Article.swift
//  CricLive
//
//  Created by Abhishek Agarwal on 19/08/17.
//  Copyright © 2017 Abhishek. All rights reserved.
//

import Foundation

struct NewsArticle {
    let category: String!
    let articleUrl: String!
    let summaryImage: String!
    let title: String!
    let userName: String!
    let pageTime: Date!
    let lookupId: Int!
    let pageId: String!
    
    init(dictionary: [String: AnyObject]) {
        category = dictionary[SportsieClient.JSONResponseKeys.Category] as! String
        if let data = dictionary[SportsieClient.JSONResponseKeys.Data] as? [String: AnyObject], let url =  data[SportsieClient.JSONResponseKeys.Url] as? [String: AnyObject], let user = data[SportsieClient.JSONResponseKeys.User] as? [String: AnyObject] {
            articleUrl = url[SportsieClient.JSONResponseKeys.Url] as! String
            summaryImage = url[SportsieClient.JSONResponseKeys.SummaryImage] as! String
            title = url[SportsieClient.JSONResponseKeys.Title] as! String
            userName = user[SportsieClient.JSONResponseKeys.Name] as! String
        } else {
            articleUrl = ""
            summaryImage = ""
            title = ""
            userName = ""
        }
        let df = DateFormatter()
        df.dateFormat = "yyyy/MM/dd HH:mm:ss"
        df.timeZone = TimeZone(abbreviation: "GMT")
        pageTime = df.date(from: dictionary[SportsieClient.JSONResponseKeys.PageTime] as! String)!
        lookupId = dictionary[SportsieClient.JSONResponseKeys.LookupId] as! Int
        pageId = dictionary[SportsieClient.JSONResponseKeys.PageId] as! String
    }
    
    static func articlesFromResults(_ results: [[String: AnyObject]]) -> [NewsArticle] {
        var articles = [NewsArticle]()
        
        for result in results {
            articles.append(NewsArticle(dictionary: result))
        }
        
        return articles
    }
}

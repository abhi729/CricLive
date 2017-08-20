//
//  Article+CoreDataClass.swift
//  CricLive
//
//  Created by Abhishek Agarwal on 19/08/17.
//  Copyright © 2017 Abhishek. All rights reserved.
//

import Foundation
import CoreData


public class Article: NSManagedObject {
    
    override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
    }
    
    init(article: NewsArticle, imageData: Data?, context: NSManagedObjectContext) {
        guard let articleEntity = NSEntityDescription.entity(forEntityName: "Article", in: context) else {
            fatalError("Could not create Article Entity Description!")
        }
        
        super.init(entity: articleEntity, insertInto: context)
        self.articleUrl = article.articleUrl
        self.category = article.category
        self.lookupId = Int32(article.lookupId)
        self.pageTime = article.pageTime as NSDate
        self.summaryImageUrl = article.summaryImage
        self.title = article.title
        self.userName = article.userName
        if imageData != nil {
            self.summaryImage = NSData(data: imageData!)
        } else {
            self.summaryImage = nil
        }
    }
}

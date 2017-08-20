//
//  Article+CoreDataProperties.swift
//  CricLive
//
//  Created by Abhishek Agarwal on 19/08/17.
//  Copyright © 2017 Abhishek. All rights reserved.
//

import Foundation
import CoreData


extension Article {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Article> {
        return NSFetchRequest<Article>(entityName: "Article")
    }

    @NSManaged public var lookupId: Int32
    @NSManaged public var category: String?
    @NSManaged public var articleUrl: String?
    @NSManaged public var summaryImageUrl: String?
    @NSManaged public var summaryImage: NSData?
    @NSManaged public var pageTime: NSDate?
    @NSManaged public var title: String?
    @NSManaged public var userName: String?

}

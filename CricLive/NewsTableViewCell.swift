//
//  NewsTableViewCell.swift
//  CricLive
//
//  Created by Abhishek Agarwal on 19/08/17.
//  Copyright © 2017 Abhishek. All rights reserved.
//

import UIKit

class NewsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var newsImageView: UIImageView!
    @IBOutlet weak var videoImageView: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    
    var lookupId: String = "0"
    var articleUrl: String = ""
    
}

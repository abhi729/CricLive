//
//  NewsViewController+Delegates.swift
//  CricLive
//
//  Created by Abhishek Agarwal on 20/08/17.
//  Copyright © 2017 Abhishek. All rights reserved.
//

import UIKit
import CoreData

extension NewsViewController : NSFetchedResultsControllerDelegate {
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        tableView.reloadData()
    }
}

extension NewsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let sectionInfo = fetchedResultsController.sections {
            return sectionInfo[section].numberOfObjects
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let article = fetchedResultsController.object(at: indexPath) as! Article
        let cell = tableView.dequeueReusableCell(withIdentifier: "articleCell", for: indexPath) as! NewsTableViewCell
        cell.selectionStyle = .none
        cell.lookupId = "\(article.lookupId)"
        cell.articleUrl = article.articleUrl!
        cell.titleLabel.text = article.title
        cell.summaryLabel.text = ""
        cell.userNameLabel.text = article.userName
        if let pageTime = article.pageTime as Date? {
            cell.durationLabel.text = getDurationText(pageTime)
        } else {
            cell.durationLabel.text = ""
        }
        if article.summaryImage == nil {
            cell.videoImageView.isHidden = true
            cell.activityIndicator.startAnimating()
            
            DispatchQueue.global(qos: DispatchQoS.background.qosClass).async {
                do {
                    let data = try Data(contentsOf: URL(string: article.summaryImageUrl!)!)
                    let image = UIImage(data: data)
                    DispatchQueue.main.async {
                        cell.activityIndicator.stopAnimating()
                        cell.newsImageView.image = image
                        article.summaryImage = NSData(data: data)
                        let delegate = UIApplication.shared.delegate as! AppDelegate
                        delegate.stack.save()
                        return
                    }
                }
                catch {
                    return
                }
            }
        } else {
            cell.videoImageView.isHidden = false
            cell.newsImageView.image = UIImage(data: article.summaryImage! as Data)
        }
        return cell
    }
}

extension NewsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? NewsTableViewCell {
            let urlComponents = cell.articleUrl.components(separatedBy: "v=")
            if urlComponents.count == 2 {
                let videoUrlString = "youtube://watch?v=" + urlComponents[1]
                if let url = URL(string: videoUrlString), UIApplication.shared.canOpenURL(url) {
                    openArticleUrl(url: url)
                } else if let url = URL(string: cell.articleUrl), UIApplication.shared.canOpenURL(url) {
                    openArticleUrl(url: url)
                }
            }
        }
    }
    
    func openArticleUrl(url: URL) {
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url, options: [:], completionHandler: { (success) in
                if !success {
                    print("Oops! There was some error")
                }
            })
        } else {
            UIApplication.shared.openURL(url)
        }
    }
}



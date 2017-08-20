//
//  NewsViewController.swift
//  CricLive
//
//  Created by Abhishek Agarwal on 19/08/17.
//  Copyright © 2017 Abhishek. All rights reserved.
//

import UIKit
import CoreData

class NewsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var articlesActivityIndicator: UIActivityIndicatorView!
    var refreshControl: UIRefreshControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadfetchedResultsController()
        
        tableView.estimatedRowHeight = 130
        tableView.rowHeight = UITableViewAutomaticDimension
        
        refreshControl = UIRefreshControl()
        refreshControl.tintColor = UIColor.gray
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to fetch latest news!")
        refreshControl.addTarget(self, action: #selector(NewsViewController.fetchNews), for: UIControlEvents.valueChanged)
        tableView.addSubview(refreshControl)
    }
    
    lazy var fetchedResultsController: NSFetchedResultsController<NSFetchRequestResult> = {
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Article")
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "pageTime", ascending: false)]
        
        let delegate = UIApplication.shared.delegate as! AppDelegate
        let fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: delegate.stack.context, sectionNameKeyPath: nil, cacheName: nil)
        
        return fetchedResultsController
    }()
    
    func loadfetchedResultsController() {
        fetchedResultsController.delegate = self
        
        //get results from the fetchedResultsController
        do {
            try self.fetchedResultsController.performFetch()
        } catch {
            let fetchError = error as NSError
            print("\(fetchError), \(fetchError.userInfo)")
            alertUI(withTitle: "Failed Query", message: "Failed to load articles")
        }
    }
    
    func fetchNews() {
        var id = "0"
        var direction = "0"
        if refreshControl.isRefreshing {
            if let cell = tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? NewsTableViewCell {
                id = "\(cell.lookupId)"
            }
            direction = "1"
            refreshControl.attributedTitle = NSAttributedString(string: "Fetching latest news..")
        } else {
            articlesActivityIndicator.startAnimating()
        }
        SportsieClient.sharedInstance().getArticles(forId: id, direction: direction) { (articlesArray, error) in
            guard error == nil else {
                return
            }
            guard let articles = articlesArray else {
                return
            }
            DispatchQueue.main.async {
                self.articlesActivityIndicator.stopAnimating()
                let delegate = UIApplication.shared.delegate as! AppDelegate
                for article in articles {
                    do {
                        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Article")
                        let predicate = NSPredicate(format: "articleUrl = %@", argumentArray: [article.articleUrl])
                        fetchRequest.predicate = predicate
                        let count = try delegate.stack.context.count(for: fetchRequest)
                        if count == 0 {
                            let _ = Article(article: article, imageData: nil, context: delegate.stack.context)
                        }
                    } catch {
                        print("Error \(error)")
                    }
                }
                delegate.stack.save()
                if self.refreshControl.isRefreshing {
                    self.refreshControl.endRefreshing()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                        self.refreshControl.attributedTitle = NSAttributedString(string: "Pull to fetch latest news!")
                    })
                }
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        fetchNews()
    }
    
    func getDurationText(_ date: Date!) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
        let duration = Date().timeIntervalSince(date)
        let seconds = Int(duration)
        if seconds < 0 {
            return "0s"
        } else if seconds >= 60 {
            let minutes = seconds / 60
            if minutes >= 60 {
                let hours = minutes / 60
                if hours >= 24 {
                    let days = hours / 24
                    return "\(days)d"
                } else {
                    return ("\(hours)h")
                }
            } else {
                return ("\(minutes)m")
            }
        } else {
            return ("\(seconds)s")
        }
    }
    
}


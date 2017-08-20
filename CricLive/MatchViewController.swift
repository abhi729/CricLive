//
//  MatchViewController.swift
//  CricLive
//
//  Created by Abhishek Agarwal on 28/07/17.
//  Copyright © 2017 Abhishek. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func alertUI(withTitle title:String, message:String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
}

class MatchViewController: UIViewController {
    
    @IBOutlet weak var matchTableView: UITableView!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    
    var matches: [Match] = []

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        activityIndicatorView.startAnimating()
        SportsieClient.sharedInstance().getMatchScores(forId: SportsieClient.Constants.DefaultMatchId) { (matchArray, error) in
            guard error == nil else {
                return
            }
            guard matchArray != nil else {
                return
            }
            self.matches = matchArray!
            DispatchQueue.main.async {
                self.activityIndicatorView.stopAnimating()
                self.matchTableView.reloadData()
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SegueToMatch" {
            let vc = segue.destination as! MatchDetailController
            let match = sender as! Match
            vc.match = match
        }
    }

}


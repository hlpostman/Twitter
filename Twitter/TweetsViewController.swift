//
//  TweetsViewController.swift
//  Twitter
//
//  Created by Aristotle on 2017-02-21.
//  Copyright © 2017 HLPostman. All rights reserved.
//

import UIKit
import AFNetworking

class TweetsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

   
    @IBOutlet weak var tableView: UITableView!
    var tweets: [Tweet]!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 120
        
        TwitterClient.sharedInstance!.homeTimeline(success: { (tweets: [Tweet]) in
            
            self.tweets = tweets // self for persistence
//            self.tableView.reloadData()
            print("I'm the tweets vc! XO")
            
            }, failure: { (error: Error?) -> () in
                print(error!.localizedDescription)
        })
        
        // Do any additional setup after loading the view.
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(self.tweets?.count, "tweet count")
        return self.tweets?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TweetCell", for: indexPath) as! TweetCell
        let tweet = tweets[indexPath.row]
        cell.nameLabel.text = tweet.user?.name!
        cell.handleLabel.text = tweet.user?.screenname!
        cell.tweetTextLabel.text = tweet.text!
        cell.profilPicImageView.setImageWith(tweet.user?.profileURL as! URL)
        cell.timeSincePostLabel.text = ""
//        cell.replyCountLabel.text = 
//        cell.replyIconImageView.setImageWith(<#T##url: URL##URL#>)

        cell.retweetCountLabel.text = String(tweet.retweetCount)
        cell.retweetIconImageView.image = UIImage(named: "retweet-icon")
        cell.likesCountLabel.text = String(tweet.likeCount)
        cell.likesIconImageView.image = UIImage(named: "favor-icon")
        
        
        return cell
    }

    @IBAction func onLogoutButton(_ sender: AnyObject) {
        TwitterClient.sharedInstance!.logout()
    }
    
    func onRetweet() {
        
    }
    
    func onLike() {
        
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

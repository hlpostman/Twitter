//
//  ProfileViewController.swift
//  Twitter
//
//  Created by Aristotle on 2017-03-03.
//  Copyright © 2017 HLPostman. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var user: User!
    var tweet: Tweet!
    var recentTweets: [Tweet]!
    
    @IBOutlet weak var bannerImageView: UIImageView!
    @IBOutlet weak var profilePicImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var handleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var totalTweetsCountLabel: UILabel!
    @IBOutlet weak var followingCountLabel: UILabel!
    @IBOutlet weak var followerCountLabel: UILabel!

    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        // Strings
        nameLabel.text = user.name!
        handleLabel.text = "@\(user.screenname!)"
        descriptionLabel.text = user.tagline!
        
        // Numbers
        totalTweetsCountLabel.text = String(user.tweetsCount)
        followingCountLabel.text = String(user.followingCount)
        followerCountLabel.text = String(user.followerCount)
        
        // Images
        profilePicImageView.setImageWith(user.profileURL as! URL)
        if user.profileBannerImageURL != nil {
        bannerImageView.setImageWith(user.profileBannerImageURL as! URL)
        }
        
       
        //        tableView.delegate = self
        //        tableView.dataSource = self
        //        tableView.rowHeight = UITableViewAutomaticDimension
        //        tableView.estimatedRowHeight = 120
        
        TwitterClient.sharedInstance!.recentTweetsFromUser(success: { (tweets: [Tweet]) in
            
            self.recentTweets = tweets // self for persistence
//            self.tableView.reloadData()
            print("😍We got this user's recent tweets")
            
            }, failure: { (error: Error?) -> () in
                print(error!.localizedDescription)
        })
        
        // Do any additional setup after loading the view.
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.recentTweets?.count ?? 0
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TweetCell", for: indexPath) as! TweetCell
        
        // Configure cell
        let tweet = recentTweets[indexPath.row]
        cell.tweet = tweet
        cell.nameLabel.text = tweet.user?.name!
        cell.handleLabel.text = "@\(tweet.user!.screenname!)"
        cell.tweetTextLabel.text = tweet.text!
        cell.profilPicImageView.setImageWith(tweet.user?.profileURL as! URL)
        cell.profilPicImageView.layer.cornerRadius = 2
        cell.profilPicImageView.clipsToBounds = true
        cell.timeSincePostLabel.text = tweet.formatTimestamp(tweet.rawTimestamp!)
        cell.replyCountLabel.text = ""
        
        cell.selectionStyle = .none
        
        // Set retweet icon
        cell.retweetButton.setImage(UIImage(named: "retweet-icon"), for: UIControlState())
        cell.retweetCountLabel.text = String(tweet.retweetCount)
        
        cell.likeButton.setImage(UIImage(named: "favor-icon"), for: UIControlState())
        
        cell.likesCountLabel.text = String(tweet.likeCount)
        
        // Set delegate for profile tap
//        cell.delegate = self
        cell.tag = indexPath.row
        return cell
    }

    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

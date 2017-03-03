//
//  TweetDetailsViewController.swift
//  Twitter
//
//  Created by Aristotle on 2017-03-03.
//  Copyright © 2017 HLPostman. All rights reserved.
//

import UIKit

class TweetDetailsViewController: UIViewController {

    
    @IBOutlet weak var followButton: UIButton!
    @IBOutlet weak var profilePicImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var handleLabel: UILabel!
    @IBOutlet weak var tweetTextLabel: UILabel!
    @IBOutlet weak var bigRetweetsLabel: UILabel!
    @IBOutlet weak var bigLikesLabel: UILabel!
    @IBOutlet weak var timestampLabel: UILabel!
    @IBOutlet weak var replyCountLabel: UILabel!
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var smallRetweetCountLabel: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var smallLikesCountLabel: UILabel!
    
    var tweet: Tweet!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        profilePicImageView.setImageWith(tweet.user?.profileURL as! URL)
        nameLabel.text = tweet.user?.name!
        handleLabel.text = tweet.user?.screenname!
        tweetTextLabel.text = tweet.text!
        profilePicImageView.layer.cornerRadius = 2
        profilePicImageView.clipsToBounds = true
        timestampLabel.text = tweet.formatTimestamp(tweet.rawTimestamp!)
        replyCountLabel.text = ""
        bigRetweetsLabel.text = String(tweet.retweetCount)
        bigLikesLabel.text = String(tweet.likeCount)
        smallRetweetCountLabel.text = String(tweet.retweetCount)
        smallLikesCountLabel.text = String(tweet.likeCount)
        
        // Set retweet icon
        if tweet.retweeted {
            retweetButton.setImage(UIImage(named: "retweet-icon-green"), for: UIControlState())
        } else {
            retweetButton.setImage(UIImage(named: "retweet-icon"), for: UIControlState())
        }
        
        
        // Set like icon
        if tweet.liked {
            likeButton.setImage(UIImage(named: "favor-icon-red"), for: UIControlState())
        } else {
            likeButton.setImage(UIImage(named: "favor-icon"), for: UIControlState())
        }
        
        
        // Do any additional setup after loading the view.
    }

    
    @IBAction func onRetweet(_ sender: AnyObject) {
        let path = tweet.id
        
        if tweet.retweeted == false {
            TwitterClient.sharedInstance!.retweet(id: path, params: nil) { (error) -> () in
                print("Retweeting from TweetsDetailViewController")
                self.tweet.retweetCount += 1
                self.tweet.retweeted = true
                // Reload data
                self.retweetButton.setImage(UIImage(named: "retweet-icon-green"), for: UIControlState())
                self.bigRetweetsLabel.text = String(self.tweet.retweetCount)
                self.smallRetweetCountLabel.text = String(self.tweet.retweetCount)

            }
        } else if tweet.retweeted == true {
            TwitterClient.sharedInstance!.unretweet(id: path, params: nil, completion: { (error) -> () in
                print("Unretweeting from TweetsDetailViewController")
                self.tweet.retweetCount -= 1
                self.tweet.retweeted = false
                // Reload data
                self.retweetButton.setImage(UIImage(named: "retweet-icon"), for: UIControlState())
                self.bigRetweetsLabel.text = String(self.tweet.retweetCount)
                self.smallRetweetCountLabel.text = String(self.tweet.retweetCount)
            })
        }
    
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

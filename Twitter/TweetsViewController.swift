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
        cell.retweetButton.setImage(UIImage(named: "retweet-icon"), for: .normal)
        cell.retweetButton.setImage(UIImage(named: "retweet-icon-green"), for: .selected)
        cell.likesCountLabel.text = String(tweet.likeCount)
        cell.likeButton.setImage(UIImage(named: "favor-icon") , for: .normal)
        cell.likeButton.setImage(UIImage(named: "favor-icon-red"), for: .selected)
        
        
        return cell
    }

    @IBAction func onLogoutButton(_ sender: AnyObject) {
        TwitterClient.sharedInstance!.logout()
    }
    

    @IBAction func onRetweet(_ sender: AnyObject) {
        let button = sender as! UIButton
        let view = button.superview!
        // Why are we able to get the cell from the superview with the line below?
        let cell = view.superview as! TweetCell
        // Specify a cell
        let indexPath = tableView.indexPath(for: cell)
        // Why do we unwrap tweets and indexPath in the line below but not in the cellForRowAt function above?
        let tweet = tweets![indexPath!.row]
        cell.retweetButton.setImage(UIImage(named: "retweet-icon-green"), for: UIControlState())
        
        let path = tweet.id
        if tweet.retweeted == false {
            TwitterClient.sharedInstance!.retweet(id: path, params: nil) { (error) -> () in
                print("Retweeting from TweetsViewController")
                self.tweets![indexPath!.row].retweetCount += 1
                tweet.retweeted = true
                cell.retweetButton.setImage(UIImage(named: "retweet-icon-green"), for: UIControlState())
                self.tableView.reloadData()
            }
        } else if tweet.retweeted == true {
                TwitterClient.sharedInstance!.unretweet(id: path, params: nil, completion: { (error) -> () in
                    print("Unretweeting from TweetsViewController")
                    self.tweets![indexPath!.row].retweetCount -= 1
                    tweet.retweeted = false
                    cell.retweetButton.setImage(UIImage(named: "retweet-icon"), for: UIControlState())
                    self.tableView.reloadData()
            })
        }
    
    }
    
    @IBAction func onLike(_ sender: AnyObject) {
        let button = sender as! UIButton
        let view = button.superview!
        let cell = view.superview as! TweetCell
        
        let indexPath = tableView.indexPath(for: cell)
        let tweet = tweets![indexPath!.row]
        
        let path = tweet.id
        if tweet.liked == false {
            TwitterClient.sharedInstance!.like(id: path, params: nil) { (error) -> () in
                print("Liking from TweetsViewController")
                self.tweets![indexPath!.row].likeCount += 1
                tweet.liked = true
                cell.likeButton.setImage(UIImage(named: "favor-icon-red"), for: UIControlState())
                self.tableView.reloadData()
            }
        } else if tweet.liked == true {
            TwitterClient.sharedInstance!.unLike(id: path, params: nil, completion:  { (error) -> () in
                print("Unliking from TweetsViewController")
                self.tweets![indexPath!.row].likeCount -= 1
                tweet.liked = false
                cell.likeButton.setImage(UIImage(named: "favor-icon"), for: UIControlState())
                self.tableView.reloadData()
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

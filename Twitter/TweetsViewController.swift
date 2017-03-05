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
            self.tableView.reloadData()
            print("I'm the tweets vc")
            
            }, failure: { (error: Error?) -> () in
                print(error!.localizedDescription)
        })
        
        // Do any additional setup after loading the view.
        let customCellNib = UINib(nibName: "TweetCell", bundle: nil)
        tableView.register(customCellNib, forCellReuseIdentifier: "TweetCell")
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("viewWillAppear")
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(self.tweets?.count, "tweet count")
        return self.tweets?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TweetCell", for: indexPath) as! TweetCell
        
        // Configure cell
        let tweet = tweets[indexPath.row]
        cell.commonInit(tweet: tweet)
//        cell.tweet = tweet
//        cell.nameLabel.text = tweet.user?.name!
//        cell.handleLabel.text = "@\(tweet.user!.screenname!)"
//        cell.tweetTextLabel.text = tweet.text!
//        cell.profilPicImageView.setImageWith(tweet.user?.profileURL as! URL)
//        cell.profilPicImageView.layer.cornerRadius = 2
//        cell.profilPicImageView.clipsToBounds = true
//        cell.timeSincePostLabel.text = tweet.formatTimestamp(tweet.rawTimestamp!)
//        cell.replyCountLabel.text = ""
//
        cell.selectionStyle = .none
        
//        // Set retweet icon
//        if tweet.retweeted {
//            cell.retweetButton.setImage(UIImage(named: "retweet-icon-green"), for: UIControlState())
//        } else {
//            cell.retweetButton.setImage(UIImage(named: "retweet-icon"), for: UIControlState())
//        }
//        cell.retweetCountLabel.text = String(tweet.retweetCount)
//        
//        // Set like icon
//        if tweet.liked {
//            cell.likeButton.setImage(UIImage(named: "favor-icon-red"), for: UIControlState())
//        } else {
//            cell.likeButton.setImage(UIImage(named: "favor-icon"), for: UIControlState())
//        }
//        cell.likesCountLabel.text = String(tweet.likeCount)
        
        // Set delegate for profile tap
//        cell.delegate = self
//        cell.tag = indexPath.row
        return cell
    }
    
//    func popOverTweetDetail(_ sender: UITapGestureRecognizer) {
//        print("Getting detail view")
//        self.performSegue(withIdentifier: "detailsViewSegue", sender: self)
//        let indexPath = NSIndexPath(row: sender.view!.tag, section: 0)
//        let sendingCell = tableView.cellForRow(at: indexPath as IndexPath) as! TweetCell
//        print("Sending cell is a tweet from \(sendingCell.nameLabel.text!)")
//    }

    @IBAction func onLogoutButton(_ sender: AnyObject) {
        TwitterClient.sharedInstance!.logout()
    }
    
    @IBAction func onRetweet(_ sender: AnyObject) {
        let button = sender as! UIButton
        let view = button.superview!
        let cell = view.superview as! TweetCell
        // Specify a cell
        let indexPath = tableView.indexPath(for: cell)
        let tweet = tweets![indexPath!.row]
        let path = tweet.id
        
        if tweet.retweeted == false {
            TwitterClient.sharedInstance!.retweet(id: path, params: nil) { (error) -> () in
                print("Retweeting from TweetsViewController")
                self.tweets![indexPath!.row].retweetCount += 1
                tweet.retweeted = true
                self.tableView.reloadData()
            }
        } else if tweet.retweeted == true {
                TwitterClient.sharedInstance!.unretweet(id: path, params: nil, completion: { (error) -> () in
                    print("Unretweeting from TweetsViewController")
                    self.tweets![indexPath!.row].retweetCount -= 1
                    tweet.retweeted = false
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
                self.tableView.reloadData()
            }
        } else if tweet.liked == true {
            TwitterClient.sharedInstance!.unLike(id: path, params: nil, completion:  { (error) -> () in
                print("Unliking from TweetsViewController")
                self.tweets![indexPath!.row].likeCount -= 1
                tweet.liked = false
                self.tableView.reloadData()
            })
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "detailViewSegue") {
            
            let cell = sender as! UITableViewCell
            let indexPath = tableView.indexPath(for: cell)
            let tweetData = tweets[(indexPath?.row)!]
            let detailViewController = segue.destination as! TweetDetailsViewController
    
            detailViewController.tweet = tweetData
            
        } else if (segue.identifier == "composeSegue") {
            print("Called composeSegue")
            let composeViewController = segue.destination as! ComposeViewController

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

extension TweetsViewController: TweetTableViewCellDelegate{
    func profileImageViewTapped(cell: TweetCell, user: User) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let profileVC = storyboard.instantiateViewController(withIdentifier: "ProfileViewController" ) as? ProfileViewController {
            profileVC.user = user //set the profile user before your push
            self.navigationController?.pushViewController(profileVC, animated: true)
        }
    }
}

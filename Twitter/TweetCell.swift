//
//  TweetCell.swift
//  Twitter
//
//  Created by Aristotle on 2017-02-25.
//  Copyright © 2017 HLPostman. All rights reserved.
//

import UIKit

protocol TweetTableViewCellDelegate: class  {
    func profileImageViewTapped(cell: TweetCell, user: User)
}
class TweetCell: UITableViewCell {
    var tweet: Tweet!
    @IBOutlet weak var profilPicImageView: UIImageView! {
        didSet{
            self.profilPicImageView.isUserInteractionEnabled = true //make sure this is enabled
            //tap for userImageView
            let userProfileTap = UITapGestureRecognizer(target: self, action: #selector(userProfileTapped(_:)))
            self.profilPicImageView.addGestureRecognizer(userProfileTap)
            
        }
    }
    
    func userProfileTapped(_ gesture: UITapGestureRecognizer) {
        if let delegate = delegate{
            delegate.profileImageViewTapped(cell: self, user: self.tweet.user!)
        }
    }
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var handleLabel: UILabel!
    @IBOutlet weak var timeSincePostLabel: UILabel!
    @IBOutlet weak var tweetTextLabel: UILabel!
    @IBOutlet weak var replyIconImageView: UIImageView!
    @IBOutlet weak var replyCountLabel: UILabel!
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var retweetCountLabel: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var likesCountLabel: UILabel!
    
    weak var delegate: TweetTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func commonInit(tweet: Tweet) {
    
        // Stings
        nameLabel.text = tweet.user?.name!
        handleLabel.text = "@\(tweet.user!.screenname!)"
        timeSincePostLabel.text = tweet.formatTimestamp(tweet.rawTimestamp!)
        tweetTextLabel.text = tweet.text!
        replyCountLabel.text = ""
        
        // Numbers
        retweetCountLabel.text = String(tweet.retweetCount)
        likesCountLabel.text = String(tweet.likeCount)
        
        // Images
        profilPicImageView.setImageWith(tweet.user?.profileURL as! URL)
        profilPicImageView.layer.cornerRadius = 2
        profilPicImageView.clipsToBounds = true
        
        // Button icon for Retweet Button
        if tweet.retweeted {
            retweetButton.setImage(UIImage(named: "retweet-icon-green"), for: UIControlState())
        } else {
            retweetButton.setImage(UIImage(named: "retweet-icon"), for: UIControlState())
        }
        // Button icon for Like Button
        if tweet.liked {
            likeButton.setImage(UIImage(named: "favor-icon-red"), for: UIControlState())
        } else {
            likeButton.setImage(UIImage(named: "favor-icon"), for: UIControlState())
        }
        
    }

}

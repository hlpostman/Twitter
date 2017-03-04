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
    var tweet: Tweet!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

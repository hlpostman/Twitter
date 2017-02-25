//
//  TweetCell.swift
//  Twitter
//
//  Created by Aristotle on 2017-02-25.
//  Copyright © 2017 HLPostman. All rights reserved.
//

import UIKit

class TweetCell: UITableViewCell {

    @IBOutlet weak var profilPicImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var handleLabel: UILabel!
    @IBOutlet weak var timeSincePostLabel: UILabel!
    @IBOutlet weak var tweetTextLabel: UILabel!
    @IBOutlet weak var replyIconImageView: UIImageView!
    @IBOutlet weak var replyCountLabel: UILabel!
    @IBOutlet weak var retweetIconImageView: UIImageView!
    @IBOutlet weak var retweetCountLabel: UILabel!
    @IBOutlet weak var likesIconImageView: UIImageView!
    @IBOutlet weak var likesCountLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

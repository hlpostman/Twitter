//
//  DetailView.swift
//  Twitter
//
//  Created by Aristotle on 2017-03-02.
//  Copyright © 2017 HLPostman. All rights reserved.
//

import Foundation
import UIKit

class DetailView: UIView {


    @IBOutlet weak var view: UIView!
    @IBOutlet weak var mainParentView: UIView!
    @IBOutlet weak var profilePicImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var handleLabel: UILabel!
    @IBOutlet weak var tweetTextLabel: UILabel!
   
    @IBOutlet weak var bigRetweetCountLabel: UILabel!
    @IBOutlet weak var bigLikeCountLabel: UILabel!

    @IBOutlet weak var timePostedLabel: UILabel!
    
    @IBOutlet weak var replyButton: UIButton!
    @IBOutlet weak var replyCountLabel: UILabel!
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var smallRetweetCountLabel: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var smallLikeCountLabel: UILabel!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadFromXib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadFromXib()
//        fatalError("init(coder:) has not been implemented")
    }
    
    func loadFromXib() -> Void {
        Bundle.main.loadNibNamed("DetailView", owner: self, options: nil)
        view.frame = self.frame
        view.backgroundColor = UIColor.red
        mainParentView.layer.cornerRadius = 5
        view.layoutIfNeeded()
        self.addSubview(view)
    }

}

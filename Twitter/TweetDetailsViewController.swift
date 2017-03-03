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
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var smallRetweetCountLabel: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var smallLikesCountLabel: UILabel!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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

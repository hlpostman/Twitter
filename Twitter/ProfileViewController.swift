//
//  ProfileViewController.swift
//  Twitter
//
//  Created by Aristotle on 2017-03-03.
//  Copyright © 2017 HLPostman. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    var user: User!
    var tweet: Tweet!
    
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

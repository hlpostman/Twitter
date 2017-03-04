//
//  User.swift
//  Twitter
//
//  Created by Aristotle on 2017-02-21.
//  Copyright © 2017 HLPostman. All rights reserved.
//

import UIKit

class User: NSObject {
    var name: String?
    var screenname: String?
    var profileURL: NSURL?
    var tagline: String?
    var profileBannerImageURL: NSURL?
    var tweetsCount: Int
    var followingCount: Int
    var followerCount: Int
    
    var dictionary: NSDictionary?
    
    init(dictionary: NSDictionary) {
        self.dictionary = dictionary
        
        // Strings
        name = dictionary["name"] as? String
        screenname = dictionary["screen_name"] as? String
        tagline = dictionary["description"] as? String
        
        // Numbers
        tweetsCount = dictionary["statuses_count"] as! Int
        followingCount = dictionary["followers_count"] as! Int
        followerCount = dictionary["friends_count"] as! Int
        
        // User images
        let profileUrlString = dictionary["profile_image_url_https"] as? String
        if let profileUrlString = profileUrlString {
            profileURL = NSURL(string: profileUrlString)
        }
        let profileBannerString = dictionary["profile_banner_url"] as? String
        if let profileBannerString = profileBannerString {
            profileBannerImageURL = NSURL(string: profileBannerString)
        }
        
       
        
    }
    
    static let logoutNotification = "userDidLogout"
    
    static var _currentUser: User?
    
    class var currentUser: User? {
        get {
            if _currentUser == nil {
                let defaults = UserDefaults.standard
                
                let userData = defaults.object(forKey: "currentUserData") as? NSData
                
                if let userData = userData {
                    let dictionary = try! JSONSerialization.jsonObject(with: userData as Data, options: [])
                    _currentUser = User(dictionary: dictionary as! NSDictionary)
                }
            }
            
            return _currentUser
        }
        set(user) {
            _currentUser = user
            let defaults = UserDefaults.standard
            
            if let user = user {
                let data = try! JSONSerialization.data(withJSONObject: user.dictionary!, options: [])
                
                defaults.set(data, forKey: "currentUserData")
            } else {
                defaults.removeObject(forKey: "currentUserData")
            }
            defaults.synchronize()
        }

    }
}

//
//  Tweet.swift
//  Twitter
//
//  Created by Aristotle on 2017-02-21.
//  Copyright © 2017 HLPostman. All rights reserved.
//

import UIKit

class Tweet: NSObject {
    
    var user: User?
    var id: Int
    var text: String?
    var retweetCount: Int = 0
    var likeCount: Int = 0
    var timestamp: NSDate?
    var retweeted: Bool
    var liked: Bool
    
    init(dictionary: NSDictionary) {
        
        user = User(dictionary: dictionary["user"] as! NSDictionary)
        
        id = dictionary["id"] as! Int
        // Strings and Integers
        text = dictionary["text"] as?
        String
        
        retweeted = dictionary["retweeted"] as! Bool
        retweetCount = (dictionary["retweet_count"] as? Int) ?? 0
        
        liked = dictionary["favorited"] as! Bool
        likeCount = (dictionary["favourite_count"] as? Int) ?? 0
        
        // Timestamp
        let timestampString = dictionary["created_at"] as? String
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE MM d HH:mm:ss Z y"
        if let timestampString = timestampString {
            timestamp = formatter.date(from: timestampString) as NSDate?

        }
        
    }
    
    class func tweetsWithArray(dictionaries: [NSDictionary]) -> [Tweet] {
        var tweets = [Tweet]()
        for dictionary in dictionaries {
            let tweet = Tweet(dictionary: dictionary)
            tweets.append(tweet)
        }
        
        return tweets
    }
    
}

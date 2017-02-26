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
    var rawTimestamp: Date?
//    var formattedTimestamp: String
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
            rawTimestamp = formatter.date(from: timestampString)
            print("🐠☀️\(rawTimestamp)\n\(formatter.string(from: rawTimestamp!))")
//            formattedTimestamp = formatTimestamp(rawTimestamp!)
//            print("Formatted timestamp: \(formattedTimestamp)")
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
    
    func formatTimestamp(_ rawTimestamp: Date) -> String {
        let timeSince = abs(Int(rawTimestamp.timeIntervalSinceNow))
        let largestUnitChar: String
        let largestUnitMultiplier: Int
        
        if (timeSince <= 60) {
            largestUnitChar = "s" // Seconds
            largestUnitMultiplier = 1
        } else if (timeSince/60 <= 60) {
            largestUnitChar = "m" // Minutes
            largestUnitMultiplier = 1/60
        } else if (timeSince/60/60 <= 24) {
            largestUnitChar = "h" // Hours
            largestUnitMultiplier = 1/60/60
        } else if (timeSince/60/60/24 <= 365) {
            largestUnitChar = "d" // Days
            largestUnitMultiplier = 1/60/60/24
        } else {
            largestUnitChar = "y" // Years
            largestUnitMultiplier = 1/60/60/24/365
        }
        return "\(timeSince * largestUnitMultiplier)\(largestUnitChar)"
    }
}

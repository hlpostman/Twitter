//
//  TwitterClient.swift
//  Twitter
//
//  Created by Aristotle on 2017-02-21.
//  Copyright © 2017 HLPostman. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

class TwitterClient: BDBOAuth1SessionManager {
    
    static let sharedInstance = TwitterClient(baseURL: NSURL(string: "https://api.twitter.com")! as URL!, consumerKey: "UOgFeSdrTPCdG5aCPS933gOso", consumerSecret: "3EoeUPlkFlicEdf28GLC8M28apkgkIkKHQPnzsTtcyUJP4IPJh")
    
    var loginSuccess: (() -> ())?
    var loginFailure: ((Error) -> ())?
    
    func login(success: @escaping () -> (), failure: @escaping (Error) -> ()) {
        loginSuccess = success
        loginFailure = failure
        
        TwitterClient.sharedInstance?.deauthorize()
        TwitterClient.sharedInstance?.fetchRequestToken(withPath: "oauth/request_token", method: "GET", callbackURL: NSURL(string: "twitterhlp://oauth") as URL!, scope: nil, success: { (requestToken:
            BDBOAuth1Credential?) -> Void in
            print("I got a token!")
            
            let url = NSURL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\(requestToken!.token!)")!
            UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "TweetsNavigationController")
            var window: UIWindow?
            window?.rootViewController = vc
            
        }) { (error: Error?) -> Void in
            print("error: \(error!.localizedDescription)")
            self.loginFailure?(error!)
        }
    }
    
    func logout() {
        User.currentUser = nil
        deauthorize()
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: User.logoutNotification), object: nil)
    }
    
    
    func handleOpenUrl(url: URL) {
        let requestToken = BDBOAuth1Credential(queryString: url.query)
        fetchAccessToken(withPath: "oauth/access_token", method: "POST", requestToken: requestToken, success: { (accessToken:
            BDBOAuth1Credential?) -> Void in
            
            self.currentAccount(success: { (user: User) -> () in
               User.currentUser = user
                self.loginSuccess?()
                }, failure: { (error: Error) -> () in
                    self.loginFailure?(error)
            
            })
        }) { (error: Error?) -> Void in
            print("error: \(error?.localizedDescription)")
            self.loginFailure?(error!)
        }
        
    }
    
    
    func currentAccount(success: @escaping (User) -> (), failure: @escaping (Error) -> ()) {
        get("1.1/account/verify_credentials.json", parameters: nil, progress: nil, success: { (task: URLSessionDataTask, response:
            Any?) -> Void in
            let userDictionary = response as? NSDictionary
            let user = User(dictionary: userDictionary!)
            
            success(user)
    
            }, failure: { (task: URLSessionDataTask?, error: Error) -> Void in
                failure(error)
        })
        
    }
    
    func homeTimeline(success: @escaping ([Tweet]) -> (), failure: @escaping (Error) -> ()) {
        
        get("1.1/statuses/home_timeline.json", parameters: nil, progress: nil, success: { (task: URLSessionDataTask, response: Any?) -> Void in
            
            let dictionaries = response as! [NSDictionary]
            let tweets = Tweet.tweetsWithArray(dictionaries: dictionaries)
        
            
            success(tweets)
            }, failure: { (task: URLSessionDataTask?, error: Error) -> Void in
                failure(error)
        })
    }

}





















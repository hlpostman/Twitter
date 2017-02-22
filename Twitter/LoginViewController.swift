//
//  LoginViewController.swift
//  Twitter
//
//  Created by Aristotle on 2017-02-19.
//  Copyright © 2017 HLPostman. All rights reserved.
//

import UIKit
import BDBOAuth1Manager


class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onLoginButton(_ sender: AnyObject) {
        let client = TwitterClient.sharedInstance!
        
        client.login(success: { () -> () in
            print("I've logged in! ✅")
            
            }) { (error: Error) -> () in
                        print("Error: \(error.localizedDescription)")
        }
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

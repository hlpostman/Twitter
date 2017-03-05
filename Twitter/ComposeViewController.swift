//
//  ComposeViewController.swift
//  Twitter
//
//  Created by Aristotle on 2017-03-04.
//  Copyright © 2017 HLPostman. All rights reserved.
//

import UIKit

class ComposeViewController: UIViewController {

    @IBOutlet weak var composeTweetTextField: UITextField!
    @IBOutlet weak var sendButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onSendButton(_ sender: AnyObject) {
        let tweetText = composeTweetTextField.text
        
        TwitterClient.sharedInstance?.compose(tweetText: tweetText!, params: nil, completion: { (error) -> () in
            print("Composing")
            print(error?.localizedDescription)
            })
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

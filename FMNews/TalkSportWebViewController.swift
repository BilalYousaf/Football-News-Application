//
//  TalkSportWebViewController.swift
//  FM

//
//  Created by Dione on 05/01/2018.
//  Copyright © 2018 Dione. All rights reserved.


import UIKit
import Social




class TalkSportWebViewController: UIViewController {
    
    
    @IBAction func sharebtn(_ sender: Any) {
        
        
        let alert = UIAlertController(title: "Share", message: "Share Today's News!", preferredStyle: .actionSheet)
        
        //First Action
        let Facebook = UIAlertAction(title: "Share on Facebook", style: .default) { (action) in
            
            //Checking if the user is connected to Facebook
            if SLComposeViewController.isAvailable(forServiceType: SLServiceTypeFacebook)
            {
                let post = SLComposeViewController(forServiceType: SLServiceTypeFacebook)!
                
                post.setInitialText("Check out the Latest Football News!")
                post.add(URL(string: (self.url)!))
                
                self.present(post, animated: true, completion: nil)
                
            }
            else
            {
                self.showAlert(service: "Facebook")
            }
        }
        
        //Second Action
        let Twiiter = UIAlertAction(title: "Share on Twitter", style: .default) { (action) in
            
            //Checking if the user is connected to Twitter
            if SLComposeViewController.isAvailable(forServiceType: SLServiceTypeTwitter)
            {
                let post = SLComposeViewController(forServiceType: SLServiceTypeTwitter)!
                
                post.setInitialText("Check out the Latest Football News!")
                post.add(URL(string: (self.url)!))
                
                self.present(post, animated: true, completion: nil)
                
            }
            else
            {
                self.showAlert(service: "Twitter")
            }
        }
        
        //To cancel the share function
        let cancelActionButton = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        //Add action to the action sheet
        alert.addAction(Facebook)
        alert.addAction(Twiiter)
        alert.addAction(cancelActionButton)
        
        //Present alert
        self.present(alert, animated: true, completion: nil)
    }
    
    func showAlert(service: String) {
        
        let alert = UIAlertController(title: "Error", message: "Error: ou are not connected to \(service)", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Dismiss", style: .cancel, handler: nil)
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
    @IBOutlet weak var webView1: UIWebView!
    var url: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webView1.loadRequest(URLRequest(url:URL(string : url!)!))
        
        
    }
    
    
}

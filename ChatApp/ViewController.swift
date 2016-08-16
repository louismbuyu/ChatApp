//
//  ViewController.swift
//  ChatApp
//
//  Created by Louis Nelson Levoride on 11/08/16.
//  Copyright © 2016 LouisNelson. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var signUpButton: UIButton!
    
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        simpleCornersAndBorders().makeButton(signUpButton, cornerRadius: 3.0, borderWidth: 0)
        simpleCornersAndBorders().makeButton(loginButton, cornerRadius: 3.0, borderWidth: 1.0)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func signUpAction(sender: UIButton) {
        goToMainTab()
    }

    @IBAction func loginAction(sender: UIButton) {
        goToMainTab()
    }
    
    func goToMainTab(){
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("MainTab") as! UITabBarController
        self.presentViewController(vc, animated: true, completion: nil)
    }
}


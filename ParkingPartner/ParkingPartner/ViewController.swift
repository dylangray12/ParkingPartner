//
//  ViewController.swift
//  ParkingPartner
//
//  Created by  on 9/17/18.
//  Copyright © 2018 Robert Thomas. All rights reserved.
//


import GoogleSignIn

class ViewController: UIViewController, GIDSignInUIDelegate {

    @IBOutlet weak var signInButton: GIDSignInButton!
    
    @IBOutlet weak var btnSignOut: UIButton!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var lblFamilyName: UILabel!
    @IBOutlet weak var lblGivenName: UILabel!
    @IBOutlet weak var lblFullName: UILabel!
    @IBOutlet weak var lblUserId: UILabel!
    @IBOutlet weak var imgLogo: UIImageView!
    
    
    override func viewDidLoad() {
          super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        NotificationCenter.default.addObserver(self,selector: #selector(ViewController.receiveToggleAuthUINotification(_:)),name: NSNotification.Name(rawValue: "ToggleAuthUINotification"),object: nil);        GIDSignIn.sharedInstance().uiDelegate = self
             // Uncomment to automatically sign in the user.
        //GIDSignIn.sharedInstance().signInSilently()
        
        // TODO(developer) Configure the sign-in button look/feel
        // ...    }

        
    }
    @IBAction func btnSignIn(_ sender: Any) {
        GIDSignIn.sharedInstance().signIn()
    
    }
    @IBAction func btnSignOut(_ sender: UIButton) {
        GIDSignIn.sharedInstance().signOut()
        lblUserId.isHidden = true
        lblEmail.isHidden = true
        lblGivenName.isHidden = true
        lblFamilyName.isHidden = true
        lblFullName.isHidden = true
        signInButton.isHidden = false
        btnSignOut.isHidden = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func receiveToggleAuthUINotification(_ notification: NSNotification) {
        if notification.name.rawValue == "ToggleAuthUINotification" {
            self.toggleAuthUI()
            if notification.userInfo != nil {
                guard let user = notification.object as? GIDGoogleUser else { return }
                guard (notification.userInfo as? [String:String]) != nil else { return }
                
                lblFullName.text = user.profile.name
                lblGivenName.text = user.profile.givenName
                lblFamilyName.text = user.profile.familyName
                lblEmail.text = user.profile.email
            }
        }
    }
    
    func toggleAuthUI() {
        if GIDSignIn.sharedInstance().hasAuthInKeychain() {
            // Signed in
            lblUserId.isHidden = false
            lblFullName.isHidden = false
            lblGivenName.isHidden = false
            lblFamilyName.isHidden = false
            lblEmail.isHidden = false
            signInButton.isHidden = true
            btnSignOut.isHidden = false
        } else {
            // Signed out
            lblUserId.isHidden = true
            lblFullName.isHidden = true
            lblGivenName.isHidden = true
            lblFamilyName.isHidden = true
            lblEmail.isHidden = true
            signInButton.isHidden = false
            btnSignOut.isHidden = true
        }
    }
}


//
//  ViewController.swift
//  QuotaiOS
//
//  Created by Matthew Muccio on 11/5/16.
//  Copyright © 2016 Matthew Muccio. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class ViewController: UIViewController
{
    
    var reference: FIRDatabaseReference!;
    
    @IBOutlet weak var emailTextField: UITextField!;
    @IBOutlet weak var passwordTextField: UITextField!;
    @IBOutlet weak var loginButton: UIButton!;
    @IBOutlet weak var registerAccountButton: UIButton!;
    @IBOutlet weak var signedInLabel: UILabel!;
    @IBOutlet weak var emailLabel: UILabel!;
    @IBOutlet weak var signOutButton: UIButton!;
    @IBOutlet weak var helloLabel: UILabel!;
    @IBOutlet weak var infoLabel: UILabel!;
    
    var qScore:Int = 0;
    
    override func viewWillAppear(_ animated: Bool)
    {
        qScore = getQScore();
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad();
        // Do any additional setup after loading the view, typically from a nib.
        self.navigationController?.navigationBar.barStyle = UIBarStyle.black;
        
        qScore = getQScore();
        
        self.reference = FIRDatabase.database().reference();
        
        // If user was not signed in beforehand.
        if (FIRAuth.auth()?.currentUser == nil)
        {
            
        }
        else
        {
            let alert = UIAlertController(title: "You are already logged in!", message: "The last time you were here you were signed on so we kept your session. No need to thank us, just pay it forward.", preferredStyle: UIAlertControllerStyle.alert);
            let OK = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil);
            alert.addAction(OK);
            self.present(alert, animated: true, completion: nil);
            
            self.emailTextField.isHidden = true;
            self.passwordTextField.isHidden = true;
            self.loginButton.isHidden = true;
            self.registerAccountButton.isHidden = true;
            
            self.emailLabel.text = FIRAuth.auth()?.currentUser?.uid;
            self.signedInLabel.isHidden = false;
            self.emailLabel.isHidden = false;
            self.signOutButton.isHidden = false;
            self.helloLabel.isHidden = false;
            self.infoLabel.isHidden = false;
        }
    }
    
    // Attempts to sign user out of Firebase account.
    @IBAction func signOutButtonPressed(_ sender: Any)
    {
        try! FIRAuth.auth()?.signOut();
        self.view.endEditing(true);
        
        let alert = UIAlertController(title: "Signed out.", message: "You signed out.", preferredStyle: UIAlertControllerStyle.alert);
        let OK = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil);
        alert.addAction(OK);
        self.present(alert, animated: true, completion: nil);
        
        self.emailTextField.isHidden = false;
        self.passwordTextField.isHidden = false;
        self.loginButton.isHidden = false;
        self.registerAccountButton.isHidden = false;
        
        self.emailLabel.text = "Email";
        self.signedInLabel.isHidden = true;
        self.emailLabel.isHidden = true;
        self.signOutButton.isHidden = true;
        self.helloLabel.isHidden = true;
        self.infoLabel.isHidden = true;
    }
    
    // When user presses loginButton to  attempt to log in.
    @IBAction func loginButtonPressed(_ sender: Any)
    {
        FIRAuth.auth()?.signIn(withEmail: emailTextField.text!, password: passwordTextField.text!, completion: {
            (user, error) in
            
            if (error != nil) // Password or email is incorrect.
            {
                // Dismiss keyboard.
                self.view.endEditing(true);
                let alert = UIAlertController(title: "Error logging in.", message: "Your email or password was incorrect.", preferredStyle: UIAlertControllerStyle.alert);
                let OK = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil);
                alert.addAction(OK);
                self.present(alert, animated: true, completion: nil);
                return;
            }
            // Success logging in.
            // Dismiss keyboard.
            self.view.endEditing(true);
            let alert = UIAlertController(title: "Success!", message: "Logged in to Firebase with UID: " + (user?.uid)!, preferredStyle: UIAlertControllerStyle.alert);
            let OK = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil);
            alert.addAction(OK);
            self.present(alert, animated: true, completion: nil);
            
            self.emailTextField.isHidden = true;
            self.passwordTextField.isHidden = true;
            self.loginButton.isHidden = true;
            self.registerAccountButton.isHidden = true;
            
            self.emailLabel.text = FIRAuth.auth()?.currentUser?.uid;
            self.signedInLabel.isHidden = false;
            self.emailLabel.isHidden = false;
            self.signOutButton.isHidden = false;
            
            self.helloLabel.isHidden = false;
            self.infoLabel.isHidden = false;
            
            self.emailTextField.text = "";
            self.passwordTextField.text = "";
        })
    }
    
    @IBAction func createAccountButtonPressed(_ sender: Any)
    {
        FIRAuth.auth()?.createUser(withEmail: emailTextField.text!, password: passwordTextField.text!, completion: {
            (user, error) in
            
            if (error != nil) // Displays alert with error in user registration.
            {
                // Dismiss keyboard.
                self.view.endEditing(true);
                let alert = UIAlertController(title: "Error registering user.", message: "Error: " + error.debugDescription, preferredStyle: UIAlertControllerStyle.alert);
                let OK = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil);
                alert.addAction(OK);
                self.present(alert, animated: true, completion: nil);
                return;
            }
            // Creates account.
            let userID:String = user!.uid;
            let userEmail:String = self.emailTextField.text!;
            let userPassword:String = self.passwordTextField.text!;
            let userScore:Int = 0;
            
            self.reference.child("Users").child(userID).setValue(["Email": userEmail, "Password": userPassword, "Score": userScore]);
            
            // Dismiss keyboard.
            self.view.endEditing(true);
            let alert = UIAlertController(title: "Success!", message: "Created account with Firebase with UID: " + (user?.uid)!, preferredStyle: UIAlertControllerStyle.alert);
            let OK = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil);
            alert.addAction(OK);
            self.present(alert, animated: true, completion: nil);
        })
    }
    
    func getQScore() -> Int
    {
        qScore = taskManager.taskList.count;
        return qScore;
    }
    
    // When user touches something on screen.
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        // Dismiss keyboard.
        self.view.endEditing(true);
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning();
        // Dispose of any resources that can be recreated.
    }
    
}

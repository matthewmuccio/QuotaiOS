//
//  EditTaskViewController.swift
//  QuotaiOS
//
//  Created by Matthew Muccio on 11/5/16.
//  Copyright © 2016 Matthew Muccio. All rights reserved.
//

import UIKit

class EditTaskViewController: UIViewController
{
    
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad();
        // Do any additional setup after loading the view, typically from a nib.
        self.navigationController?.navigationBar.barStyle = UIBarStyle.black;
    }
    
    func qScore() -> Int
    {
        return 0;
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning();
        // Dispose of any resources that can be recreated.
    }
    
}

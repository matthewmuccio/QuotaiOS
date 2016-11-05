//
//  TaskListViewController.swift
//  QuotaiOS
//
//  Created by Matthew Muccio on 11/5/16.
//  Copyright © 2016 Matthew Muccio. All rights reserved.
//

import UIKit

class TaskListViewController: UIViewController, UITableViewDataSource
{
    // Returns number of sections (categories) in UITableView.
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1;
    }
    
    // Returns number of rows (tasks) in UITableView.
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 3;
    }
    
    // Returns contents of each cell.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = UITableViewCell();
        
        cell.textLabel?.text = "Task \(indexPath.row + 1)";
        cell.detailTextLabel?.text = "Due date \(indexPath.row + 1)";
        
        return cell;
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad();
    }
}

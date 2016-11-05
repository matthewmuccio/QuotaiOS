//
//  TaskListViewController.swift
//  QuotaiOS
//
//  Created by Matthew Muccio on 11/5/16.
//  Copyright © 2016 Matthew Muccio. All rights reserved.
//

import UIKit

class TaskListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource
{
    @IBOutlet weak var tasksTableView: UITableView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad();
        tasksTableView.reloadData();
    }
    
    // Returns number of sections (categories) in UITableView.
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1;
    }
    
    // Returns number of rows (tasks) in UITableView.
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return taskManager.taskList.count;
    }
    
    // Returns contents of each cell.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell:UITableViewCell = UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: "Default Tasks");
        
        cell.textLabel?.text = taskManager.taskList[indexPath.row].name;
        cell.detailTextLabel?.text = taskManager.taskList[indexPath.row].dueDate + " @ " + taskManager.taskList[indexPath.row].dueTime;
        
        return cell;
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath)
    {
        if (editingStyle == UITableViewCellEditingStyle.delete)
        {
            taskManager.taskList.remove(at: indexPath.row);
            tasksTableView.reloadData();
        }
    }
    
}

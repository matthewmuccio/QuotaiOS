//
//  TaskListViewController.swift
//  QuotaiOS
//
//  Created by Matthew Muccio on 11/5/16.
//  Copyright © 2016 Matthew Muccio. All rights reserved.
//

import UIKit
import Firebase

class TaskListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource
{
    @IBOutlet weak var tasksTableView: UITableView!
    var cells: Array<UITableViewCell> = [];
    var reference: FIRDatabaseReference!;
    
    override func viewDidLoad()
    {
        super.viewDidLoad();
        tasksTableView.reloadData();
        
        self.reference = FIRDatabase.database().reference();
        
        
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        fillInTableView();
    }
    
    
    func fillInTableView() // Filling Quotes TableView with Quotes from Array (NSUserDefaults).
    {
        self.cells = Array<UITableViewCell>();
        
        var i = 0;
        
        while (i < taskManager.taskList.count)
        {
            let cell = UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: nil);
            cell.textLabel?.font = UIFont(name: "Trebuchet MS", size: 16);
            cell.detailTextLabel?.font = UIFont(name: "Trebuchet MS", size: 14);
            cell.textLabel?.text = taskManager.taskList[i].name + "[" + taskManager.taskList[i].priority + " priority]";
            cell.detailTextLabel?.text = taskManager.taskList[i].dueDate + " @ " + taskManager.taskList[i].dueTime;
            self.cells.append(cell);
            i += 1;
        }
    }
    
    // Returns number of sections in UITableView.
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1;
    }
    
    // When user selects row at a certain indexPath.
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let vc = EditTaskViewController();
        
        self.navigationController?.pushViewController(vc, animated: true);
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
        
        cell.textLabel?.text = taskManager.taskList[indexPath.row].name + " [\(taskManager.taskList[indexPath.row].priority) priority]";
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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 60;
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool
    {
        return true;
    }
    
}

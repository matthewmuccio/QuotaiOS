//
//  TaskManager.swift
//  QuotaiOS
//
//  Created by Matthew Muccio on 11/5/16.
//  Copyright © 2016 Matthew Muccio. All rights reserved.
//

import UIKit

var taskManager:TaskManager = TaskManager();

struct Task
{
    var name = "Name";
    var priority = "Priority";
    var dueDate = "Due Date";
    var dueTime = "Due Time";
}

class TaskManager: NSObject
{
    var taskList = [Task]();
    
    func addTask(name: String, priority: String, dueDate: String, dueTime: String)
    {
        taskList.append(Task(name: name, priority: priority, dueDate: dueDate, dueTime: dueTime));
    }
}

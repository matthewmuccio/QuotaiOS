//
//  AddTaskViewController.swift
//  QuotaiOS
//
//  Created by Matthew Muccio on 11/5/16.
//  Copyright © 2016 Matthew Muccio. All rights reserved.
//

import UIKit
import Foundation

class AddTaskViewController: UIViewController, UITextViewDelegate
{
    
    @IBOutlet weak var addTaskButton: UIButton!
    @IBOutlet weak var taskTextView: UITextView!;
    @IBOutlet weak var lowPriorityButton: UIButton!;
    @IBOutlet weak var mediumPriorityButton: UIButton!;
    @IBOutlet weak var highPriorityButton: UIButton!;
    @IBOutlet weak var dateLabel: UILabel!;
    @IBOutlet weak var timeLabel: UILabel!;
    @IBOutlet weak var datePicker: UIDatePicker!;
    
    var low:Bool = false;
    var medium:Bool = false;
    var high:Bool = false;
    
    override func viewDidLoad()
    {
        self.addTaskButton.isEnabled = false;
        self.checkForButton();
    }
    
    // Checks to see if button should be enabled.
    func checkForButton()
    {
        if (isFilledOut())
        {
            self.addTaskButton.backgroundColor = UIColor.green;
            self.addTaskButton.isEnabled = true;
            self.addTaskButton.isUserInteractionEnabled = true;
        }
        else
        {
            self.addTaskButton.backgroundColor = UIColor.darkGray;
            self.addTaskButton.isEnabled = false;
            self.addTaskButton.isUserInteractionEnabled = false;
        }
    }
    
    // Checks if form is completely filled out.
    func isFilledOut() -> Bool
    {
        if (self.taskTextView.text.isEmpty ||
            (!low && !medium && !high) ||
            self.dateLabel.text == "Not set" ||
            self.timeLabel.text == "Not set")
        {
            return false;
        }
        return true;
    }
    
    // When a textView begins to be edited.
    func textViewDidBeginEditing(_ textView: UITextView)
    {
        // Check to see if button should be enabled.
        self.checkForButton();
    }
    
    // When a textView changes when is inside it.
    func textViewDidChange(_ textView: UITextView)
    {
        // Check to see if button should be enabled.
        self.checkForButton();
    }
    
    // When user clicks the "Low" priority button.
    @IBAction func lowPriorityButtonPressed(_ sender: Any)
    {
        // Dismiss keyboard.
        self.view.endEditing(true);
        
        // If user click low-priority button,
        // then the task is not medium- or high-priority.
        self.low = true;
        self.medium = false;
        self.high = false;
        
        self.lowPriorityButton.backgroundColor = UIColor.green;
        self.mediumPriorityButton.backgroundColor = UIColor.darkGray;
        self.highPriorityButton.backgroundColor = UIColor.darkGray;
        
        // Check to see if button should be enabled.
        self.checkForButton();
    }
    
    // When user clicks the "Medium" priority button.
    @IBAction func mediumPriorityButtonPressed(_ sender: Any)
    {
        // Dismiss keyboard.
        self.view.endEditing(true);
        
        // If user click medium-priority button,
        // then the task is not low- or high-priority.
        self.low = false;
        self.medium = true;
        self.high = false;
        
        self.lowPriorityButton.backgroundColor = UIColor.darkGray;
        self.mediumPriorityButton.backgroundColor = UIColor.orange;
        self.highPriorityButton.backgroundColor = UIColor.darkGray;
        
        // Check to see if button should be enabled.
        self.checkForButton();
    }
    
    // When user clicks the "High" priority button.
    @IBAction func highPriorityButtonPressed(_ sender: Any)
    {
        // Dismiss keyboard.
        self.view.endEditing(true);
        
        // If user click high-priority button,
        // then the task is not low- or medium-priority.
        self.low = false;
        self.medium = false;
        self.high = true;
        
        self.lowPriorityButton.backgroundColor = UIColor.darkGray;
        self.mediumPriorityButton.backgroundColor = UIColor.darkGray;
        self.highPriorityButton.backgroundColor = UIColor.red;
        
        // Check to see if button should be enabled.
        self.checkForButton();
    }
    
    @IBAction func datePickerValueChanged(_ sender: Any)
    {
        let formatter = DateFormatter();
        formatter.dateFormat = "MM/dd/YYYY";
        dateLabel.text = formatter.string(from: datePicker.date);
        
        formatter.dateFormat = "hh:mm a";
        timeLabel.text = formatter.string(from: datePicker.date);
        
        // Check to see if button should be enabled.
        self.checkForButton();
    }
    
    // When user presses "Add Task" button.
    @IBAction func addTaskButtonPressed(_ sender: Any)
    {
        // Resign textViews from being a first responder.
        // (Remove keyboard from screen.)
        taskTextView.resignFirstResponder();
        
        var priority:String = "";
        
        // Check what priority is depending on low, medium, and high booleans.
        if (low)
        {
            priority = "low";
        }
        else if (medium)
        {
            priority = "medium";
        }
        else
        {
            priority = "high";
        }
        
        // Add task.
        taskManager.addTask(name: taskTextView.text, priority: priority, dueDate: dateLabel.text!, dueTime: timeLabel.text!);
        
        // Dismiss keyboard and pop user back to main scene.
        self.view.endEditing(true);
        _ = self.navigationController?.popViewController(animated: true);
    }
    
    // When user touches something on screen.
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        // Dismiss keyboard.
        self.view.endEditing(true);
    }
}

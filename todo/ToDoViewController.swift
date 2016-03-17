//
//  ViewController.swift
//  todo
//
//  Created by Jisi Guo on 2/29/16.
//  Copyright © 2016 Jisi Guo. All rights reserved.
//

import UIKit

let ROW_HEIGHT = CGFloat(70)

class ToDoViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var containerScrollView: UIScrollView!
    @IBOutlet weak var todoTableView: UITableView!
    @IBOutlet weak var doingTableView: UITableView!
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var leftCard: UIView!
    @IBOutlet weak var rightCard: UIView!
    
    @IBOutlet weak var todoTab: UIButton!
    @IBOutlet weak var doingTab: UIButton!
    @IBOutlet weak var doneTab: UIButton!
    
    var initialScrollViewContentOffset: CGPoint!
    
    var todos : NSArray!
    var doing : NSArray!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        containerScrollView.delegate = self
        containerScrollView.contentSize = CGSize(width: 3 * 375, height: self.view.frame.height)
        scrollView.contentSize = CGSize(width: 3 * 375, height: 586)
        
        // border radius
//        leftCard.layer.cornerRadius = 10;
//        tableView.layer.cornerRadius = 10;
        rightCard.layer.cornerRadius = 10;
        
        todos = [   "Learn",
                    "Coffee",
                    "Ideation",
                    "Coffee",
                    "Wireframe",
                    "Coffee",
                    "Code",
                    "Coffee",
                    "Submit",
                    "Coffee",
                ]
        
        doing = [   "Work",
                    "Play",
                    "Work",
                    "Play",
                    "Work",
                ]
    
        // Hide the top cell, so that it's only revealed on scroll
        todoTableView.contentInset.top = -ROW_HEIGHT
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell : UITableViewCell!
        
        if (tableView == todoTableView) {
            let cell = tableView.dequeueReusableCellWithIdentifier("com.todo.todocellview", forIndexPath: indexPath) as! ToDoTableViewCell
            
            let multiplier = 1.0 / CGFloat(todos.count + 5)
            
            cell.backgroundColor = UIColor(red: 0, green: 0, blue: 255, alpha: 1.0 - CGFloat(indexPath.row + 5) * multiplier / 1.0)
            
            cell.textField.text = todos[indexPath.row] as! String

            return cell
        } else if (tableView == doingTableView) {
            let cell = tableView.dequeueReusableCellWithIdentifier("com.todo.doingcellview", forIndexPath: indexPath) as! DoingTableViewCell
            
            let multiplier = 1.0 / CGFloat(todos.count + 5)
            
            cell.backgroundColor = UIColor(red:1.0, green:0.75, blue:0.72, alpha: 1.0 - CGFloat(indexPath.row + 5) * multiplier / 1.0)
            
            cell.textField.text = doing[indexPath.row] as! String
            
            return cell
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        if (tableView == todoTableView) {
            return todos.count
        } else if (tableView == doingTableView) {
            return doing.count
        }
        
        return 5
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        return ROW_HEIGHT
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {

        if (scrollView == containerScrollView) {
            
        }
        
        
        if (scrollView == todoTableView) {
         // When you scroll to the top of the scroll view, catch the New cell and leave it on screen
            if (todoTableView.contentOffset.y <= 0) {
                
                UIView.animateWithDuration(0.3, animations: { () -> Void in
                    
                    self.todoTableView.contentInset.top = 0
                    },  completion: { (finished) -> Void in
                  
                        let cell = self.todoTableView.cellForRowAtIndexPath(NSIndexPath(forItem: 0, inSection: 0)) as! ToDoTableViewCell
                        
                        cell.textField!.becomeFirstResponder()
                })
            }
        }
    }
    
//    CODE FOR TAB BAR BUTTONS
    
    @IBAction func tapTodoTab(sender: UIButton) {
        print("tapped on todo tab")
        UIView.animateWithDuration(0.3, animations: { () -> Void in
            self.scrollView.contentOffset.x = self.leftCard.frame.origin.x - 38
        })
        todoTab.selected = true
        doingTab.selected = false
        doneTab.selected = false
        
    }
    
    @IBAction func tapDoingTab(sender: UIButton) {
        print("tapped on doing tab")
        UIView.animateWithDuration(0.3, animations: { () -> Void in
            self.scrollView.contentOffset.x = self.tableView.frame.origin.x - 38
        })
        todoTab.selected = false
        doingTab.selected = true
        doneTab.selected = false
    }
    
    
    @IBAction func tapDoneTab(sender: UIButton) {
        print("tapped on done tab")
        UIView.animateWithDuration(0.3, animations: { () -> Void in
            self.scrollView.contentOffset.x = self.rightCard.frame.origin.x - 38
        })
        todoTab.selected = false
        doingTab.selected = false
        doneTab.selected = true
    }
    
    @IBAction func tabBarDidPan(sender: UIPanGestureRecognizer) {
        print("did pan")
        let translation = sender.translationInView(view)
        let velocity = sender.velocityInView(view)
        
        if (sender.state == UIGestureRecognizerState.Began) {
            initialScrollViewContentOffset = scrollView.contentOffset
            
        }  else if (sender.state == UIGestureRecognizerState.Changed) {
            print(translation)
            self.scrollView.contentOffset.x = initialScrollViewContentOffset.x - (translation.x)
            
        }  else if (sender.state == UIGestureRecognizerState.Ended) {
            print(velocity)
            
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


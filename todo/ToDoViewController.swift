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
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var todoTableView: UITableView!
    @IBOutlet weak var doingTableView: UITableView!
    
    var todos : NSArray!
    var doing : NSArray!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        containerScrollView.delegate = self
        containerScrollView.contentSize = CGSize(width: 3 * 375, height: self.view.frame.height)
        
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
        
<<<<<<< Updated upstream
        var cell : UITableViewCell!
        
        if (tableView == todoTableView) {
            let cell = tableView.dequeueReusableCellWithIdentifier("com.todo.todocellview", forIndexPath: indexPath) as! ToDoTableViewCell
            
            let multiplier = 255.0 / CGFloat(todos.count + 5)
            
            cell.backgroundColor = UIColor(red: CGFloat(indexPath.row + 5) * multiplier / 255.0, green: 0, blue: 0, alpha: 1.0)
            
            cell.textField.text = todos[indexPath.row] as! String
=======
        let cell = tableView.dequeueReusableCellWithIdentifier("com.todo.todocellview", forIndexPath: indexPath) as! ToDoTableViewCell
        
        let multiplier = 1.0 / CGFloat(todos.count + 5)
        
//        cell.backgroundColor = UIColor(red: CGFloat(indexPath.row + 5) * multiplier / 255.0, green: 191, blue: 183, alpha: 1.0)
        
        cell.backgroundColor = UIColor(red:1.0, green:0.75, blue:0.72, alpha: CGFloat(indexPath.row + 5) * multiplier / 1.0)
        
        cell.textField.text = todos[indexPath.row] as! String
>>>>>>> Stashed changes

            return cell
        } else if (tableView == doingTableView) {
            let cell = tableView.dequeueReusableCellWithIdentifier("com.todo.doingcellview", forIndexPath: indexPath) as! DoingTableViewCell
            
            let multiplier = 255.0 / CGFloat(todos.count + 5)
            
            cell.backgroundColor = UIColor(red: 0, green: CGFloat(indexPath.row + 5) * multiplier / 255.0, blue: 0, alpha: 1.0)
            
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
            
            let pageWidth = scrollView.frame.size.width
            let page = Int(floor((scrollView.contentOffset.x * 2.0 + pageWidth) / (pageWidth * 2.0)))
            
            pageControl.currentPage = page
            print (page)
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
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


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

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var tableView: UITableView!
    
    var todos : NSArray!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        scrollView.contentSize = CGSize(width: 3 * 375, height: self.view.frame.height)
        
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
    
        // Hide the new cell, so that it's only revealed on scroll
        tableView.contentInset.top = -ROW_HEIGHT
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("com.todo.todocellview", forIndexPath: indexPath) as! ToDoTableViewCell
        
        let multiplier = 255.0 / CGFloat(todos.count + 5)
        
        cell.backgroundColor = UIColor(red: CGFloat(indexPath.row + 5) * multiplier / 255.0, green: 0, blue: 0, alpha: 1.0)
        
        cell.textField.text = todos[indexPath.row] as! String

        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return todos.count
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        return ROW_HEIGHT
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
     
        // When you scroll to the top of the scroll view, catch the New cell and leave it on screen
        if (tableView.contentOffset.y <= 0) {
            
            UIView.animateWithDuration(0.3, animations: { () -> Void in
                
                self.tableView.contentInset.top = 0
                },  completion: { (finished) -> Void in
              
                    let cell = self.tableView.cellForRowAtIndexPath(NSIndexPath(forItem: 0, inSection: 0)) as! ToDoTableViewCell
                    
                    cell.textField!.becomeFirstResponder()
            })
        }
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


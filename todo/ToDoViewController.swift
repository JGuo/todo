//
//  ViewController.swift
//  todo
//
//  Created by Jisi Guo on 2/29/16.
//  Copyright © 2016 Jisi Guo. All rights reserved.
//

import UIKit

class ToDoViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var leftCard: UIView!
    @IBOutlet weak var rightCard: UIView!
    
    @IBOutlet weak var todoTab: UIButton!
    @IBOutlet weak var doingTab: UIButton!
    @IBOutlet weak var doneTab: UIButton!
    
    var initialScrollViewContentOffset: CGPoint!
    
    var todos : NSArray!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        scrollView.contentSize = CGSize(width: 3 * 375, height: 586)
        
        // border radius
        leftCard.layer.cornerRadius = 10;
        tableView.layer.cornerRadius = 10;
        rightCard.layer.cornerRadius = 10;
        
        todos = [   "0",
                    "1",
                    "2",
                    "3",
                    "4",
                    "5",
                    "6",
                    "7",
                    "8",
                    "9",
                    "10",
                    "11",
                    "12",
                    "13",
                    "14",
                    "15",
                    "16",
                    "17",
                    "18",
                    "19"]
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("com.todo.todocellview", forIndexPath: indexPath) as! ToDoTableViewCell
        
        let multiplier = 255.0 / CGFloat(todos.count + 5)
        
        cell.backgroundColor = UIColor(red: CGFloat(indexPath.row + 5) * multiplier / 255.0, green: 0, blue: 0, alpha: 1.0)
        
        cell.textLabel?.text = todos[indexPath.row] as! String

        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return todos.count
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


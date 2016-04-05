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
    
    @IBOutlet weak var rightCard: UIView!
    
    @IBOutlet weak var tabBarView: UIView!
    @IBOutlet weak var todoTab: UIButton!
    @IBOutlet weak var doingTab: UIButton!
    @IBOutlet weak var doneTab: UIButton!
    var pageNumber : Int!
    
    var initialScrollViewContentOffset: CGPoint!
    
    var todos : NSMutableArray!
    var doing : NSMutableArray!
    
    var pullToCreate : Bool!
    var placeholderToDo : ToDoTableViewCell!
    var placeholderDoing : DoingTableViewCell!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        containerScrollView.delegate = self
        // width = 3 * width of cards + 2 * padding between cards + 2 * extreme left and extreme right padding
        let w = CGFloat(3*300 + 2*14 + 2*38)
        containerScrollView.contentSize = CGSize(width: w, height: 568)
        
        // border radius
        todoTableView.layer.cornerRadius = 10;
        doingTableView.layer.cornerRadius = 10;
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
        
        todoTab.selected = true
        pageNumber = 0
        
        pullToCreate = false
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
        } else {
            return 0
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        return ROW_HEIGHT
    }
    
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        if (scrollView == todoTableView) {
            
            if (todoTableView.contentOffset.y <= 0.0) {
                
                todos.insertObject("Pull to add item" as String, atIndex: 0)
                todoTableView.reloadData()
            }
        }
        
        if (scrollView == doingTableView) {
            
            if (doingTableView.contentOffset.y <= 0.0) {
                
                doing.insertObject("Pull to add item" as String, atIndex: 0)
                doingTableView.reloadData()
            }
        }
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        
        // When you scroll to the top of the scroll view, catch the New cell and leave it on screen
        var scrollViewContentOffsetY = scrollView.contentOffset.y
        
        if (pullToCreate == false) {
            pullToCreate = scrollViewContentOffsetY <= -ROW_HEIGHT
        }
        
        if (scrollView == todoTableView) {
            if (placeholderToDo == nil) {
                placeholderToDo = todoTableView.dequeueReusableCellWithIdentifier("com.todo.todocellview") as! ToDoTableViewCell
            }
            
            placeholderToDo.textLabel!.text = pullToCreate == true ? "Release to add item" : "Pull to add item"
        }
        
        if (scrollView == doingTableView) {
            if (placeholderDoing == nil) {
                placeholderDoing = doingTableView.dequeueReusableCellWithIdentifier("com.todo.doingcellview") as! DoingTableViewCell
            }
            
            placeholderDoing.textLabel!.text = pullToCreate == true ? "Release to add item" : "Pull to add item"

        }
        
    }
    
    func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if (pullToCreate == true) {
            if (scrollView == todoTableView) {
                todos.removeObjectAtIndex(0)
                todos.insertObject("New", atIndex: 0)
                todoTableView.reloadData()
                
                let cell = todoTableView.cellForRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 0)) as! ToDoTableViewCell
                cell.textField.becomeFirstResponder()
            }
            
            if (scrollView == doingTableView) {
                doing.removeObjectAtIndex(0)
                doing.insertObject("New", atIndex: 0)
                doingTableView.reloadData()
                
                let cell = doingTableView.cellForRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 0)) as! DoingTableViewCell
                cell.textField.becomeFirstResponder()
            }
            
            pullToCreate = false
            placeholderToDo = nil
            placeholderDoing = nil
        } else {

            if (scrollView == todoTableView) {
                todos.removeObjectAtIndex(0)
                todoTableView.reloadData()
            }
            
            if (scrollView == doingTableView) {
                doing.removeObjectAtIndex(0)
                doingTableView.reloadData()
            }
        }
    }

    //    CODE FOR TAB BAR BUTTONS
    @IBAction func tapTodoTab(sender: UIButton) {
        
        selectTodoTab(true)
    }
    
    @IBAction func tapDoingTab(sender: UIButton) {
        
        selectDoingTab()
    }
    
    
    @IBAction func tapDoneTab(sender: UIButton) {
       
        selectDoneTab(true)
    }
    
    @IBAction func tabBarDidPan(sender: UIPanGestureRecognizer) {
        let translation = sender.translationInView(view)
        
        if (sender.state == UIGestureRecognizerState.Began) {
            initialScrollViewContentOffset = containerScrollView.contentOffset
            
        }  else if (sender.state == UIGestureRecognizerState.Changed) {
            
            containerScrollView.contentOffset.x = initialScrollViewContentOffset.x - translation.x
            
        }  else if (sender.state == UIGestureRecognizerState.Ended) {
            if (pageNumber == 0) {
                
                if (self.containerScrollView.contentOffset.x < self.view.frame.width / 2.0) {
                    selectTodoTab(false)
                } else {
                    
                    selectDoingTab()
                }
            } else if (pageNumber == 1) {
             
                if (self.containerScrollView.contentOffset.x < 38 + 300 + 7) {
                    selectTodoTab(false)
                } else if (self.rightCard.frame.origin.x > self.containerScrollView.contentSize.width - 38 - 300 - 7) {
                    selectDoneTab(false)
                } else {
                    selectDoingTab()
                }
            } else if (pageNumber == 2) {
                
                if (self.containerScrollView.contentOffset.x > self.containerScrollView.contentSize.width - self.view.window!.frame.width) {
                    selectDoneTab(false)
                } else if (self.rightCard.frame.origin.x > self.containerScrollView.contentSize.width - 38 - 300 - 7) {
                    self.selectDoingTab()
                }
            }
        }
    }
    
    func selectTodoTab(tapped: Bool) {

        if (tapped) {
            UIView.animateWithDuration(0.3, animations: { () -> Void in
                self.containerScrollView.contentOffset.x = 0
            })
            
        } else {
            UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 0.65, initialSpringVelocity: 0, options: .CurveEaseIn, animations: { () -> Void in
            self.containerScrollView.contentOffset.x = 0
            }, completion: nil)
        
        }
        todoTab.selected = true
        doingTab.selected = false
        doneTab.selected = false
        pageNumber = 0
    }
    
    func selectDoingTab() {
        
        UIView.animateWithDuration(0.3, animations: { () -> Void in
            self.containerScrollView.contentOffset.x = (self.containerScrollView.contentSize.width - self.view.window!.frame.width) / 2.0
        })
        
        todoTab.selected = false
        doingTab.selected = true
        doneTab.selected = false
        pageNumber = 1
    }
    
    func selectDoneTab(tapped: Bool) {

        if (tapped) {
            UIView.animateWithDuration(0.3, animations: { () -> Void in
                self.containerScrollView.contentOffset.x = self.containerScrollView.contentSize.width - self.view.window!.frame.width
            })
        } else {
            UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 0.65, initialSpringVelocity: 0, options: .CurveEaseIn, animations: { () -> Void in
                self.containerScrollView.contentOffset.x = self.containerScrollView.contentSize.width - self.view.window!.frame.width
                }, completion: nil)
        }
        
        todoTab.selected = false
        doingTab.selected = false
        doneTab.selected = true
        pageNumber = 2
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}


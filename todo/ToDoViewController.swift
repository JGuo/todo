//
//  ViewController.swift
//  todo
//
//  Created by Jisi Guo on 2/29/16.
//  Copyright © 2016 Jisi Guo. All rights reserved.
//

import UIKit

let ROW_HEIGHT = CGFloat(70)

class ToDoViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate {
    
    @IBOutlet weak var containerScrollView: UIScrollView!
    @IBOutlet weak var todoTableView: UITableView!
    @IBOutlet weak var doingTableView: UITableView!
    
    @IBOutlet weak var rightCard: UIView!
    @IBOutlet weak var tamagotchiView: UIView!
    @IBOutlet weak var boobieView: UIView!
    @IBOutlet weak var cloud1: UIImageView!
    @IBOutlet weak var cloud2: UIImageView!
    @IBOutlet weak var eyesView: UIImageView!
    @IBOutlet weak var shadow: UIImageView!
    @IBOutlet weak var bodyView: UIImageView!
    @IBOutlet weak var mouthView: UIImageView!
    
    @IBOutlet weak var tabBarView: UIView!
    @IBOutlet weak var todoTab: UIButton!
    @IBOutlet weak var doingTab: UIButton!
    @IBOutlet weak var doneTab: UIButton!
    var pageNumber : Int!
    
    var initialScrollViewContentOffset: CGPoint!
    
    var todos : NSArray!
    var doing : NSArray!
    
    //eyes animation
    var images: [UIImage]!
    var animatedImage: UIImage!
    
    
    
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
        
        // Hide the top cell, so that it's only revealed on scroll
        todoTableView.contentInset.top = -ROW_HEIGHT
        
        todoTab.selected = true
        pageNumber = 0
        
        
        // Right Card
        
        //Eye animation
        let eyeOpen = UIImage(named: "eyes")!
        let eyeClose = UIImage(named: "eyes_close")!
        let eyeImages = [eyeOpen, eyeOpen, eyeOpen, eyeOpen, eyeOpen, eyeOpen, eyeOpen, eyeOpen, eyeOpen, eyeOpen, eyeOpen, eyeOpen, eyeOpen, eyeOpen, eyeOpen, eyeClose]
        let animatedImage = UIImage.animatedImageWithImages(eyeImages, duration: 3.0)
        eyesView.image = animatedImage
        
        //Body animation
        let body1 = UIImage(named: "body1")!
        let body2 = UIImage(named: "body2")!
        let bodyImages = [body1, body2]
        let animatedBodyImage = UIImage.animatedImageWithImages(bodyImages, duration: 1.0)
        bodyView.image = animatedBodyImage
        
        //Character floating animation
        UIView.animateWithDuration(0.8, delay: 0.0,
            // Autoreverse runs the animation backwards and Repeat cycles the animation indefinitely.
            options: [UIViewAnimationOptions.Autoreverse,
                UIViewAnimationOptions.Repeat], animations: { () -> Void in
                    self.boobieView.transform = CGAffineTransformMakeTranslation(0, 10)
            }, completion: nil)
        
        UIView.animateWithDuration(0.8, delay: 0.0,
            // Autoreverse runs the animation backwards and Repeat cycles the animation indefinitely.
            options: [UIViewAnimationOptions.Autoreverse,
                UIViewAnimationOptions.Repeat], animations: { () -> Void in
                    self.shadow.transform = CGAffineTransformMakeScale(0.7,1)
                    self.shadow.alpha = 0.5
            }, completion: nil)
        
        //Cloud animation
        UIView.animateWithDuration(5, delay: 0.0,
            // Autoreverse runs the animation backwards and Repeat cycles the animation indefinitely.
            options: [UIViewAnimationOptions.Autoreverse,
                UIViewAnimationOptions.Repeat], animations: { () -> Void in
                    self.cloud1.transform = CGAffineTransformMakeTranslation(30, -30)
                    self.cloud2.transform = CGAffineTransformMakeTranslation(-30, 30)
                    self.cloud1.alpha = 0.2
                    self.cloud2.alpha = 0.2
            }, completion: nil)

        
        
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
        
        if (scrollView == containerScrollView) {
            
        }
    }
    
    func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        NSLog("DONE SCROLLING!: %@", decelerate)
        if (scrollView == containerScrollView) {
            print("DONE scrolling")
            scrollToPage()
        }
    }
    
    func scrollViewWillBeginDecelerating(scrollView: UIScrollView) {
        if (scrollView == containerScrollView) {
            print("DONE scrolling")
            scrollView.setContentOffset(scrollView.contentOffset, animated: false)
            scrollToPage()
        }
    }
    
    
    //    CODE FOR TAB BAR BUTTONS
    
    @IBAction func tapTodoTab(sender: UIButton) {
        print("tapped on todo tab")
        
        selectTodoTab(true)
    }
    
    @IBAction func tapDoingTab(sender: UIButton) {
        print("tapped on doing tab")
        
        selectDoingTab()
    }
    
    
    @IBAction func tapDoneTab(sender: UIButton) {
        print("tapped on done tab")
        
        selectDoneTab(true)
    }
    
    @IBAction func tabBarDidPan(sender: UIPanGestureRecognizer) {
        print("did pan")
        
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
    
    func scrollToPage() {
        if (pageNumber == 0) {
            print("started on first card")
            if (self.containerScrollView.contentOffset.x < self.view.frame.width / 3.0) {
                print("go back")
                selectTodoTab(false)
            } else {
                print("go to doing")
                selectDoingTab()
            }
        } else if (pageNumber == 1) {
            print("started on second card")
            if (self.containerScrollView.contentOffset.x < 38 + 300 + 7) {
                selectTodoTab(false)
            } else if (self.rightCard.frame.origin.x > self.containerScrollView.contentSize.width - 38 - 300 - 7) {
                selectDoneTab(false)
            } else {
                selectDoingTab()
            }
        } else if (pageNumber == 2) {
            print("started on third card")
            if (self.containerScrollView.contentOffset.x > self.containerScrollView.contentSize.width - self.view.window!.frame.width) {
                selectDoneTab(false)
            } else if (self.rightCard.frame.origin.x > self.containerScrollView.contentSize.width - 38 - 300 - 7) {
                self.selectDoingTab()
            }
        }
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
   
    
}


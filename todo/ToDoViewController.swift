//
//  ViewController.swift
//  todo
//
//  Created by Jisi Guo on 2/29/16.
//  Copyright © 2016 Jisi Guo. All rights reserved.
//

import UIKit

let ROW_HEIGHT = CGFloat(70)

class ToDoViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate, UIGestureRecognizerDelegate {
    
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
    @IBOutlet weak var angryImage: UIImageView!
    
    @IBOutlet weak var scoreLabel: UILabel!
    var currentScore: Int!
    var totalScore: Int!
    
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
    
    //eyes animation
    var images: [UIImage]!
    var animatedImage: UIImage!
    
    
    @IBAction func tapScore(sender: UIButton) {
        print("tapped score")
        self.addScore(1)
    }
    
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
        
        // Right Card
        
        angryImage.hidden = true

        
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
                UIViewAnimationOptions.Repeat,UIViewAnimationOptions.AllowUserInteraction], animations: { () -> Void in
                    self.boobieView.transform = CGAffineTransformMakeTranslation(0, 10)
            }, completion: nil)
        
        UIView.animateWithDuration(0.8, delay: 0.0,
            // Autoreverse runs the animation backwards and Repeat cycles the animation indefinitely.
            options: [UIViewAnimationOptions.Autoreverse,
                UIViewAnimationOptions.Repeat], animations: { () -> Void in
                    self.shadow.transform = CGAffineTransformMakeScale(0.7,1)
                    self.shadow.alpha = 0.5
            }, completion: nil)
        
        UIView.animateWithDuration(0.8, delay: 0.0,
            // Autoreverse runs the animation backwards and Repeat cycles the animation indefinitely.
            options: [UIViewAnimationOptions.Autoreverse,
                UIViewAnimationOptions.Repeat], animations: { () -> Void in
                    self.mouthView.transform = CGAffineTransformMakeScale(0.8,1)
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
    
    func addScore(i: Int) {
        print("adding score")
        currentScore = Int(scoreLabel.text!)
        totalScore = currentScore + i
        scoreLabel.text = String(totalScore)
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell : UITableViewCell!
        
        if (tableView == todoTableView) {
            let cell = tableView.dequeueReusableCellWithIdentifier("com.todo.todocellview", forIndexPath: indexPath) as! ToDoTableViewCell
            
            let multiplier = 1.0 / CGFloat(todos.count + 5)
            
            cell.backgroundColor = UIColor(red:0.51, green:0.77, blue:0.9, alpha:1.0 - CGFloat(indexPath.row + 5) * multiplier / 1.0)
            
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

        if (scrollView == todoTableView) {
            if (pullToCreate == true) {
                todos.removeObjectAtIndex(0)
                todos.insertObject("New", atIndex: 0)
                todoTableView.reloadData()
                    
                let cell = todoTableView.cellForRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 0)) as! ToDoTableViewCell
                cell.textField.becomeFirstResponder()

                pullToCreate = false
            } else {
                todos.removeObjectAtIndex(0)
                todoTableView.reloadData()
            }

            placeholderToDo = nil
        }
            
        if (scrollView == doingTableView) {
            if (pullToCreate == true) {
                doing.removeObjectAtIndex(0)
                doing.insertObject("New", atIndex: 0)
                doingTableView.reloadData()
                
                let cell = doingTableView.cellForRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 0)) as! DoingTableViewCell
                cell.textField.becomeFirstResponder()
            } else {
                doing.removeObjectAtIndex(0)
                doingTableView.reloadData()
            }
            
            placeholderDoing = nil
        }
        
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
        
        print(translation)
        
        if (sender.state == UIGestureRecognizerState.Began) {
            initialScrollViewContentOffset = containerScrollView.contentOffset
            
        }  else if (sender.state == UIGestureRecognizerState.Changed) {
            
            containerScrollView.contentOffset.x = initialScrollViewContentOffset.x - translation.x
            
        }  else if (sender.state == UIGestureRecognizerState.Ended) {
            scrollToPage()
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
            if (self.containerScrollView.contentOffset.x < self.view.frame.width / 6.0) {
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
    
    func delay(delay:Double, closure:()->()) {
        dispatch_after(
            dispatch_time(
                DISPATCH_TIME_NOW,
                Int64(delay * Double(NSEC_PER_SEC))
            ),
            dispatch_get_main_queue(), closure)
    }
    
    //Tamagochi Tap Gesture 
    @IBAction func didTapBoobie(sender: UITapGestureRecognizer) {
        angryImage.hidden = false
        self.mouthView.transform = CGAffineTransformMakeScale(1.2,1.4)
        
        delay(0.2) {
            self.angryImage.hidden = true
            self.mouthView.transform = CGAffineTransformMakeScale(1,1)

        }
    }
}


//
//  DoingTableViewCell.swift
//  todo
//
//  Created by Vishay Nihalani on 3/16/16.
//  Copyright © 2016 Jisi Guo. All rights reserved.
//

import UIKit

class DoingTableViewCell: UITableViewCell, UITextFieldDelegate {

    @IBOutlet weak var textField: UITextField!
    
    weak var todoViewController: ToDoViewController!
    weak var tableView: UITableView!
    
    var initialCenter : CGPoint!
    var initialFrame : CGRect!
    var todoOnRelease = false
    var doneOnRelease = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        let recognizer = UIPanGestureRecognizer(target: self, action: "handlePan:")
        recognizer.delegate = self
        addGestureRecognizer(recognizer)
        
        textField.delegate = self
    }
    
    override func gestureRecognizerShouldBegin(gestureRecognizer: UIGestureRecognizer) -> Bool {

        if let panGestureRecognizer = gestureRecognizer as? UIPanGestureRecognizer {
            let translation = panGestureRecognizer.translationInView(superview!)
            if fabs(translation.x) > fabs(translation.y) {
                return true
            }
            return false
        }
        return false
    }

    func handlePan(recognizer: UIPanGestureRecognizer!) {
        let translation = recognizer.translationInView(self)
        
        if (recognizer .state == .Began) {
            initialCenter = center
        }
        
        if (recognizer .state  == .Changed) {
            
            center = CGPointMake(initialCenter.x + translation.x, initialCenter.y)
            
            todoOnRelease = frame.origin.x < -frame.size.width / 2.0
            doneOnRelease = frame.origin.x > frame.size.width / 2.0
        }
        
        if (recognizer .state == .Ended) {
            
            initialFrame = CGRectMake(0, frame.origin.y, frame.size.width, frame.size.height)
            
            if (translation.x < 0) {
                if !todoOnRelease {
                    UIView.animateWithDuration(0.2, animations: { self.frame = self.initialFrame })
                } else {
                    UIView.animateWithDuration(0.2,
                        animations: { () -> Void in
                            self.frame = CGRectMake(-self.frame.size.width, self.frame.origin.y, self.frame.size.width, self.frame.size.height)
                        },
                        completion: { (finished) -> Void in
                            
                            self.todoViewController.todos.addObject(self.textField!.text!)
                            self.todoViewController.todoTableView.reloadData()
                            
                            let myIndex = self.todoViewController.doingTableView.indexPathForCell(self)
                            self.todoViewController.doing.removeObjectAtIndex((myIndex?.row)!)
                            self.todoViewController.doingTableView.reloadData()
                        }
                    )
                }
            }
            
            if (translation.x > 0) {
                if !doneOnRelease {
                    UIView.animateWithDuration(0.2, animations: { self.frame = self.initialFrame })
                } else {
                    UIView.animateWithDuration(0.2,
                        animations: { () -> Void in
                            self.frame = CGRectMake(self.frame.size.width, self.frame.origin.y, self.frame.size.width, self.frame.size.height)
                        },
                        completion: { (finished) -> Void in
                            
                            let myIndex = self.todoViewController.doingTableView.indexPathForCell(self)
                            self.todoViewController.doing.removeObjectAtIndex((myIndex?.row)!)
                            self.todoViewController.doingTableView.reloadData()

                            
                            self.todoViewController.selectDoneTab(true)
                            self.todoViewController.chew()
                    })
                }
            }
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        textField.endEditing(true)
        return true
    }

    func textFieldDidEndEditing(textField: UITextField) {
        let myIndex = self.todoViewController.doingTableView.indexPathForCell(self)
        self.todoViewController.doing.removeObjectAtIndex((myIndex?.row)!)
        self.todoViewController.doing.insertObject(textField.text!, atIndex: (myIndex?.row)!)
        self.todoViewController.doingTableView.reloadData()
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

//
//  ToDoTableViewCell.swift
//  todo
//
//  Created by Vishay Nihalani on 3/9/16.
//  Copyright © 2016 Jisi Guo. All rights reserved.
//

import UIKit

class ToDoTableViewCell: UITableViewCell {

    @IBOutlet weak var textField: UITextField!
    
    var initialCenter : CGPoint!
    var initialFrame : CGRect!
    var deleteOnRelease = false
    var moveToDoingOnRelease = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        let recognizer = UIPanGestureRecognizer(target: self, action: "handlePan:")
        recognizer.delegate = self
        addGestureRecognizer(recognizer)
    }
    
    func handlePan(recognizer: UIPanGestureRecognizer!) {
        let translation = recognizer.translationInView(self)
        
        if (recognizer .state == .Began) {
            initialCenter = center
        }
        
        if (recognizer .state  == .Changed) {

            center = CGPointMake(initialCenter.x + translation.x, initialCenter.y)
            
            deleteOnRelease = frame.origin.x < -frame.size.width / 2.0
            moveToDoingOnRelease = frame.origin.x > frame.size.width / 2.0
        }
        
        if (recognizer .state == .Ended) {
         
            initialFrame = CGRectMake(0, frame.origin.y, frame.size.width, frame.size.height)
            
            if (translation.x < 0) {
                if !deleteOnRelease {
                    UIView.animateWithDuration(0.2, animations: { self.frame = self.initialFrame })
                } else {
                    UIView.animateWithDuration(0.2, animations: { self.frame = CGRectMake(-self.frame.size.width, self.frame.origin.y, self.frame.size.width, self.frame.size.height) })
                }
            }
            
            if (translation.x > 0) {
                if !moveToDoingOnRelease {
                    UIView.animateWithDuration(0.2, animations: { self.frame = self.initialFrame })
                } else {
                    UIView.animateWithDuration(0.2, animations: { self.frame = CGRectMake(self.frame.size.width, self.frame.origin.y, self.frame.size.width, self.frame.size.height) })
                }
            }
        }
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

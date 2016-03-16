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
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var leftCard: UIView!
    @IBOutlet weak var rightCard: UIView!
    
    var todos : NSArray!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        scrollView.contentSize = CGSize(width: 3 * 375, height: self.view.frame.height)
        
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


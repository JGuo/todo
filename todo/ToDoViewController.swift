//
//  ViewController.swift
//  todo
//
//  Created by Jisi Guo on 2/29/16.
//  Copyright © 2016 Jisi Guo. All rights reserved.
//

import UIKit

class ToDoViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var todos : NSArray!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        todos = [0, 1, 2, 3, 4, 5, 6, 7]
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("com.todo.todocellview", forIndexPath: indexPath) as! ToDoTableViewCell
        
        let multiplier = 255.0 / CGFloat(todos.count + 5)
        
        cell.backgroundColor = UIColor(red: CGFloat(indexPath.row + 5) * multiplier / 255.0, green: 0, blue: 0, alpha: 1.0)

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


//
//  DoingTableViewCell.swift
//  todo
//
//  Created by Vishay Nihalani on 3/16/16.
//  Copyright © 2016 Jisi Guo. All rights reserved.
//

import UIKit

class DoingTableViewCell: UITableViewCell {

    @IBOutlet weak var textField: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

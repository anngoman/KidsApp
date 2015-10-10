//
//  TaskTableViewCell.swift
//  KidsApp
//
//  Created by Anna Goman on 01.09.15.
//  Copyright (c) 2015 Anna Goman. All rights reserved.
//

import UIKit
import SESlideTableViewCell

let userTaskReuseIdentifier = "UserTaskCell"

class TaskTableViewCell: SESlideTableViewCell {
  @IBOutlet weak var taskLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

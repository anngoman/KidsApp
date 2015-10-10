//
//  PersonButton.swift
//  KidsApp
//
//  Created by Anna Goman on 24.08.15.
//  Copyright (c) 2015 Anna Goman. All rights reserved.
//

import UIKit

class NextButton: UIButton {

  
  override func drawRect(rect: CGRect) {
    super.drawRect(rect)

    self.layer.cornerRadius = frame.size.width/6;
    self.layer.borderWidth = 2;
    self.layer.borderColor = UIColor.whiteColor().CGColor

  }
  
  
  
  
}

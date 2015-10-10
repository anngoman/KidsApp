//
//  PersonButton.swift
//  KidsApp
//
//  Created by Anna Goman on 25.08.15.
//  Copyright (c) 2015 Anna Goman. All rights reserved.
//

import UIKit

class PersonButton: UIButton {
  override var selected: Bool {
    didSet {
      
      if (selected) {
        imageView?.layer.borderColor = ORANGE_COLOR.CGColor
      }
      else {
        imageView?.layer.borderColor = UIColor.clearColor().CGColor
        
      }
      
    }
  }  
  
  override func drawRect(rect: CGRect) {
    super.drawRect(rect)
    titleLabel!.lineBreakMode = NSLineBreakMode.ByWordWrapping
    titleLabel!.numberOfLines = 2;
    titleLabel!.textAlignment = NSTextAlignment.Center
    imageView?.layer.cornerRadius = 15;
    imageView?.layer.borderWidth = 5;
    imageView?.layer.borderColor = UIColor.clearColor().CGColor
    
  }

}

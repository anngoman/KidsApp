//
//  RoundedTextField.swift
//  KidsApp
//
//  Created by Anna Goman on 25.08.15.
//  Copyright (c) 2015 Anna Goman. All rights reserved.
//

import UIKit

class RoundedTextField: UITextField {
  
  
  override func drawRect(rect: CGRect) {
    super.drawRect(rect)
    layer.cornerRadius = 10;
    layer.borderWidth = 4;
    layer.borderColor = UIColor.whiteColor().CGColor
  }
  
  override func textRectForBounds(bounds: CGRect) -> CGRect {
    return CGRectInset(bounds, 20, 10)
  }

  override func editingRectForBounds(bounds: CGRect) -> CGRect {
    return CGRectInset(bounds, 20, 10)
  }
  
 
}

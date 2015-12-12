//
//  ViewController+Orientation.swift
//  KidsApp
//
//  Created by Anna Goman on 31.08.15.
//  Copyright (c) 2015 Anna Goman. All rights reserved.
//

import Foundation
import UIKit


extension UINavigationController {
  public override func shouldAutorotate() -> Bool {
    return true
  }
  
  public override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
    return UIInterfaceOrientationMask.Landscape
  }
  
}

extension UIImagePickerController {
  
  public override func shouldAutorotate() -> Bool {
    return true
  }
  
  public override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
    return UIInterfaceOrientationMask.Landscape
  }

}



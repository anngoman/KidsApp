//
//  UserTypePicker.swift
//  KidsApp
//
//  Created by Anna Goman on 25.08.15.
//  Copyright (c) 2015 Anna Goman. All rights reserved.
//

import UIKit


class UserTypePicker: UIView {
  var view: UIView!
  @IBOutlet var firstButton: PersonButton!
  @IBOutlet var secondButton: PersonButton!
  @IBOutlet var thirdButton: PersonButton!
  var type = PersonType.Child
  var selectedType: PersonType {
    get {
      return type
    }
    set {
      if type != newValue {
        buttonOfType(type).selected = false
        buttonOfType(newValue).selected = true
        type = newValue
      }
    }
  }
  
  // MARK: - Init
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    xibSetup()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    xibSetup()
  }

  
  
  // MARK: - Load Xib
  
  func xibSetup() {
    view = loadViewFromNib()
    
    view.frame = bounds
    
    view.autoresizingMask = [UIViewAutoresizing.FlexibleWidth, UIViewAutoresizing.FlexibleHeight]
    
    addSubview(view)
    
    
  }
  
  func loadViewFromNib() -> UIView {
    
    let bundle = NSBundle(forClass: self.dynamicType)
    let nib = UINib(nibName: "UserTypePicker", bundle: bundle)
    let view = nib.instantiateWithOwner(self, options: nil)[0] as! UIView
    
    return view
  }
  
  
  // MARK: - Private
  
  func buttonOfType(type: PersonType) -> PersonButton {
    switch type {
    case .Child:
      return firstButton
    case .Fun:
      return secondButton
    case .Diet:
      return thirdButton
    }
  }
  
  // MARK: - IBAction
  
  @IBAction func chooseFirstType(sender: AnyObject) {
    selectedType = .Child
  }
  
  @IBAction func chooseSecondType(sender: AnyObject) {
    selectedType = .Fun
  }
  
  @IBAction func chooseThirdType(sender: AnyObject) {
    selectedType = .Diet
  }
  
}



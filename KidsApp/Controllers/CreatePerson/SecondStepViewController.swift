//
//  SecondStepViewController.swift
//  KidsApp
//
//  Created by Anna Goman on 24.08.15.
//  Copyright (c) 2015 Anna Goman. All rights reserved.
//

import UIKit

class SecondStepViewController: ResponsiveTextFieldViewController {
  @IBOutlet weak var firstNameTextField: RoundedTextField!
  @IBOutlet weak var secondNameTextField: RoundedTextField!
  @IBOutlet weak var ageTextField: RoundedTextField!
  @IBOutlet weak var bottomSpacingConstraint: NSLayoutConstraint!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
      if segue.identifier == "ToThirdStepSegue" {
        if let user = DataStore.sharedDataStore.newUser {
          user.firstName = firstNameTextField.text
          user.lastName = secondNameTextField.text
          if let age = Int(ageTextField.text) {
            user.age = age
          }
        }
      }
    }
}

extension SecondStepViewController: UITextFieldDelegate {
  override func textFieldDidBeginEditing(textField: UITextField) {
    super.textFieldDidBeginEditing(textField)
    textField.layer.borderColor = ORANGE_COLOR.CGColor

  }
  
  func textFieldDidEndEditing(textField: UITextField) {
    textField.layer.borderColor = UIColor.whiteColor().CGColor

  }
}



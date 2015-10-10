//
//  FirstStepViewController.swift
//  KidsApp
//
//  Created by Anna Goman on 24.08.15.
//  Copyright (c) 2015 Anna Goman. All rights reserved.
//

import UIKit

class FirstStepViewController: UIViewController {
  @IBOutlet weak var userTypePicker: UserTypePicker!

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  // MARK: - UI
 
  // In a storyboard-based application, you will often want to do a little preparation before navigation
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if segue.identifier == "ToSecondStepSegue" {
      DataStore.sharedDataStore.createUser(userTypePicker.selectedType)
    }
  }

  
}

//
//  CreatePersonViewController.swift
//  KidsApp
//
//  Created by Anna Goman on 24.08.15.
//  Copyright (c) 2015 Anna Goman. All rights reserved.
//

import UIKit

enum CreatePersonStep{
  case Type
  case Info
  case Avatar
}

class CreatePersonViewController: UIViewController {
  let dataStore = DataStore.sharedDataStore
  var users = dataContext.users.toArray()
  
  @IBOutlet weak var containerView: UIView!
  
  required init(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
  }
  
  
  /*
  // MARK: - Navigation
  
  // In a storyboard-based application, you will often want to do a little preparation before navigation
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
  // Get the new view controller using segue.destinationViewController.
  // Pass the selected object to the new view controller.
  }
  */  
  
}


extension CreatePersonViewController: UICollectionViewDataSource, UICollectionViewDelegate {
  
  func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return users.count + 1
  }
  
  func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
    if indexPath.row == users.count {
      let cell = collectionView.dequeueReusableCellWithReuseIdentifier(deleteReuseIdentifier, forIndexPath: indexPath) as! DeleteCollectionViewCell
      return cell
    }
    let cell = collectionView.dequeueReusableCellWithReuseIdentifier(personReuseIdentifier, forIndexPath: indexPath) as! PersonCollectionViewCell
    let user = users[indexPath.row]
    cell.configureCell(user)
    return cell
  }
  
  func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
    if indexPath.row == users.count {
    } else {
      dataStore.currentUser = users[indexPath.row]
//      performSegueWithIdentifier("TasksSegue", sender: nil)
    }
  }
  
  // MARK: - UI
  
}

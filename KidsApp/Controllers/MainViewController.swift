//
//  MainViewController.swift
//  KidsApp
//
//  Created by Anna Goman on 29.08.15.
//  Copyright (c) 2015 Anna Goman. All rights reserved.
//

import UIKit
import youtube_ios_player_helper

class MainViewController: UIViewController {
  let dataStore = DataStore.sharedDataStore
  var users = dataContext.users.toArray()
  @IBOutlet weak var videoContainerView: YTPlayerView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    videoContainerView.loadWithVideoId("L8YvNHc8aUo")
    // Do any additional setup after loading the view.
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  
  // MARK: - Navigation
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
  // Get the new view controller using segue.destinationViewController.
  // Pass the selected object to the new view controller.
    
  }

  
  // MARK: - IBAction
  
  
  @IBAction func openHelp(sender: UIButton) {
  }
  
  
  @IBAction func openPreference(sender: AnyObject) {
  }
  
}


extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
  
  func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return users.count + 1
  }
  
  func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
    if indexPath.row == users.count {
      let cell = collectionView.dequeueReusableCellWithReuseIdentifier(addReuseIdentifier, forIndexPath: indexPath) as! AddCollectionViewCell
      return cell
    }
    let cell = collectionView.dequeueReusableCellWithReuseIdentifier(personReuseIdentifier, forIndexPath: indexPath) as! PersonCollectionViewCell
    let user = users[indexPath.row]
    cell.configureCell(user)
    return cell
  }
  
  func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
    if indexPath.row == users.count {
      performSegueWithIdentifier("CreateSegue", sender: nil)
    } else {
      dataStore.currentUser = users[indexPath.row]
      performSegueWithIdentifier("TasksSegue", sender: nil)
    }
  }
  
}

//
//  AvatarCollectionViewController.swift
//  KidsApp
//
//  Created by Anna Goman on 26.08.15.
//  Copyright (c) 2015 Anna Goman. All rights reserved.
//

import UIKit

class AvatarCollectionViewController: UICollectionViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = false
    
    
    let gesture = UITapGestureRecognizer(target: self, action: Selector("closeController:"))
    gesture.cancelsTouchesInView = false
    gesture.numberOfTapsRequired = 1
    view.window?.addGestureRecognizer(gesture)
    
    // Do any additional setup after loading the view.
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  /*
  // MARK: - Navigation
  
  // In a storyboard-based application, you will often want to do a little preparation before navigation
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
  // Get the new view controller using [segue destinationViewController].
  // Pass the selected object to the new view controller.
  }
  */
  
  // MARK: UICollectionViewDataSource
  
  override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
    return 1
  }
  
  
  override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 6
  }
  
  override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCellWithReuseIdentifier(avatarReuseIdentifier, forIndexPath: indexPath) as! AvatarCollectionViewCell
    cell.imageView.image = UIImage(named: "icon")
    return cell
  }
  
  // MARK: UICollectionViewDelegate
  
  /*
  // Uncomment this method to specify if the specified item should be highlighted during tracking
  override func collectionView(collectionView: UICollectionView, shouldHighlightItemAtIndexPath indexPath: NSIndexPath) -> Bool {
  return true
  }
  */
  
  
  override func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
    if let user = DataStore.sharedDataStore.newUser {
      user.userImage = UIImage(named: "icon")
    }
    dismissViewControllerAnimated(true, completion: nil)
    return true
  }
  
  
  /*
  // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
  override func collectionView(collectionView: UICollectionView, shouldShowMenuForItemAtIndexPath indexPath: NSIndexPath) -> Bool {
  return false
  }
  
  override func collectionView(collectionView: UICollectionView, canPerformAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) -> Bool {
  return false
  }
  
  override func collectionView(collectionView: UICollectionView, performAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) {
  
  }
  */
  
  // MARK: - Private
  
  func closeController(sender: AnyObject) {
    println(sender)
    /*
    if (sender.state == UIGestureRecognizerStateEnded)
    {
    CGPoint location = [sender locationInView:nil]; //Passing nil gives us coordinates in the window
    
    //Convert tap location into the local view's coordinate system. If outside, dismiss the view.
    if (![self.presentedViewController.view pointInside:[self.presentedViewController.view convertPoint:location fromView:self.view.window] withEvent:nil])
    {
    if(self.presentedViewController) {
    [self dismissViewControllerAnimated:YES completion:nil];
    }
    }
    }
    */
  }
  
}

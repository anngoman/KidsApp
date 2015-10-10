//
//  ThirdStepViewController.swift
//  KidsApp
//
//  Created by Anna Goman on 24.08.15.
//  Copyright (c) 2015 Anna Goman. All rights reserved.
//

import UIKit

class ThirdStepViewController: UIViewController {
  @IBOutlet weak var openGalleryButton: UIButton!
  let imagePicker = UIImagePickerController()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    openGalleryButton.layer.cornerRadius = 10;
    openGalleryButton.layer.borderWidth = 4;
    openGalleryButton.layer.borderColor = ORANGE_COLOR.CGColor
    imagePicker.delegate = self
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
  
  @IBAction func createImage(sender: AnyObject) {
    let optionMenu = UIAlertController(title: "Загрузка аватара", message: "Выберите вариант", preferredStyle: .Alert)
    
    let libraryAction = UIAlertAction(title: "Открыть галерию", style: .Default, handler: {
      (alert: UIAlertAction!) -> Void in
      self.imagePicker.allowsEditing = false
      self.imagePicker.sourceType = .PhotoLibrary
      self.presentViewController(self.imagePicker, animated: true, completion: nil)
    })
    optionMenu.addAction(libraryAction)
    
    if UIImagePickerController.isSourceTypeAvailable(.Camera) {
      let photoAction = UIAlertAction(title: "Сделать фото", style: .Default, handler: {
        (alert: UIAlertAction!) -> Void in
        self.imagePicker.allowsEditing = false
        self.imagePicker.sourceType = .Camera
        self.presentViewController(self.imagePicker, animated: true, completion: nil)
      })
      optionMenu.addAction(photoAction)
    }
    optionMenu.addAction(UIAlertAction(title: "Отмена", style: UIAlertActionStyle.Cancel, handler: nil))
    
    self.presentViewController(optionMenu, animated: true, completion: nil)
  }
  
  @IBAction func complete(sender: AnyObject) {
    
    if DataStore.sharedDataStore.saveNewUser() {
      let successAlert = UIAlertController(title: "Создание заверешено!", message: nil, preferredStyle: .Alert)
      successAlert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Cancel, handler: { action in
        let controller = self.navigationController?.parentViewController as! CreatePersonViewController
        controller.performSegueWithIdentifier("MainControllerSegue", sender: nil)
      }))
      self.presentViewController(successAlert, animated: true, completion: nil)
      
    } else {
      let errorAlert = UIAlertController(title: "Ошибка при сохранение!", message: "Попробуйте позже", preferredStyle: .Alert)
      errorAlert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Cancel, handler: nil))
      self.presentViewController(errorAlert, animated: true, completion: nil)
    }
    
  }
  
  
}

extension ThirdStepViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  
  
  // MARK: - UIImagePickerControllerDelegate Methods
  
  func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
    if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
      if let user = DataStore.sharedDataStore.newUser {
        let size = min(pickedImage.size.width, pickedImage.size.height)
        let rect = CGRect(x: 0,y: 0, width: size, height: size)
        let imageRef = CGImageCreateWithImageInRect(pickedImage.CGImage, rect)
        user.userImage = UIImage(CGImage: imageRef)
      }
      
      //      imageView.contentMode = .ScaleAspectFit
      //      imageView.image = pickedImage
    }
    
    dismissViewControllerAnimated(true, completion: nil)
  }
  
  func imagePickerControllerDidCancel(picker: UIImagePickerController) {
    dismissViewControllerAnimated(true, completion: nil)
  }
  
}


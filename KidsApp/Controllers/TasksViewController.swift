//
//  TasksViewController.swift
//  KidsApp
//
//  Created by Anna Goman on 31.08.15.
//  Copyright (c) 2015 Anna Goman. All rights reserved.
//

import UIKit
import BetweenKit
import SESlideTableViewCell

enum TableViewType: Int {
  case Task = 0
  case UserTask
}

class TasksViewController: UIViewController {
  let dataStore = DataStore.sharedDataStore
  var tasks: [Task]!
  var userTasks: [UserTask]!
  var dragCoordinator: I3GestureCoordinator!
  var currentDate: NSDate!{
    didSet {
      userTasks = dataStore.fetchUserTasks(currentDate)
    }
  }
  
  @IBOutlet weak var taskCollectionView: UICollectionView!
  @IBOutlet weak var userTaskCollectionView: UICollectionView!
  
  @IBOutlet weak var taskTableView: UITableView!
  @IBOutlet weak var userTaskTableView: UITableView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    //    dataStore.createTestData()
    tasks = dataStore.fetchTasks()
    currentDate = NSDate()
    addDragCoordinator()
    // Do any additional setup after loading the view.
  }
  
  override func viewWillDisappear(animated: Bool) {
    super.viewWillDisappear(animated)
    dataStore.reorderUserTasks(userTasks)
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  
  // MARK: - UI
  
  func addDragCoordinator() {
    let longGesture = UILongPressGestureRecognizer()
    longGesture.minimumPressDuration = 0.2
    dragCoordinator = I3GestureCoordinator.basicGestureCoordinatorFromViewController(self, withCollections: [taskTableView, userTaskTableView], withRecognizer: longGesture)
    (dragCoordinator.renderDelegate as! I3BasicRenderDelegate).draggingItemOpacity = 0.3
  }
  
  
  // MARK: - IBAction
  
  @IBAction func addTask(sender: AnyObject) {
    let alert = UIAlertController(title: "Создание задачи", message: "Заполните название задачи", preferredStyle: .Alert)
    alert.addTextFieldWithConfigurationHandler {
      (txtEmail) -> Void in
      txtEmail.placeholder = "Введите название..."
    }
    alert.addAction(UIAlertAction(title: "Сохранить", style: UIAlertActionStyle.Default, handler: { action in
      let textField = alert.textFields?[0] as! UITextField
      self.dataStore.addNewTask(textField.text)
      self.reloadTasks()
    }))
    alert.addAction(UIAlertAction(title: "Отмена", style: UIAlertActionStyle.Cancel, handler:nil))
    self.presentViewController(alert, animated: true, completion: nil)
    
  }
  
  // MARK: - Private
  
  func reloadTasks() {
    self.tasks = self.dataStore.fetchTasks()
    self.taskTableView.reloadData()
  }
  
  func reloadUserTasks() {
    self.userTasks = self.dataStore.fetchUserTasks(currentDate)
    self.userTaskTableView.reloadData()
  }
  
}

extension TasksViewController : UITableViewDataSource, UITableViewDelegate {
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if tableView == taskTableView {
      return tasks.count
    } else {
      return userTasks.count
    }
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier(userTaskReuseIdentifier, forIndexPath: indexPath) as! TaskTableViewCell
    cell.delegate = self
    cell.addRightButtonWithText("DEL", textColor: UIColor.whiteColor(), backgroundColor: UIColor.redColor())
    if tableView == taskTableView {
      let task = tasks[indexPath.row]
      cell.taskLabel.text = task.name
      cell.tag = TableViewType.Task.rawValue
    } else {
      let userTask = userTasks[indexPath.row]
      cell.taskLabel.text = userTask.task.name
      cell.tag = TableViewType.UserTask.rawValue
      cell.addRightButtonWithText("DONE", textColor: UIColor.whiteColor(), backgroundColor: UIColor.greenColor())
      
    }
    return cell
  }
  
  
}


extension TasksViewController: SESlideTableViewCellDelegate {
  func slideTableViewCell(cell: SESlideTableViewCell!, didTriggerRightButton buttonIndex: Int) {
    if cell.tag == TableViewType.Task.rawValue {
      if let indexPath = taskTableView.indexPathForCell(cell) {
        let task = tasks[indexPath.row]
        dataStore.deleteTask(task)
        reloadTasks()
      }
    } else if cell.tag == TableViewType.UserTask.rawValue {
      if let indexPath = userTaskTableView.indexPathForCell(cell){
        let userTask = userTasks[indexPath.row]
        if buttonIndex == 0 {
          dataStore.deleteUserTask(userTask)
          userTasks.removeAtIndex(indexPath.row)
          userTaskTableView.deleteItemsAtIndexPaths([indexPath])
          userTaskTableView.reloadData()
        } else {
          dataStore.completeUserTask(userTask)
          userTaskTableView.reloadData()
        }
      }
    }
  }
}

extension TasksViewController: I3DragDataSource {
  
  func canItemBeDraggedAt(at: NSIndexPath!, inCollection collection: UIView!) -> Bool {
    return true
  }
  
  func canItemAt(from: NSIndexPath!, fromCollection: UIView!, beDroppedAtPoint at: CGPoint, onCollection toCollection: UIView!) -> Bool {
    if fromCollection == taskTableView {
      return true
    }
    return false
  }
  
  func canItemAt(from: NSIndexPath!, fromCollection: UIView!, beDroppedTo to: NSIndexPath!, onCollection toCollection: UIView!) -> Bool {
    if fromCollection == taskTableView {
      return true
    }
    return false
  }
  
  func canItemFrom(from: NSIndexPath!, beRearrangedWithItemAt to: NSIndexPath!, inCollection collection: UIView!) -> Bool {
    if collection == userTaskTableView {
      return true
    }
    return false
  }
  
  func dropItemAt(from: NSIndexPath!, fromCollection: UIView!, toItemAt to: NSIndexPath!, onCollection toCollection: UIView!) {
    let task = tasks[from.row]
    if let userTask = dataStore.addUserTask(task, date: NSDate()) {
      userTasks.insert(userTask, atIndex: to.row)
      userTaskTableView.insertItemsAtIndexPaths([to])
    } else {
      println("add user task error")
    }
  }
  
  func dropItemAt(from: NSIndexPath!, fromCollection: UIView!, toPoint to: CGPoint, onCollection toCollection: UIView!) {
    let indexPath = NSIndexPath(forRow: userTasks.count, inSection: 0)
    dropItemAt(from, fromCollection: fromCollection, toItemAt: indexPath, onCollection: toCollection)
  }
  
  func rearrangeItemAt(from: NSIndexPath!, withItemAt to: NSIndexPath!, inCollection collection: UIView!) {
    let userTask = userTasks[from.row]
    userTasks.removeAtIndex(from.row)
    userTasks.insert(userTask, atIndex: to.row)
    
    userTaskTableView.beginUpdates()
    userTaskTableView.deleteItemsAtIndexPaths([from])
    userTaskTableView.insertItemsAtIndexPaths([to])
    userTaskTableView.endUpdates()
    
  }
  
}

//extension TasksViewController : UICollectionViewDataSource, UICollectionViewDelegate {
//
//  func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//    if collectionView == taskCollectionView {
//      return tasks.count
//    } else {
//      return userTasks.count
//    }
//  }
//
//  func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
//
//    let cell = collectionView.dequeueReusableCellWithReuseIdentifier(taskReuseIdentifier, forIndexPath: indexPath) as! TaskCollectionViewCell
//    if collectionView == taskCollectionView {
//      let task = tasks[indexPath.row]
//      cell.taskLabel.text = task.name
//    } else {
//      let userTask = userTasks[indexPath.row]
//      cell.taskLabel.text = userTask.task.name
//    }
//    return cell
//  }
//
//
//}



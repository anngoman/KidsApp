//
//  DataStore.swift
//  KidsApp
//
//  Created by Anna Goman on 25.08.15.
//  Copyright (c) 2015 Anna Goman. All rights reserved.
//

import Foundation
import CoreData
import UIKit
import AlecrimCoreData

let kCurrentUser = "CurrentUserKey"

class DataStore {
  static let sharedDataStore = DataStore()
  var users: [User]!
  var currentUser: User!{
    willSet {
      if let currentUser = currentUser where currentUser != newValue {
        currentUser.current = false
        dataContext.save()
      }
    }
    didSet {
      if let currentUser = currentUser where currentUser.current == false {
        currentUser.current = true
        dataContext.save()
      }
    }
  }
  var newUser: User!
  
  init() {
    fetchUsers()
    fetchCurrentUser()
//deleteAllUserTasks()
  }
  
}

// MARK: - Users Method
extension DataStore {

  
  func createUser(type: PersonType) {
    newUser = dataContext.users.createEntity()
    newUser.type = Int(type.rawValue)
  }
  
  func saveNewUser()->Bool {
    newUser = nil
    return saveUserData()
  }
  
  func deleteUser(user: User)->Bool {
    dataContext.users.deleteEntity(user)
    return saveUserData()
  }
  
  func saveUserData()->Bool{
    if dataContext.save().0 {
      fetchUsers()
      return true
    } else {
      print("Save data error!!!")
      return false
    }
  }
  
  func fetchUsers(){
    users = dataContext.users.toArray()
  }
  
  func fetchCurrentUser(){
    currentUser = dataContext.users.filter{ $0.current == true }.first()
  }
  
}

// MARK: -  Task Method
extension DataStore {

  
  func addNewTask(name: String){
    let task = dataContext.tasks.createEntity()
    task.name = name
    task.type = currentUser.type
    dataContext.save()
  }
  
  func deleteTask(task: Task) {
    dataContext.tasks.deleteEntity(task)
    dataContext.save()
  }
  
  func fetchTasks()->[Task]{
    return dataContext.tasks.filter{ $0.type == self.currentUser.type }.toArray()
  }
  
  func addUserTask(task: Task, date: NSDate) -> UserTask? {
    let userTask = dataContext.userTasks.createEntity()
    userTask.task = task
    userTask.date = date
    userTask.user = currentUser
    userTask.index = dataContext.userTasks.count()
    if dataContext.save().0 {
      return userTask
    } else {
      return nil
    }
  }
  
  func deleteUserTask(userTask: UserTask) {
    dataContext.userTasks.deleteEntity(userTask)
    dataContext.save()
  }
  
  func completeUserTask(userTask: UserTask) {
    userTask.succesed = true
    dataContext.save()
  }
  
  func reorderUserTasks(userTasks: [UserTask]){
    var i = 0    
    for task in userTasks {
      task.index = i++
    }
    dataContext.save()
  }
  
  
  func test() {
    
    //    let tasks = dataContext.userTasks.toArray()
    //    let tasks2 = getUserTasks(NSDate().dateByAddingDays(1))
    //    let tasks3 = getUserTasks(NSDate().dateByAddingDays(2))
    
    print("")
  }
  
  func createTestData() {
    for index in 0...5 {
      let task = dataContext.tasks.createEntity() as Task
      task.type = currentUser.type
      
      let userTask = dataContext.userTasks.createEntity() as UserTask
      userTask.task = task
      userTask.user = currentUser
      userTask.date = NSDate()
      userTask.index = index
    }
    
    dataContext.save()
  }
  
  func deleteAllUserTasks(){
    let userTasks = dataContext.userTasks.toArray()
    for userTask in userTasks {
      dataContext.userTasks.deleteEntity(userTask)
    }
    dataContext.save()
  }
  
  func fetchUserTasks(date: NSDate) -> [UserTask]{
    var array = dataContext.userTasks.filter{ $0.user == self.currentUser }.toArray() as [UserTask]
    array = array.filter({$0.date.isEqualToDateIgnoringTime(date)}).sort({$0.index < $1.index})
    return array
  }
  
  
  
}
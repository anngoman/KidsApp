//
//  Task.swift
//  KidsApp
//
//  Created by Anna Goman on 27.08.15.
//  Copyright (c) 2015 Anna Goman. All rights reserved.
//

import Foundation
import CoreData
import AlecrimCoreData

class Task: NSManagedObject {
  
  @NSManaged var name: String
  @NSManaged var type: Int
  @NSManaged var userTask: NSSet
  var userType: PersonType {
    get {
      return PersonType(rawValue: type)!
    }
    set {
      type = newValue.rawValue
    }
  }
}



extension Task {
  
  static let name = AlecrimCoreData.Attribute<String?>("name")
  static let type = AlecrimCoreData.Attribute<Int>("type")
  static let userTasks = AlecrimCoreData.EntitySetAttribute<Set<UserTask>>("userTasks")
  
}



class TaskAttribute<T>: AlecrimCoreData.SingleEntityAttribute<T> {
  override init(_ name: String) { super.init(name) }
  
  lazy var name: AlecrimCoreData.Attribute<String?> = { AlecrimCoreData.Attribute<String?>("\(self.___name).name") }()
  lazy var type: AlecrimCoreData.Attribute<Int> = { AlecrimCoreData.Attribute<Int>("\(self.___name).type") }()
  lazy var userTasks: AlecrimCoreData.EntitySetAttribute<Set<UserTask>> = { AlecrimCoreData.EntitySetAttribute<Set<UserTask>>("\(self.___name).userTasks") }()
  
}



/*

extension UserTask {



static let index = AlecrimCoreData.Attribute<Int>("index")

static let date = AlecrimCoreData.Attribute<NSDate>("date")

static let user = UserAttribute<User>("user")

static let task = TaskAttribute<Task>("task")



}



class UserTaskAttribute<T>: AlecrimCoreData.SingleEntityAttribute<T> {



override init(_ name: String) { super.init(name) }



lazy var index: AlecrimCoreData.Attribute<Int> = { AlecrimCoreData.Attribute<Int>("\(self.___name).index") }()

lazy var date: AlecrimCoreData.Attribute<NSDate> = { AlecrimCoreData.Attribute<NSDate>("\(self.___name).date") }()

lazy var user: UserAttribute<User> = { UserAttribute<User>("\(self.___name).user") }()

lazy var task: TaskAttribute<Task> = { TaskAttribute<Task>("\(self.___name).task") }()





}



extension User {



static let firstName = AlecrimCoreData.Attribute<String?>("firstName")

static let lastName = AlecrimCoreData.Attribute<String?>("lastName")

static let age = AlecrimCoreData.Attribute<Int>("age")

static let type = AlecrimCoreData.Attribute<Int>("type")

static let points = AlecrimCoreData.Attribute<Int>("points")

static let userTasks = AlecrimCoreData.EntitySetAttribute<Set<UserTask>>("userTasks")



}



class UserAttribute<T>: AlecrimCoreData.SingleEntityAttribute<T> {



override init(_ name: String) { super.init(name) }



lazy var firstName: AlecrimCoreData.Attribute<String?> = { AlecrimCoreData.Attribute<String?>("\(self.___name).firstName") }()

lazy var lastName: AlecrimCoreData.Attribute<String?> = { AlecrimCoreData.Attribute<String?>("\(self.___name).lastName") }()



lazy var age: AlecrimCoreData.Attribute<Int> = { AlecrimCoreData.Attribute<Int>("\(self.___name).age") }()

lazy var type: AlecrimCoreData.Attribute<Int> = { AlecrimCoreData.Attribute<Int>("\(self.___name).type") }()

lazy var points: AlecrimCoreData.Attribute<Int> = { AlecrimCoreData.Attribute<Int>("\(self.___name).points") }()

lazy var userTasks: AlecrimCoreData.EntitySetAttribute<Set<UserTask>> = { AlecrimCoreData.EntitySetAttribute<Set<UserTask>>("\(self.___name).userTasks") }()



}





*/
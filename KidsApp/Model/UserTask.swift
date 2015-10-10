//
//  UserTask.swift
//  KidsApp
//
//  Created by Anna Goman on 27.08.15.
//  Copyright (c) 2015 Anna Goman. All rights reserved.
//

import Foundation
import CoreData
import AlecrimCoreData

class UserTask: NSManagedObject {
  
  @NSManaged var date: NSDate
  @NSManaged var succesed: Bool
  @NSManaged var index: Int
  @NSManaged var task: Task
  @NSManaged var user: User
}

extension UserTask {
  
  static let date = AlecrimCoreData.Attribute<NSDate>("date")
  static let succesed = AlecrimCoreData.Attribute<Bool>("succesed")
  static let index = AlecrimCoreData.Attribute<Int>("index")
  static let user = UserAttribute<User>("user")
  static let task = TaskAttribute<Task>("task")
  
}



class UserTaskAttribute<T>: AlecrimCoreData.SingleEntityAttribute<T> {
  
  override init(_ name: String) { super.init(name) }
  
  lazy var date: AlecrimCoreData.Attribute<NSDate> = { AlecrimCoreData.Attribute<NSDate>("\(self.___name).date") }()
  lazy var succesed: AlecrimCoreData.Attribute<Bool> = { AlecrimCoreData.Attribute<Bool>("\(self.___name).succesed") }()
  lazy var user: UserAttribute<User> = { UserAttribute<User>("\(self.___name).user") }()
  lazy var task: TaskAttribute<Task> = { TaskAttribute<Task>("\(self.___name).task") }()
  lazy var index: TaskAttribute<Int> = { TaskAttribute<Int>("\(self.___name).index") }()
  
}



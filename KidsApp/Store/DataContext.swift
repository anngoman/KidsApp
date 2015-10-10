//
//  DataContext.swift
//  KidsApp
//
//  Created by Anna Goman on 27.08.15.
//  Copyright (c) 2015 Anna Goman. All rights reserved.
//

import Foundation
import CoreData
import AlecrimCoreData

let dataContext = DataContext()

class DataContext: Context {
  
  var users: Table<User> { return Table<User>(context: self) }
  var tasks: Table<Task> { return Table<Task>(context: self) }
  var userTasks: Table<UserTask> { return Table<UserTask>(context: self) }

}
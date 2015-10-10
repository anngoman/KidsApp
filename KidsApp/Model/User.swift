//
//  User.swift
//  KidsApp
//
//  Created by Anna Goman on 27.08.15.
//  Copyright (c) 2015 Anna Goman. All rights reserved.
//

import Foundation
import CoreData
import AlecrimCoreData

enum PersonType: Int {
  case Child
  case Fun
  case Diet
}

class User: NSManagedObject {
  
  @NSManaged var age: Int
  @NSManaged var firstName: String
  @NSManaged var lastName: String
  @NSManaged var points: Int
  @NSManaged var type: Int
  @NSManaged var current: Bool
  @NSManaged var userTask: NSSet
  @NSManaged var image: NSData?
  @NSManaged var purchase: NSSet

  var userType: PersonType {
    get {
      return PersonType(rawValue: type)!
    }
    set {
      type = newValue.rawValue
    }
  }
  var fullName: String {
    get {
      if !lastName.isEmpty {
        return firstName + " " + lastName
      } else {
        return firstName
      }
    }
  }
  var userImage: UIImage? {
    set {
      image = UIImageJPEGRepresentation(newValue, 8.0)
    }
    get {
      if let image = image {
        return UIImage(data: image)
      }
      return nil
    }
  }
  
}

extension User {
  
  static let firstName = AlecrimCoreData.Attribute<String?>("firstName")
  static let lastName = AlecrimCoreData.Attribute<String?>("lastName")
  static let age = AlecrimCoreData.Attribute<Int>("age")
  static let type = AlecrimCoreData.Attribute<Int>("type")
  static let points = AlecrimCoreData.Attribute<Int>("points")
  static let userTasks = AlecrimCoreData.EntitySetAttribute<Set<UserTask>>("userTasks")
  static let image = AlecrimCoreData.Attribute<NSData>("image")
  static let purchase = TaskAttribute<Purchase>("purchase")
  static let current = AlecrimCoreData.Attribute<Bool>("current")

}



class UserAttribute<T>: AlecrimCoreData.SingleEntityAttribute<T> {
  
  override init(_ name: String) { super.init(name) }
  
  lazy var firstName: AlecrimCoreData.Attribute<String?> = { AlecrimCoreData.Attribute<String?>("\(self.___name).firstName") }()
  lazy var lastName: AlecrimCoreData.Attribute<String?> = { AlecrimCoreData.Attribute<String?>("\(self.___name).lastName") }()
  lazy var current: AlecrimCoreData.Attribute<Bool> = { AlecrimCoreData.Attribute<Bool>("\(self.___name).current") }()
  lazy var age: AlecrimCoreData.Attribute<Int> = { AlecrimCoreData.Attribute<Int>("\(self.___name).age") }()
  lazy var type: AlecrimCoreData.Attribute<Int> = { AlecrimCoreData.Attribute<Int>("\(self.___name).type") }()
  lazy var points: AlecrimCoreData.Attribute<Int> = { AlecrimCoreData.Attribute<Int>("\(self.___name).points") }()
  lazy var userTasks: AlecrimCoreData.EntitySetAttribute<Set<UserTask>> = { AlecrimCoreData.EntitySetAttribute<Set<UserTask>>("\(self.___name).userTasks") }()
  lazy var image: AlecrimCoreData.Attribute<NSData> = { AlecrimCoreData.Attribute<NSData>("\(self.___name).image") }()
  lazy var purchase: UserAttribute<Purchase> = { UserAttribute<Purchase>("\(self.___name).purchase") }()

  
}
//
//  Purchase.swift
//  KidsApp
//
//  Created by Anna Goman on 29.08.15.
//  Copyright (c) 2015 Anna Goman. All rights reserved.
//

import Foundation
import CoreData
import AlecrimCoreData

class Purchase: NSManagedObject {
  
  @NSManaged var name: String
  @NSManaged var price: Int
  @NSManaged var type: Int
  @NSManaged var user: NSSet
  var userType: PersonType {
    get {
      return PersonType(rawValue: type)!
    }
    set {
      type = newValue.rawValue
    }
  }
}


extension Purchase {
  
  static let price = AlecrimCoreData.Attribute<Int>("price")
  static let type = AlecrimCoreData.Attribute<Int>("type")
  static let name = AlecrimCoreData.Attribute<String>("name")
  static let user = UserAttribute<User>("user")
  
}



class PurchaseAttribute<T>: AlecrimCoreData.SingleEntityAttribute<T> {
  
  override init(_ name: String) { super.init(name) }
  
  lazy var type: AlecrimCoreData.Attribute<Int> = { AlecrimCoreData.Attribute<Int>("\(self.___name).type") }()
  lazy var price: AlecrimCoreData.Attribute<Int> = { AlecrimCoreData.Attribute<Int>("\(self.___name).price") }()
  lazy var name: AlecrimCoreData.Attribute<String> = { AlecrimCoreData.Attribute<String>("\(self.___name).name") }()
  lazy var user: UserAttribute<User> = { UserAttribute<User>("\(self.___name).user") }()
  
}



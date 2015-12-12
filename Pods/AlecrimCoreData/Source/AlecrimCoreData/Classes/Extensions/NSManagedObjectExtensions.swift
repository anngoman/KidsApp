//
//  NSManagedObjectExtensions.swift
//  AlecrimCoreData
//
//  Created by Vanderlei Martinelli on 2014-06-24.
//  Copyright (c) 2014 Alecrim. All rights reserved.
//

import Foundation
import CoreData

extension NSManagedObject {
    
    public func inContext(context: Context) -> Self? {
        return self.inManagedObjectContext(context)
    }
    
    public func inManagedObjectContext(otherManagedObjectContext: NSManagedObjectContext) -> Self? {
        if self.managedObjectContext == otherManagedObjectContext {
            return self
        }
        
        if self.objectID.temporaryID {
            if let moc = self.managedObjectContext {
                var error: NSError? = nil
                let success: Bool
                do {
                    try moc.obtainPermanentIDsForObjects([self as NSManagedObject])
                    success = true
                } catch let error1 as NSError {
                    error = error1
                    success = false
                }
                if !success {
                    alecrimCoreDataHandleError(error)
                    return nil
                }
            }
            else {
                return nil
            }
        }
        
        var error: NSError? = nil
        let objectInContext: NSManagedObject?
        do {
            objectInContext = try otherManagedObjectContext.existingObjectWithID(self.objectID)
        } catch let error1 as NSError {
            error = error1
            objectInContext = nil
        }
        
        if error != nil {
            alecrimCoreDataHandleError(error)
        }
        
        return unsafeBitCast(objectInContext, self.dynamicType)
    }
    
}


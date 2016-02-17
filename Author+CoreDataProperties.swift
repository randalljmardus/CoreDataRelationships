//
//  Author+CoreDataProperties.swift
//  CoreDataRelationships
//
//  Created by Randall Mardus on 2/17/16.
//  Copyright © 2016 Randall Mardus. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Author {

    @NSManaged var name: String?
    @NSManaged var books: NSSet?

}

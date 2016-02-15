//
//  FetchedResultsDisplayer.swift
//  CoreDataRelationships
//
//  Created by Randall Mardus on 2/15/16.
//  Copyright © 2016 Randall Mardus. All rights reserved.
//

import Foundation
import UIKit
import CoreData

protocol FetchedResultsDisplayer {
    func configureCell(cell: UITableViewCell, object: NSManagedObject)
}
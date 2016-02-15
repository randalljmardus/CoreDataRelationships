//
//  FetchedResultsTableDataSource.swift
//  CoreDataRelationships
//
//  Created by Randall Mardus on 2/15/16.
//  Copyright © 2016 Randall Mardus. All rights reserved.
//

import UIKit
import CoreData

class FetchedResultsTableDataSource: NSObject, UITableViewDataSource {
    var displayer: FetchedResultsDisplayer
    var fetchedResultsController: NSFetchedResultsController?
    let cellIdentifier: String
    
    init (displayer: FetchedResultsDisplayer, fetchedResultsController: NSFetchedResultsController?, cellIdentifier: String) {
    self.displayer = displayer
    self.fetchedResultsController = fetchedResultsController
    self.cellIdentifier = cellIdentifier
    }

func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return fetchedResultsController?.sections?.count ?? 0
}
    func tableview(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let sections = fetchedResultsController?.sections else {return 0}
        
        let currentSection = sections[section]
        return currentSection.numberOfObjects
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath)
        if let object = fetchedResultsController?.objectAtIndexPath(indexPath) as? NSManagedObject {
            displayer.configureCell(cell, object: object)
        }
        return cell
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let sections = fetchedResultsController?.sections else {return nil}
        let currentSection = sections[section]
        
        return currentSection.name
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    
    
    
    
}

//
//  FetchedResultsControllerDelegate.swift
//  CoreDataRelationships
//
//  Created by Randall Mardus on 2/16/16.
//  Copyright © 2016 Randall Mardus. All rights reserved.
//

import UIKit
import CoreData

class FetchedResultsControllerDelegate: NSObject, NSFetchedResultsControllerDelegate {

    var displayer: FetchedResultsDisplayer
    var tableView: UITableView
    
    init(displayer: FetchedResultsDisplayer, tableView: UITableView) {
        self.displayer = displayer
        self.tableView = tableView
    }
    
    func controllerWillChangeContent(controller: NSFetchedResultsController) {
        tableView.beginUpdates()
    }
    
    func controller(controller: NSFetchedResultsController, didChangeSection sectionInfo: NSFetchedResultsSectionInfo, atIndex sectionIndex: Int, forChangeType type: NSFetchedResultsChangeType) {
        switch type {
        case .Insert:
            tableView.insertSections(NSIndexSet(index: sectionIndex),
            withRowAnimation: .Fade)
        case .Delete:
            tableView.deleteSections(NSIndexSet(index: sectionIndex), withRowAnimation: .Fade)
        default: break
        }
    }
    
    func controllerDidChangeContent(controller: NSFetchedResultsController, didChangeObject anObject: AnyObject, atIndexPath indexPath: NSIndexPath?, forChangeType type: NSFetchedResultsChangeType, newIndexPath: NSIndexPath?) {
        switch type {
        case .Insert:
            tableView.insertRowsAtIndexPaths([newIndexPath!], withRowAnimation: .Fade)
        
        case .Update:
            guard let
                indexPath = indexPath,
                object = controller.objectAtIndexPath(indexPath) as? NSManagedObject,
                cell = tableView.cellForRowAtIndexPath(indexPath) else {return}
            displayer.configureCell(cell, object: object)
            tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        case .Move:
            tableView.deleteRowsAtIndexPaths([indexPath!], withRowAnimation: .Fade)
            tableView.insertRowsAtIndexPaths([indexPath!]
                , withRowAnimation: .Fade)
        case .Delete:
            tableView.deleteRowsAtIndexPaths([indexPath!], withRowAnimation: .Fade)
        }
    }
    
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        tableView.endUpdates()
    }
}
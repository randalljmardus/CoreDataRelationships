//
//  ViewController.swift
//  CoreDataRelationships
//
//  Created by Randall Mardus on 2/15/16.
//  Copyright © 2016 Randall Mardus. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, FetchedResultsDisplayer {
    
    var tableView = UITableView()
    var fetchedResultsController: NSFetchedResultsController?
    var dataSource: FetchedResultsTableDataSource?
    var context: NSManagedObjectContext?
    var selectedIndexPath: NSIndexPath?
    var author: Author?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    
    edgesForExtendedLayout = UIRectEdge.None
    tableView.frame = view.frame
        
    tableView.delegate = self
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        view.addSubview(tableView)
    
        if let context = context {
            let request = NSFetchRequest(entityName: "Book")
            request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
            if author != nil {
                request.predicate = NSPredicate(format: "ANY authors = %@", author!)
    
            }
            
            
            fetchedResultsController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
            fetchedResultsController?.delegate = FetchedResultsControllerDelegate(displayer: self, tableView: tableView)
            dataSource = FetchedResultsTableDataSource(displayer: self, fetchedResultsController: fetchedResultsController, cellIdentifier: "Cell")
            tableView.dataSource = dataSource
            
            do {
                try fetchedResultsController?.performFetch()
            } catch {
                print("There was a problem fetching")
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func configureCell(cell: UITableViewCell, object: NSManagedObject) {
        guard let book = object as? Book else {return}
        cell.textLabel?.text = book.title
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        switch segue.identifier! {
            case "BookInfo":
                guard let vc = segue.destinationViewController as? BookDetailsViewController else {break}
                guard let indexPath = selectedIndexPath, book = fetchedResultsController?.objectAtIndexPath(indexPath) as? Book else {return}
            vc.book = book
        default:
            break
        }
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        selectedIndexPath = indexPath
        performSegueWithIdentifier("BookInfo", sender: nil)
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
}


//
//  BookDetailsViewController.swift
//  CoreDataRelationships
//
//  Created by Randall Mardus on 2/15/16.
//  Copyright © 2016 Randall Mardus. All rights reserved.
//

import UIKit
import CoreData

class BookDetailsViewController: UIViewController, FetchedResultsDisplayer {
    
    var book: Book!
    @IBOutlet weak var bookTitleLabel: UILabel!
    @IBOutlet weak var authorsTableView: UITableView!
    @IBOutlet weak var referencesTableView: UITableView!
    
    var fetchedResultsController: NSFetchedResultsController?
    var dataSource: FetchedResultsTableDataSource?
    var selectedIndexPath: NSIndexPath?
    
    var referenceFetchedResultsController: NSFetchedResultsController?
    var referenceDataSource: FetchedResultsTableDataSource?
    
    
    override func viewDidLoad() {
        // Do any additional setup after loading the view.
        super.viewDidLoad()
        bookTitleLabel.text = book.title
        authorsTableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "AuthorCell")
        authorsTableView.delegate = self
        
        referencesTableView.registerClass(UITableViewCell.self, forHeaderFooterViewReuseIdentifier: "ReferenceCell")
        
        if let context = book.managedObjectContext {
            createAuthorsTable(context)
            createReferencesTable(context)
            
            do {
                try fetchedResultsController?.performFetch()
                try referenceFetchedResultsController?.performFetch()
            } catch {
                print("There was a problem fetching.")
            }
        }
    }
    
    func createAuthorsTable(context: NSManagedObjectContext) {
        let request = NSFetchRequest(entityName: "author")
        request.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        request.predicate = NSPredicate(format: "ANY books = %@", book)
        fetchedResultsController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: context, sectionNameKeyPath: nil , cacheName: nil)
        fetchedResultsController?.delegate = FetchedResultsControllerDelegate(displayer: self, tableView: authorsTableView)
        dataSource = FetchedResultsTableDataSource(displayer: self, fetchedResultsController: fetchedResultsController, cellIdentifier: "AuthorCell")
        authorsTableView.dataSource = dataSource
        
    }
    
    func createReferencesTable(context: NSManagedObjectContext) {
        let request = NSFetchedRequest(entityName: "Book")
        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
        request.predicate = NSPredicate(format: "ANY referencedBy = %@", book)
        referenceFetchedResultsController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        referenceFetchedResultsController?.delegate = FetchedResultsControllerDelegate(displayer: self, tableView: referencesTableView)
        referenceDataSource = FetchedResultsTableDataSource(displayer: self, fetchedResultsController: referenceFetchedResultsController, cellIdentifier: "ReferenceCell")
        referencesTableView.dataSource = referenceDataSource
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    
        switch segue.identifier! {
        case "AuthorBooks" :
            guard let vc = segue.destinationViewController as? ViewController else {break}
            guard let indexPath = selectedIndexPath, author = fetchedResultsController?.objectAtIndexPath(indexPath) as? Author else {return}
            vc.author = author
            vc.context = author.managedObjectContext
        default:
            break
        }
    }
    
    func configureCell(cell: UITableViewCell, object: NSManagedObject) {
        
        switch object {
        case let author as Author:
            cell.textLabel?.text = author.name
        case let book as Book:
            cell.textLabel?.text = book.title
        default:
            break
        }
    }
}

extension BookDetailsViewController: UITableViewDelegate {
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        selectedIndexPath = indexPath
        performSegueWithIdentifier("AuthorBooks", sender: self)
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
}














//
//  BookDetailsViewController.swift
//  CoreDataRelationships
//
//  Created by Randall Mardus on 2/15/16.
//  Copyright © 2016 Randall Mardus. All rights reserved.
//

import UIKit

class BookDetailsViewController: UIViewController {
    
    var book: Book!
    @IBOutlet weak var bookTitleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bookTitleLabel.text = book.title

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Mariola Roznaska on 29/05/2019.
//  Copyright © 2019 Mariola Roznaska. All rights reserved.
//

import UIKit
import CoreData

class CategoryViewController: UITableViewController {

    var categoryArray = [Category]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

     //   categoryArray[0].name = "Pierwsza kategoria"
        
    }
    //MARK: - TableView Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        let item = categoryArray[indexPath.row]
        
        cell.textLabel?.text = item.name
        
        return cell
    }
    
    //MARK: - Data Manipulation Methods
    
    //MARK: - Add New Categories
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
    }
    
    //MARK: - TableView Delegate Methods
    
    
}

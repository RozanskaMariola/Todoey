//
//  ViewController.swift
//  Todoey
//
//  Created by Mariola Roznaska on 14/05/2019.
//  Copyright © 2019 Mariola Roznaska. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController{

    let itemArray = ["Find Mike","Buy Eggos","Destory Demogorgon"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
     //   listTableView.delegate = self
      //  listTableView.dataSource = self
        
    }

    //MARK - Tableview Datasource Methods
    //ile wierszy
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }

    //tworzy zawartosc komórki
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        cell.textLabel?.text = itemArray[indexPath.row]
        
        return cell
    }
    
    //MARK - TableView Delegate Methods
    //wykonuje sie po zaznaczeniu wiersza
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print(itemArray[indexPath.row])
        
        //po zaznaczeniu (kliknieciu)
        //tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }else{
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        
        //migniecie zaznaczonej komorki - zaznaczenie tylko w momencie kliku - nie swieci caly czas ze zaznaczona
        tableView.deselectRow(at: indexPath, animated: true)
        
        
    }
}


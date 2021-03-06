//
//  ViewController.swift
//  Todoey
//
//  Created by Mariola Roznaska on 14/05/2019.
//  Copyright © 2019 Mariola Roznaska. All rights reserved.
//

import UIKit
import CoreData

class TodoListViewController: UITableViewController {
    
    var itemArray = [Item]()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        
        loadItems()
        
    }
    
//MARK - Tableview Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        let item = itemArray[indexPath.row]
        
        cell.textLabel?.text = item.title
        
        //Ternary operator ==>
        // value = condition ? valueIfTrue : valueIfFalse
        
        cell.accessoryType = item.done ? .checkmark : .none
        
        return cell
    }
    
//MARK - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        

        //usuwa dane z bazy
        //    context.delete(itemArray[indexPath.row])
        //usuwa biezacy element z tablicy itemArray
        //    itemArray.remove(at: indexPath.row)
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        saveItems()
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
//MARK - Add New Items
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            //what will happen once the user clicks the Add Item button on our UIAlert
            
            let newItem = Item(context: self.context)
            newItem.title = textField.text!
            newItem.done = false
            self.itemArray.append(newItem)
            
            self.saveItems()
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
            
        }
        
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
        
    }
    
//MARK - Model Manupulation Methods
    
    func saveItems() {
        
        do {
            try context.save()
        } catch {
            print("Error encoding item array, \(error)")
        }
        
        self.tableView.reloadData()
    }
    
    
    //ustawia defaultowa wartosc jesli zadna nie jest dodana
    func loadItems(with request: NSFetchRequest<Item> = Item.fetchRequest()) {
        //let request : NSFetchRequest<Item> = Item.fetchRequest()
        do {
                itemArray = try context.fetch(request)
            } catch {
                print("Error decoding item array, \(error)")
            }
        
        tableView.reloadData()
        
        }
    
    
    
    
}
//MARK: - Search bar methods
extension TodoListViewController: UISearchBarDelegate{
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        //polaczenie do bazy
        let request : NSFetchRequest<Item> = Item.fetchRequest()
        
        //zapytanie do bazy contains - zawiera [cd] - nie bierz pod uwage, malych i duzych znakow
        request.predicate = NSPredicate(format: "title CONTAINS[cd] %@",searchBar.text!)
       
        
        //sortowanie
        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
        
        //print(searchBar.text!)
        
        //zwrocenie danych z bazy
        loadItems(with: request)
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        //jesli tekst ktory jest wiekszy od 0, zaladuj dane
       if searchBar.text?.count == 0{
            loadItems()
        
        DispatchQueue.main.async {
            searchBar.resignFirstResponder()
        }
        
        }
    }
    
}

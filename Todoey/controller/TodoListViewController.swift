//
//  ViewController.swift
//  Todoey
//
//  Created by Jae Moon Lee on 30/06/2019.
//  Copyright © 2019 Jae Moon Lee. All rights reserved.
//

import UIKit
import RealmSwift

class TodoListViewController: UITableViewController {

    let realm = try! Realm()
    
    @IBOutlet var searchBar: UISearchBar!
    var todoItems: Results<Item>?
    var selectedCategory: Category?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
        
        loadItems()
    }

    // mark - tableview datasource
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return todoItems?.count ?? 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell")!
        
        if let item = todoItems?[indexPath.row] {
            cell.textLabel?.text = item.title
            cell.accessoryType = item.done ? .checkmark : .none
        }else{
            cell.textLabel?.text = "Empty List"
        }
        
        return cell
    }
    
    // mark - tableview delegate mothods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let item = todoItems?[indexPath.row]{
            do{
                try realm.write{
                    //realm.delete(item)
                    item.done = !item.done
                }
            }catch{
                print("error in update: \(error)")
            }
        }
        tableView.reloadData()

    }
    
    // mark - add new item
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField: UITextField!
        
        let alert = UIAlertController(title: "Add Todo Item", message: "", preferredStyle: .alert)
        
        alert.addTextField { (alertTextField) in
            
            alertTextField.placeholder = "enter new todoey"
            
            textField = alertTextField
        }
        
        let action = UIAlertAction(title: "Add item", style: .default) { (action) in
            
            if let currentCategory = self.selectedCategory{
                
                do{
                    try self.realm.write{
                        let item = Item()
                        item.title = textField.text!
                        currentCategory.items.append(item)
                    }
                }catch{
                    print("Error in saveCategory: \(error)")
                }
            }
            self.tableView.reloadData()
            
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }

    func loadItems(){
        
        todoItems = selectedCategory?.items.sorted(byKeyPath: "title", ascending: true)
        tableView.reloadData()
    }
}

extension TodoListViewController: UISearchBarDelegate{

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {

        todoItems = todoItems?.filter("title CONTAINS[cd] %@", searchBar.text!)
        todoItems = todoItems?.sorted(byKeyPath: "title", ascending: true)
        tableView.reloadData()
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text!.count == 0{
            loadItems()
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }

        }
    }
}


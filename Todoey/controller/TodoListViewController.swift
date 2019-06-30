//
//  ViewController.swift
//  Todoey
//
//  Created by Jae Moon Lee on 30/06/2019.
//  Copyright © 2019 Jae Moon Lee. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {

    var itemArray: [Item] = []
    var defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        itemArray.append(Item(title: "find baby"))
        itemArray.append(Item(title: "buy avocado"))
        itemArray.append(Item(title: "bbbbbb"))
        
        if let items = defaults.array(forKey: "TodoListArray") as? [Item]{
            itemArray = items
        }
    }

    // mark - tableview datasource
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return itemArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell") as! UITableViewCell
        
        let item = itemArray[indexPath.row]
        
        cell.textLabel?.text = item.title
        cell.accessoryType = item.done ? .checkmark : .none
        
        return cell
    }
    
    // mark - tableview delegate mothods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        tableView.deselectRow(at: indexPath, animated: true)
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
            
            self.itemArray.append(Item(title: textField.text!))
            
            self.defaults.setValue(self.itemArray, forKey: "TodoListArray")
            
            self.tableView.reloadData()
            
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
}


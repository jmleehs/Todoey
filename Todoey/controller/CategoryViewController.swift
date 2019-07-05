//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Jae Moon Lee on 02/07/2019.
//  Copyright © 2019 Jae Moon Lee. All rights reserved.
//

import UIKit
import RealmSwift

class CategoryViewController: UITableViewController {

    let realm = try! Realm()
    
    var categoryArray: Results<Category>?
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadCategory()

    }
    
    // MARK: - data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryArray?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath) 
        
        cell.textLabel?.text = categoryArray?[indexPath.row].name ?? "empty category"
        return cell
    }
    
    // MARK: - delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let todoListViewController = segue.destination as! TodoListViewController
        
        if let selectedRow = tableView.indexPathForSelectedRow {
            todoListViewController.selectedCategory = categoryArray?[selectedRow.row]
        }
    }
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField: UITextField!
        
        let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "input new category"
            textField = alertTextField
        }
        
        let action = UIAlertAction(title: "Add Category", style: .default) { (action) in
            
            let category = Category()
            category.name = textField.text!
            self.save(category: category)
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    func save(category: Category){
        do{
            try realm.write{
                realm.add(category)
            }
        }catch{
            print("Error in saveCategory: \(error)")
        }
        tableView.reloadData()
    }
    
    func loadCategory(){
        categoryArray = realm.objects(Category.self)
        tableView.reloadData()
    }
    
}

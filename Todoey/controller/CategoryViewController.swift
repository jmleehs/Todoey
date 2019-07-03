//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Jae Moon Lee on 02/07/2019.
//  Copyright © 2019 Jae Moon Lee. All rights reserved.
//

import UIKit
import CoreData

class CategoryViewController: UITableViewController {

    var categoryArray = [Category]()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadCategory()

    }
    
    // MARK: - data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath) 
        
        cell.textLabel?.text = categoryArray[indexPath.row].name
        return cell
    }
    
    // MARK: - delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let todoListViewController = segue.destination as! TodoListViewController
        
        if let selectedRow = tableView.indexPathForSelectedRow {
            todoListViewController.selectedCategory = categoryArray[selectedRow.row]
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
            
            let category = Category(context: self.context)
            category.name = textField.text
            
            self.categoryArray.append(category)
            
            self.saveCategory()
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    func saveCategory(){
        do{
            try context.save()
        }catch{
            print("Error in saveCategory: \(error)")
        }
        tableView.reloadData()
    }
    
    func loadCategory(request: NSFetchRequest<Category> = Category.fetchRequest()){
        do{
            categoryArray = try context.fetch(request)
        }catch{
            print("Error in loadCategory: \(error)")
        }
        
        tableView.reloadData()
    }
    
}

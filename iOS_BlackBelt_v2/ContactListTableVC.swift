//
//  ContactListTableVC.swift
//  iOS_BlackBelt_v2
//
//  Created by Robert on 7/26/17.
//  Copyright © 2017 Robert Villarreal. All rights reserved.
//

import UIKit
import CoreData

class ContactListTableVC: UITableViewController {

    var ContactList = [ContactItem]()
    
    let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    
    
    @IBAction func AddContactPressed(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "ContactSegue", sender: self)
    }
    
    
    
    func saveContact(by controller: ContactActionVC, f_name first_name: String, l_name last_name: String, ph phone: String, at indexPath: NSIndexPath?) {
        
        
        if first_name == "" || last_name == "" || phone == "" {
            print("Please Provide All Input Fields")
        }
        else {
            if let ip = indexPath {
                let item = ContactList[ip.row]
                item.first_name = first_name
                item.last_name = last_name
                item.phone = phone
            }
            else {
                let item = NSEntityDescription.insertNewObject(forEntityName: "ContactItem", into: managedObjectContext) as! ContactItem
                item.first_name = first_name
                item.last_name = last_name
                item.phone = phone
                ContactList.append(item)
            }
            do {
                try managedObjectContext.save()
            } catch {
                print(error)
            }
            dismiss(animated: true, completion: nil)
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        if segue.identifier == "ViewSegue" {
            let navController = segue.destination as! UINavigationController
            let ViewVC = navController.topViewController as! ViewContactVC
            ViewVC.Delegate = self
            
            let indexPath = sender as! NSIndexPath
            let item = ContactList[indexPath.row]
            ViewVC.title = item.first_name
            ViewVC.indexPath = indexPath
            
            ViewVC.first_name = item.first_name
            ViewVC.last_name = item.last_name
            ViewVC.phone_number = item.phone
            
        }
        else {
            let navController = segue.destination as! UINavigationController
            let ContactVC = navController.topViewController as! ContactActionVC
            ContactVC.Delegate = self
            
            if sender is NSIndexPath {
                let indexPath = sender as! NSIndexPath
                let item = ContactList[indexPath.row]
                ContactVC.title = "Edit Contact"
                ContactVC.indexPath = indexPath
                
                
                ContactVC.first_name = item.first_name
                ContactVC.last_name = item.last_name
                ContactVC.phone_number = item.phone
                
            } else {
                ContactVC.title = "Add Contact"
            }
        }
    }
    
    
    
    
    func fetchAllItems() {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "ContactItem")
        do {
            let result = try managedObjectContext.fetch(request)
            ContactList = result as! [ContactItem]
        } catch {
            print("\(error)")
        }
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.fetchAllItems()
    }
    
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ContactList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ContactCell", for: indexPath)
        
        let first = ContactList[indexPath.row].first_name!
        let last = ContactList[indexPath.row].last_name!
        
        cell.textLabel?.text = "\(first) \(last)"
        cell.detailTextLabel?.text = ContactList[indexPath.row].phone!
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        let alertController = UIAlertController(title: "Select Option", message: "Please Select Option?", preferredStyle: .actionSheet)
        
        
        let viewButton = UIAlertAction(title: "View", style: .default, handler: { (action) -> Void in
            self.performSegue(withIdentifier: "ViewSegue", sender: indexPath)
        })
        
        let editButton = UIAlertAction(title: "Edit", style: .default, handler: { (action) -> Void in
            self.performSegue(withIdentifier: "ContactSegue", sender: indexPath)
        })
        
        let  deleteButton = UIAlertAction(title: "Delete", style: .destructive, handler: { (action) -> Void in
            print("Delete button tapped")
            let item = self.ContactList[indexPath.row]
            self.managedObjectContext.delete(item)
            do {
                try self.managedObjectContext.save()
            } catch {
                print("\(error)")
            }
            self.ContactList.remove(at: indexPath.row)
            tableView.reloadData()
        })
        
        let cancelButton = UIAlertAction(title: "Cancel", style: .cancel, handler: { (action) -> Void in
            print("Cancel button tapped")
        })
        
        alertController.addAction(viewButton)
        alertController.addAction(editButton)
        alertController.addAction(deleteButton)
        alertController.addAction(cancelButton)
        
        self.navigationController!.present(alertController, animated: true, completion: nil)
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


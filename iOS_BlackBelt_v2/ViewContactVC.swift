//
//  ViewContactVC.swift
//  iOS_BlackBelt_v2
//
//  Created by Robert on 7/26/17.
//  Copyright © 2017 Robert Villarreal. All rights reserved.
//

import UIKit
import CoreData

class ViewContactVC: UIViewController {
    
    var Delegate: ContactListTableVC?
    
    var indexPath: NSIndexPath?
    var first_name: String?
    var last_name: String?
    var phone_number: String?
    
    
    
    @IBAction func DoneButtonPressed(_ sender: UIBarButtonItem) {
     
        dismiss(animated: true, completion: nil)
        
    }
    
    @IBOutlet weak var FullName: UILabel!
    
    @IBOutlet weak var PhoneNumber: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let f_name = first_name {
            self.navigationController?.title = f_name
            if let l_name = last_name {
                self.FullName.text = "\(f_name) \(l_name)"
            }
        }
        if let ph = phone_number {
            self.PhoneNumber.text = ph
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
}

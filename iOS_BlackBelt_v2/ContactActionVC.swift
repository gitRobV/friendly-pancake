//
//  ContactActionVC.swift
//  iOS_BlackBelt_v2
//
//  Created by Robert on 7/26/17.
//  Copyright © 2017 Robert Villarreal. All rights reserved.
//

import UIKit
import CoreData

class ContactActionVC: UIViewController {

    var Delegate: ContactListTableVC?
    
    var indexPath: NSIndexPath?
    var first_name: String?
    var last_name: String?
    var phone_number: String?


    
    
    
    @IBAction func SaveButtonPressed(_ sender: UIBarButtonItem) {
        let first_name = F_Name.text
        let last_name = L_Name.text
        let phone = Phone.text
        
        Delegate?.saveContact(by: self, f_name: first_name!, l_name: last_name!, ph: phone!, at: indexPath)
        print(phone!)
    }
    
    @IBAction func CancelButtonPressed(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet weak var F_Name: UITextField!
    
    @IBOutlet weak var L_Name: UITextField!
    
    @IBOutlet weak var Phone: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let f_name = first_name {
            self.F_Name.text = f_name
        }
        if let l_name = last_name {
            self.L_Name.text = l_name
        }
        if let ph = phone_number {
            self.Phone.text = ph
        }
        
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

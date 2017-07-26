//
//  ContactCell.swift
//  iOS_BlackBelt_v2
//
//  Created by Robert on 7/26/17.
//  Copyright © 2017 Robert Villarreal. All rights reserved.
//

import Foundation
import UIKit

class ContactCell: UITableViewCell {
    
    var Delegate: ContactListTableVC?
    
    @IBOutlet weak var Name: UILabel!
    @IBOutlet weak var Phone: UILabel!
}

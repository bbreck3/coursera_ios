//
//  ViewContact.swift
//  CoreDataTest2
//
//  Created by Rob on 5/27/19.
//  Copyright © 2019 Rob. All rights reserved.
//

import Foundation
import UIKit
import CoreData
class ViewContact: UIViewController{
    
    //Variables to be passed
    var passedValueName: String = ""
    var passedValueNumber: String = ""
    var passedValueEmail: String = ""
    //Name Eamil and Number of each contact
    @IBOutlet weak var txtName: UITextView!
    @IBOutlet weak var txtNumber: UITextView!
    @IBOutlet weak var txtEmail: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //Display the conact info
        txtName?.text = passedValueName
        txtNumber?.text = passedValueNumber
        txtEmail?.text = passedValueEmail

        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
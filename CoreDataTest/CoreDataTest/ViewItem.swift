//
//  ViewItem.swift
//  CoreDataTest
//
//  Created by Rob on 5/24/19.
//  Copyright © 2019 Rob. All rights reserved.
//

import UIKit

class ViewItem: UIViewController {
    
    
   
    
    @IBOutlet weak var txtName: UITextView!
    @IBOutlet weak var txtNumber: UITextView!
    @IBOutlet weak var txtEmail: UITextView!
    var passedValueName: String = ""
    var passedValueNumber: String = ""
    var passedValueEmail: String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        txtName.text = passedValueName
        txtNumber.text = passedValueNumber
        txtEmail.text = passedValueEmail
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

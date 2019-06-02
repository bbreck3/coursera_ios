//
//  AddItem.swift
//  List5
//
//  Created by Rob on 5/11/19.
//  Copyright © 2019 Rob. All rights reserved.
//

import Foundation
import UIKit


class AddItem: UIViewController{
    

    @IBOutlet weak var tvData: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func btnInsertData(sender: AnyObject) {
        print(tvData.text)
    }
    
}

//
//  AddItem.swift
//  CoreDataTest
//
//  Created by Rob on 5/24/19.
//  Copyright © 2019 Rob. All rights reserved.
//

import Foundation
import UIKit
import CoreData
class AddItem: UIViewController{
    
    var data: [NSManagedObject]=[]
    
    @IBOutlet weak var lblName: UITextField!
    @IBOutlet weak var lblNumber: UITextField!
    @IBOutlet weak var lblEmail: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
                
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func btnAddItem(sender: AnyObject) {
        //let temp = lblAddItem.text
        self.save(lblName.text!, number: lblNumber.text!, email: lblEmail.text!)
    }
    
    
    @IBAction func btnDel(sender: AnyObject) {
        self.delete()
    }
    func delete(){
        //1
        guard let appDelegate =
            UIApplication.sharedApplication().delegate as? AppDelegate else {
                return
        }
        
        let managedContext =
            appDelegate.managedObjectContext
        //2
        let fetchRequest =
            NSFetchRequest(entityName: "Task")
        
        //3
        do {
            data = try managedContext.executeFetchRequest(fetchRequest) as! [NSManagedObject]
            for item in data{
                let managedObjectData:NSManagedObject = item
                managedContext.deleteObject(managedObjectData)
            }
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }

    }
    func save(name: String, number: String, email: String) {
        
        guard let appDelegate =
            UIApplication.sharedApplication().delegate as? AppDelegate else {
                return
        }
        
        // 1
        let managedContext =
            appDelegate.managedObjectContext
        
        // 2
        let entity =
            NSEntityDescription.entityForName("Task",
                                              inManagedObjectContext: managedContext)!
        
        let task = NSManagedObject(entity: entity,
                                   insertIntoManagedObjectContext: managedContext)
        
        // 3
        task.setValue(name, forKeyPath: "name")
        task.setValue(number, forKey: "number")
        task.setValue(email, forKey: "email")
        
        // 4
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
}

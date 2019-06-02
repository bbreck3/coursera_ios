//
//  AddContact.swift
//  CoreDataTest2
//
//  Created by Rob on 5/27/19.
//  Copyright © 2019 Rob. All rights reserved.
//

import Foundation
import UIKit
import CoreData
class AddContact: UIViewController{
    
    //Varibales: Name Number and Email of each contact
    @IBOutlet weak var txtName: UITextField!
    
    @IBOutlet weak var txtNumber: UITextField!
    
    @IBOutlet weak var txtEmail: UITextField!
    
    //array to store each contact
    var data: [NSManagedObject]=[]
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func btnAddContact(sender: AnyObject) {
        self.save(txtName.text!, number: txtNumber.text!, email: txtEmail.text!)
        
    }
    @IBAction func btnDeleteContact(sender: AnyObject) {
        self.delete()
    }
    
    func delete(){
        guard let appDelegate =
            UIApplication.sharedApplication().delegate as? AppDelegate else {
                return
        }
        
        let managedContext =
            appDelegate.managedObjectContext
        
        let fetchRequest =
            NSFetchRequest(entityName: "Contact")
        
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
    //save the contact information
    func save(name: String, number: String, email: String) {
        
        guard let appDelegate =
            UIApplication.sharedApplication().delegate as? AppDelegate else {
                return
        }
        
        let managedContext =
            appDelegate.managedObjectContext
        
        
        let entity =
            NSEntityDescription.entityForName("Contact",
                                              inManagedObjectContext: managedContext)!
        
        let task = NSManagedObject(entity: entity,
                                   insertIntoManagedObjectContext: managedContext)
        
        //save data for each contact
        task.setValue(name, forKeyPath: "name")
        task.setValue(number, forKey: "number")
        task.setValue(email, forKey: "email")
        
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
}

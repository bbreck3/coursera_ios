//
//  ViewController.swift
//  CoreDataTest2
//
//  Created by Rob on 5/27/19.
//  Copyright © 2019 Rob. All rights reserved.
//

import UIKit
import CoreData
/*
    Main EntryPoint
    Contains A Table of Contacts that can be clicked to view each individual contact
 */
class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    //Variabes: Name Number and Email of each variable to pass
    var valueToPassName: String = ""
    var valueToPassNumber: String = ""
    var valueToPassEmail: String = ""
    //array ot store the data per contact
    var data: [NSManagedObject] = []

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableView.delegate = self
        tableView.dataSource = self

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //Setup the CoreData structure in order to begin querry; Display in table only name of the Contact
        let task = data[indexPath.row]
        let cell =
            tableView.dequeueReusableCellWithIdentifier("contact",
                                                        forIndexPath: indexPath)
        cell.textLabel?.text =
            task.valueForKey("name") as? String
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        let row = indexPath.row
        valueToPassName = data[row].valueForKey("name") as! String
        valueToPassNumber = data[row].valueForKey("number") as! String
        valueToPassEmail = data[row].valueForKey("email") as! String
        
        //Setup the pointer to the next viewController in order to pass data to it
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewControllerWithIdentifier("ViewContact") as! ViewContact
        //set the new viewController data
        vc.passedValueName = valueToPassName
        vc.passedValueEmail = valueToPassEmail
        vc.passedValueNumber = valueToPassNumber
        
        //present the new view controller
        self.presentViewController(vc, animated: true, completion: nil)
        //performSegueWithIdentifier("ShowItem", sender: self)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        guard let appDelegate =
            UIApplication.sharedApplication().delegate as? AppDelegate else {
                return
        }
        
        let managedContext =
            appDelegate.managedObjectContext
        let fetchRequest =
            NSFetchRequest(entityName: "Contact")
        
        //querry the data from CoreData
        do {
            data = try managedContext.executeFetchRequest(fetchRequest) as! [NSManagedObject]
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        self.tableView.reloadData()
    }
    
//        override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?){
//    
//            //if (segue.identifier == "ShowItem") {
//                // initialize new view controller and cast it as your view controller
//                let viewController = segue.destinationViewController as! ViewContact //{
//                // your new view controller should have property that will store passed value
//                    viewController.passedValueName = valueToPassName
//                    viewController.passedValueNumber = valueToPassNumber
//                    viewController.passedValueEmail = valueToPassEmail
//                //}
//            //}
//        }

}


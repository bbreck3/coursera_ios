//
//  ViewController.swift
//  CoreDataTest
//
//  Created by Rob on 5/23/19.
//  Copyright © 2019 Rob. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController,UITableViewDataSource, UITableViewDelegate {

    var valueToPassName: String = ""
    var valueToPassNumber: String = ""
    var valueToPassEmail: String = ""
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
       // let cell = tableView.dequeueReusableCellWithIdentifier("item", forIndexPath: indexPath)
        
        let row = indexPath.row
        let task = data[indexPath.row]
        let cell =
            tableView.dequeueReusableCellWithIdentifier("item",
                                          forIndexPath: indexPath)
        cell.textLabel?.text =
            task.valueForKey("name") as? String
        return cell
    }
    
    // MARK:  UITableViewDelegate Methods
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        let row = indexPath.row
        //print(data[row].valueForKey("data"))//swiftBlogs[row])
        valueToPassName = data[row].valueForKey("name") as! String
        valueToPassNumber = data[row].valueForKey("number") as! String
        valueToPassEmail = data[row].valueForKey("email") as! String
        let vc = ViewItem(nibName: "ViewItem.swift", bundle: nil)
        vc.passedValueName = "Next level blog photo booth, tousled authentic tote bag kogi"
    
        //viewController.passedValueName = valueToPassName
        vc.passedValueNumber = valueToPassNumber
        vc.passedValueEmail = valueToPassEmail
        navigationController!.pushViewController(vc, animated: true)

        //performSegueWithIdentifier("showHome", sender: self)
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
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
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        self.tableView.reloadData()
    }
    
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?){
//        
//        if (segue.identifier == "showHome") {
//            // initialize new view controller and cast it as your view controller
//            let viewController = segue.destinationViewController as! ViewItem //{
//            // your new view controller should have property that will store passed value
//                viewController.passedValueName = valueToPassName
//                viewController.passedValueNumber = valueToPassNumber
//                viewController.passedValueEmail = valueToPassEmail
//            //}
//        }
//    }



}

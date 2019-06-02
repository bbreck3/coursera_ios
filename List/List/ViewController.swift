//
//  ViewController.swift
//  List
//
//  Created by Rob on 5/8/19.
//  Copyright © 2019 Rob. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate
{

    
    @IBOutlet weak var tableView: UITableView!
    
    let textCellIdentifier = "item"
    var data: [String] = []
    var count = 0
    
    let swiftBlogs = ["Ray Wenderlich", "NSHipster", "iOS Developer Tips", "Jameson Quave", "Natasha The Robot", "Coding Explorer", "That Thing In Swift", "Andrew Bancroft", "iAchieved.it", "Airspeed Velocity"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        for i in 0...1000 {
//            data.append("\(i)")
//        }
        tableView.delegate=self
        tableView.dataSource=self
        }
    
    // MARK:  UITextFieldDelegate Methods
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(textCellIdentifier, forIndexPath: indexPath)
        
        let row = indexPath.row
        cell.textLabel?.text = data[row] //swiftBlogs[row]
        
        return cell
    }
    
    // MARK:  UITableViewDelegate Methods
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        let row = indexPath.row
        print(data[row])//swiftBlogs[row])
    }
    
    @IBAction func btnAdd(sender: AnyObject) {
        data.append("\(count)")
        count+=1
        tableView.reloadData()
    }
    
    
}


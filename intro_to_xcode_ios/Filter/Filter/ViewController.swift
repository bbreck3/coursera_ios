//
//  ViewController.swift
//  Filter
//
//  Created by Rob on 2/2/19.
//  Copyright © 2019 Rob. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{

    var filterImage: UIImage?
    @IBOutlet var imageView: UIImageView!
    
    @IBOutlet var secondaryMenu: UIView!
    @IBOutlet var bottumMenu: UIView!
    
    @IBOutlet var filterButton: UIButton!
            override func viewDidLoad() {
        super.viewDidLoad()
        secondaryMenu.translatesAutoresizingMaskIntoConstraints = false
        secondaryMenu.backgroundColor=UIColor.whiteColor().colorWithAlphaComponent(0.5)
                
                
                
        // Do any additional setup after loading the view, typically from a nib.
        //imageToggle.setTitle("Show Befroe Image", forState: .Selected)
        let image = UIImage(named: "sample")!
        
        // Process the image!
        var myRGBA = RGBAImage(image: image)!
        
        //let y = 10
        //let x = 10
        
        //let index = y * myRGBA.width + x
        //var pixel = myRGBA.pixels[index]

        let avgRed = 110
        //var avgGren = 98
        //var avgBlue = 83
        
        for y in 0..<myRGBA.height{
            for x in 0..<myRGBA.width{
                let index = y * myRGBA.width + x
                var pixel = myRGBA.pixels[index]
                let redDiff = Int(pixel.red)-avgRed
                if(redDiff>0){
                    pixel.red = UInt8(max(0,min(255,avgRed+redDiff*5)))
                    myRGBA.pixels[index]=pixel
                }
            }
        }
        
        print("Testing the app")
        filterImage = myRGBA.toUIImage()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func onShare(sender: AnyObject) {
        let activityController = UIActivityViewController(activityItems: [imageView.image!],applicationActivities: nil)
        presentViewController(activityController, animated: true, completion: nil)
    }
    @IBAction func onFilter(sender: UIButton) {
        if(sender.selected){
            hideSecondaryMenu()
            sender.selected=false
        }else{
            showSecondaryMenu()
            sender.selected = true
        }
    }
    
    @IBAction func onNewPhoto(sender: AnyObject) {
        let actionSheet = UIAlertController(title: "New Photo", message: nil,
                                            preferredStyle: .ActionSheet);
        actionSheet.addAction(UIAlertAction(title:"Camera", style: .Default,handler: {action in
            self.showCamera()
        }))
        actionSheet.addAction(UIAlertAction(title:"Album", style: .Default,handler: {action in
            self.showAlbum()
        }))
        actionSheet.addAction(UIAlertAction(title:"Cancel", style: .Cancel,handler: {action in
            
        }))
        
        self.presentViewController(actionSheet, animated: true, completion:nil)
        
    }
    
    func showCamera(){
        let cameraPicker = UIImagePickerController()
        cameraPicker.delegate = self
        cameraPicker.sourceType = .Camera
        presentViewController(cameraPicker, animated: true, completion:nil)
        
    }
    
    func showAlbum(){
        let cameraPicker = UIImagePickerController()
        cameraPicker.delegate = self
        cameraPicker.sourceType = .PhotoLibrary
        presentViewController(cameraPicker, animated: true, completion:nil)
    }
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        dismissViewControllerAnimated(true, completion: nil)
        if let image  = info[UIImagePickerControllerOriginalImage] as? UIImage{
                imageView.image = image
        }
    }
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    
    func showSecondaryMenu(){
        
        view.addSubview(secondaryMenu)
        
        let bottomConstraint = secondaryMenu.bottomAnchor.constraintEqualToAnchor(bottumMenu.topAnchor)
        let leftConstraint = secondaryMenu.leftAnchor.constraintEqualToAnchor(view.leftAnchor)
        let rightConstraint = secondaryMenu.rightAnchor.constraintEqualToAnchor(view.rightAnchor)
        let hightConstrait = secondaryMenu.heightAnchor.constraintEqualToConstant(44)
        
        NSLayoutConstraint.activateConstraints([bottomConstraint,leftConstraint,rightConstraint,hightConstrait])
        
        view.layoutIfNeeded()
        self.secondaryMenu.alpha = 0
        UIView.animateWithDuration(0.5){
            self.secondaryMenu.alpha=1.0
        }
    }
    func hideSecondaryMenu(){
        UIView.animateWithDuration(0.5,animations:{
            
        }) { completed in
            if completed == true{
            self.secondaryMenu.removeFromSuperview()
            }
        }
    }
    
    @IBAction func Red(sender: UIButton) {
        print("Red")
    }
    
    @IBAction func Green(sender: UIButton) {
        print("Green")
    }
    
    @IBAction func Blue(sender: UIButton) {
        print("Blue")
    }
    @IBAction func Yellow(sender: UIButton) {
        print("Yellow")
    }
    @IBAction func Purple(sender: UIButton) {
        print("Purple")

    }
    


}


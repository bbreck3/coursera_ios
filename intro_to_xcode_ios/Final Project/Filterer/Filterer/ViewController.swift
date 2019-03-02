//
//  ViewController.swift
//  Filterer
//
//  Created by Jack on 2015-09-22.
//  Copyright © 2015 UofT. All rights reserved.
//

import UIKit


class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    
    @IBOutlet var imageView: UIImageView!
    
    
    @IBOutlet var secondaryMenu: UIView!
    @IBOutlet var bottomMenu: UIView!
    
    @IBOutlet weak var compareImage: UIButton!
    
    
    
    @IBOutlet var filterButton: UIButton!
    var originalImage = UIImage(named:"scenery")
    var filteredImage: UIImage?
    override func viewDidLoad() {
        super.viewDidLoad()
        secondaryMenu.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.5)
        secondaryMenu.translatesAutoresizingMaskIntoConstraints = false
        
        compareImage.enabled = false;
    
    }

    // MARK: Share
    @IBAction func onShare(sender: AnyObject) {
        let activityController = UIActivityViewController(activityItems: ["Check out our really cool app", imageView.image!], applicationActivities: nil)
        presentViewController(activityController, animated: true, completion: nil)
    }
    
    // MARK: New Photo
    @IBAction func onNewPhoto(sender: AnyObject) {
        let actionSheet = UIAlertController(title: "New Photo", message: nil, preferredStyle: .ActionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .Default, handler: { action in
            self.showCamera()
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Album", style: .Default, handler: { action in
            self.showAlbum()
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: nil))
        
        self.presentViewController(actionSheet, animated: true, completion: nil)
    }
    
    func showCamera() {
        let cameraPicker = UIImagePickerController()
        cameraPicker.delegate = self
        cameraPicker.sourceType = .Camera
        
        presentViewController(cameraPicker, animated: true, completion: nil)
    }
    
    func showAlbum() {
        let cameraPicker = UIImagePickerController()
        cameraPicker.delegate = self
        cameraPicker.sourceType = .PhotoLibrary
        
        presentViewController(cameraPicker, animated: true, completion: nil)
    }
    
    // MARK: UIImagePickerControllerDelegate
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        dismissViewControllerAnimated(true, completion: nil)
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            originalImage=image
            imageView.image = image
        }
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    // MARK: Filter Menu
    @IBAction func onFilter(sender: UIButton) {
        if (sender.selected) {
            compareImage.enabled = false;
            hideSecondaryMenu()
            sender.selected = false
        } else {
            showSecondaryMenu()
            sender.selected = true
            compareImage.enabled = true;
        }
    }
    
    func showSecondaryMenu() {
        view.addSubview(secondaryMenu)
        
        let bottomConstraint = secondaryMenu.bottomAnchor.constraintEqualToAnchor(bottomMenu.topAnchor)
        let leftConstraint = secondaryMenu.leftAnchor.constraintEqualToAnchor(view.leftAnchor)
        let rightConstraint = secondaryMenu.rightAnchor.constraintEqualToAnchor(view.rightAnchor)
        
        let heightConstraint = secondaryMenu.heightAnchor.constraintEqualToConstant(44)
        
        NSLayoutConstraint.activateConstraints([bottomConstraint, leftConstraint, rightConstraint, heightConstraint])
        
        view.layoutIfNeeded()
        
        self.secondaryMenu.alpha = 0
        UIView.animateWithDuration(0.4) {
            self.secondaryMenu.alpha = 1.0
        }
    }

    func hideSecondaryMenu() {
        UIView.animateWithDuration(0.4, animations: {
            self.secondaryMenu.alpha = 0
            }) { completed in
                if completed == true {
                    self.secondaryMenu.removeFromSuperview()
                }
        }
    }
    
    
   
    @IBAction func compareImage(sender: UIButton) {
        if (sender.selected) {
                //hideSecondaryMenu()
                imageView.image=filteredImage
                sender.selected = false
            } else {
                //showSecondaryMenu()
                imageView.image=originalImage
                sender.selected = true
            }

    }
    @IBAction func greysacle(sender: UIButton) {
        let image = originalImage!
        if image.size.width == 0{
            let alert = UIAlertController(title: "Error", message: "Please select an Image", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }else{
            let ip = ImageProcessor()
            ip.processImage(image)
            let f = filterOptions()
            let imageRGBA = ip.filterImage(image, filterOption: f.f4) //<-- Change the option here
            imageView.image = imageRGBA.toUIImage()
            filteredImage = imageRGBA.toUIImage()
            print("Greyscale")
        }
    }
    @IBAction func fiftyPercent(sender: UIButton) {
        let image  = originalImage!
        if image.size.width == 0{
            let alert = UIAlertController(title: "Error", message: "Please Select and Image", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }else{
            let ip = ImageProcessor()
            ip.processImage(image)
            let f = filterOptions()
            let imageRGBA = ip.filterImage(image, filterOption: f.f2) //<-- Change the option here
            imageView.image = imageRGBA.toUIImage()
            print("50%")
        }
    }
    @IBAction func twentyFivePercent(sender: UIButton) {
        let image  = originalImage!
        if image.size.width == 0{
            let alert = UIAlertController(title: "Error", message: "Please Select an Image", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }else{
            let ip = ImageProcessor()
            ip.processImage(image)
            let f = filterOptions()
            let imageRGBA = ip.filterImage(image, filterOption: f.f1) //<-- Change the option here
            imageView.image = imageRGBA.toUIImage()
            print("25%")
        }
    }
    
    @IBAction func seventyFivePercent(sender: UIButton) {
        let image  = originalImage!
        if image.size.width == 0{
            let alert = UIAlertController(title: "Error", message: "Please select and Image", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }else{
            let ip = ImageProcessor()
            ip.processImage(image)
            let f = filterOptions()
            let imageRGBA = ip.filterImage(image, filterOption: f.f3) //<-- Change the option here
            imageView.image = imageRGBA.toUIImage()
            print("75%")
        }
    }
    
    @IBAction func random(sender: UIButton) {
        let image  = originalImage!
        if image.size.width == 0{
            let alert = UIAlertController(title: "Error", message: "Please an Image", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }else{
            let ip = ImageProcessor()
            ip.processImage(image)
            let f = filterOptions()
            let imageRGBA = ip.filterImage(image, filterOption: f.f5) //<-- Change the option here
            imageView.image = imageRGBA.toUIImage()
            print("random")
        }
    }
    

}


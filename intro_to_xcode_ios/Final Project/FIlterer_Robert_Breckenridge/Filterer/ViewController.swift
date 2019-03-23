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
    @IBOutlet var imageView2: UIImageView!

    @IBOutlet var secondaryMenu: UIView!
    @IBOutlet var bottomMenu: UIView!
    
    @IBOutlet weak var compareImage: UIButton!
    @IBOutlet weak var greyScaleBtn: UIButton!
   
    @IBOutlet weak var fiftyPercBtn: UIButton!
    @IBOutlet weak var twentyFivePercBtn: UIButton!
    @IBOutlet weak var seventyFivePercBtn: UIButton!
    @IBOutlet weak var randomBtn: UIButton!
    @IBOutlet weak var editBtn: UIButton!
    
    
    
    
    
    @IBOutlet var filterButton: UIButton!
    var originalImage = UIImage(named:"scenery")
    var filteredImage: UIImage?
    
    @IBOutlet weak var sliderBtn: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        secondaryMenu.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.5)
        secondaryMenu.translatesAutoresizingMaskIntoConstraints = false
        
        compareImage.enabled = false;
        
        let singleTap1 = UILongPressGestureRecognizer(target: self, action: #selector(tapDetected1))

        imageView.userInteractionEnabled=true;
        imageView.addGestureRecognizer(singleTap1)
        imageView.image = originalImage
        
        imageView2.userInteractionEnabled=true;
        imageView2.addGestureRecognizer(singleTap1)
        imageView2.image = originalImage
        
        let greyscaleImage = greyScale()
        greyScaleBtn.setBackgroundImage(greyscaleImage, forState: .Normal)
        
        let fiftyPercImage = fiftyPerc()
        fiftyPercBtn.setBackgroundImage(fiftyPercImage, forState: .Normal)

        
        let twentyFivePercImage = twentFivePerc()
        twentyFivePercBtn.setBackgroundImage(twentyFivePercImage, forState: .Normal)

        
        let seventyFivePerImage = seventyFivePer()
        seventyFivePercBtn.setBackgroundImage(seventyFivePerImage, forState: .Normal)

        
        let randomImage = randomPerc()
        randomBtn.setBackgroundImage(randomImage, forState: .Normal)
        
        sliderBtn.hidden = true
        editBtn.enabled = false

        
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
            imageView2.image = image
            
            let greyscaleImage = greyScale()
            greyScaleBtn.setBackgroundImage(greyscaleImage, forState: .Normal)
            
            let fiftyPercImage = fiftyPerc()
            fiftyPercBtn.setBackgroundImage(fiftyPercImage, forState: .Normal)
            
            
            let twentyFivePercImage = twentFivePerc()
            twentyFivePercBtn.setBackgroundImage(twentyFivePercImage, forState: .Normal)
            
            
            let seventyFivePerImage = seventyFivePer()
            seventyFivePercBtn.setBackgroundImage(seventyFivePerImage, forState: .Normal)
            
            
            let randomImage = randomPerc()
            randomBtn.setBackgroundImage(randomImage, forState: .Normal)
        }
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    //Action
    func tapDetected1(sender: UILongPressGestureRecognizer) {
        if(sender.state == .Began){
            print("Ended")
            imageView2.image = originalImage
        }else if (sender.state == .Ended){
            print("Other")
            imageView2.image = filteredImage
        }
    }
    func tapDetected2(sender: UITapGestureRecognizer){
        imageView.image = originalImage
        imageView2.image = filteredImage
    }
    
    
    // MARK: Filter Menu
    @IBAction func onFilter(sender: UIButton) {
        if (sender.selected) {
            compareImage.enabled = false;
            editBtn.enabled = false
            hideSecondaryMenu()
            sender.selected = false
        } else {
            showSecondaryMenu()
             editBtn.enabled = true
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
                imageView2.image=filteredImage
                sender.selected = false
            } else {
                //showSecondaryMenu()
                imageView2.image=originalImage
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
            imageView.image = image
            imageView2.image = imageRGBA.toUIImage()
            self.imageView.alpha = 1.0
            self.imageView2.alpha = 0
            UIView.animateWithDuration(1) {
                self.imageView.alpha=0
                self.imageView2.alpha=1.0
            }
            print("Greyscale")
            sender.selected = false
            filteredImage = imageRGBA.toUIImage()
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
            imageView.image = image
            imageView2.image = imageRGBA.toUIImage()
            self.imageView.alpha = 1.0
            self.imageView2.alpha = 0
            UIView.animateWithDuration(1) {
                self.imageView.alpha=0
                self.imageView2.alpha=1.0
            }
            
            print("Greyscale")
            sender.selected = false
            filteredImage = imageRGBA.toUIImage()
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
            imageView.image = image
            imageView2.image = imageRGBA.toUIImage()
            self.imageView.alpha = 1.0
            self.imageView2.alpha = 0
            UIView.animateWithDuration(1) {
                self.imageView.alpha=0
                self.imageView2.alpha=1.0
            }
            
            print("Greyscale")
            sender.selected = false
            filteredImage = imageRGBA.toUIImage()
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
            imageView.image = image
            imageView2.image = imageRGBA.toUIImage()
            self.imageView.alpha = 1.0
            self.imageView2.alpha = 0
            UIView.animateWithDuration(1) {
                self.imageView.alpha=0
                self.imageView2.alpha=1.0
            }
            
            print("Greyscale")
            sender.selected = false
            filteredImage = imageRGBA.toUIImage()
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
            imageView.image = image
            imageView2.image = imageRGBA.toUIImage()
            self.imageView.alpha = 1.0
            self.imageView2.alpha = 0
            UIView.animateWithDuration(1) {
                self.imageView.alpha=0
                self.imageView2.alpha=1.0
            }
            imageView.image = imageRGBA.toUIImage()
            print("Greyscale")
            sender.selected = false
            filteredImage = imageRGBA.toUIImage()
            print("random")
        }
    }
   
    @IBAction func edit(sender: UIButton) {
        filterButton.selected = false
        if(sender.selected){
            editBtn.selected = false
            sliderBtn.hidden = true
        }else{
            editBtn.selected = true
            hideSecondaryMenu()
            sliderBtn.hidden = false
        }
    }
    
    @IBAction func silder(sender: UISlider) {
        
        let currentValue = Int(sender.value)
        if (filteredImage == nil){
            let alert = UIAlertController(title: "Error", message: "Please filter the image", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }else{
        let image = change_contrast(filteredImage!, contrast: currentValue)
        imageView2.image = image
        }
    }
    
    func greyScale() -> UIImage{
        let image  = originalImage!
        let ip = ImageProcessor()
        ip.processImage(image)
        let f = filterOptions()
        let imageRGBA = ip.filterImage(image, filterOption: f.f4) //<-- Change the option here
        return imageRGBA.toUIImage()!

    }
    func fiftyPerc() -> UIImage{
        let image  = originalImage!
        let ip = ImageProcessor()
        ip.processImage(image)
        let f = filterOptions()
        let imageRGBA = ip.filterImage(image, filterOption: f.f2) //<-- Change the option here
        return imageRGBA.toUIImage()!

    }
    func twentFivePerc() -> UIImage{
        let image  = originalImage!
        let ip = ImageProcessor()
        ip.processImage(image)
        let f = filterOptions()
        let imageRGBA = ip.filterImage(image, filterOption: f.f1) //<-- Change the option here
        return imageRGBA.toUIImage()!

    }
    func seventyFivePer() -> UIImage{
        let image  = originalImage!
        let ip = ImageProcessor()
        ip.processImage(image)
        let f = filterOptions()
        let imageRGBA = ip.filterImage(image, filterOption: f.f3) //<-- Change the option here
        return imageRGBA.toUIImage()!
    }
    func randomPerc() -> UIImage{
        let image  = originalImage!
        let ip = ImageProcessor()
        ip.processImage(image)
        let f = filterOptions()
        let imageRGBA = ip.filterImage(image, filterOption: f.f5) //<-- Change the option here
        return imageRGBA.toUIImage()!
    }
    func change_contrast(image: UIImage, contrast: Int) -> UIImage{
        print(contrast)
        var myRGBA = RGBAImage(image: image)!
        for y in 0..<myRGBA.height{
            for x in 0..<myRGBA.width{
                let index = y * myRGBA.width + x
                var pixel = myRGBA.pixels[index]
                let red = Double(pixel.red) + Double(contrast)
                let blue = Double(pixel.blue) + Double(contrast)
                let green = Double(pixel.green) + Double(contrast)
                pixel.red = UInt8(max(0,min(255,red)))
                pixel.green = UInt8(max(0,min(255,green)))
                pixel.blue = UInt8(max(0,min(255,blue)))
                myRGBA.pixels[index]=pixel
            }
        }
        return myRGBA.toUIImage()!
    }
}


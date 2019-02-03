//
//  ViewController.swift
//  Filter
//
//  Created by Rob on 2/2/19.
//  Copyright © 2019 Rob. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var filterImage: UIImage?
    @IBOutlet var imageView: UIImageView!
    
    @IBOutlet var imageToggle: UIButton!
    
    @IBAction func onImageToggled(sender: UIButton) {
        if imageToggle.selected {
            let image = UIImage(named: "sample")!
            imageView.image = image
            imageToggle.selected = false
        }else{
            imageView.image = filterImage;
            imageToggle.selected = true
        }
    }
        override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        imageToggle.setTitle("Show Befroe Image", forState: .Selected)
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


}


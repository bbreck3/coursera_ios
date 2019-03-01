//
//  ImageFilter.swift
//  Filterer
//
//  Created by Rob on 2/23/19.
//  Copyright © 2019 UofT. All rights reserved.
//

import Foundation
import UIKit
//filter for 25 percnet contrast
struct filter1{
    //percent contrast
    var red = 0.75
    var blue = 0.75
    var green = 0.75
    
}
//filter for 50 percent contrast
struct filter2{
    //percent contrast
    var red = 0.5
    var blue = 0.5
    var green = 0.5
    
}
//filter for 75 percent contrast
struct filter3{
    var red = 0.25
    var blue = 0.25
    var green = 0.25
}
// struct to hold all of the different filter options
struct filterOptions{
    let f1 = "25 percent contrast"
    let f2 = "50 percent contrast"
    let f3 = "75 percent contrast"
    let f4 = "grayscale"
    let f5 = "randomRed"
    let f6 = "randomBlue"
    let f7 = "randGreen"
}


//ImageProcessor class to create an modify an image
class ImageProcessor{
    var red: Int
    var avgRed:Int
    var blue: Int
    var avgBlue: Int
    var green: Int
    var avgGreen: Int
    init(){
        red = 0
        avgRed = 0
        blue = 0
        avgBlue = 0
        green = 0
        avgGreen = 0
    }
    //process the image: Gather all the pixal info
    func processImage(image: UIImage){
        var myRGBA = RGBAImage(image: image)!
        var totalRed = 0
        var totalGreen = 0
        var totalBlue = 0
        for y in 0..<myRGBA.height{
            for x in 0..<myRGBA.width{
                let index = y * myRGBA.width + x
                var pixel = myRGBA.pixels[index]
                totalRed+=Int(pixel.red)
                totalGreen+=Int(pixel.green)
                totalBlue+=Int(pixel.blue)
                
            }
        }
        //compute statistics on the pixal info
        let count = (myRGBA.width) * (myRGBA.height)
        avgRed = totalRed/count
        avgGreen = totalGreen/count
        avgBlue = totalBlue/count
    }
    //filter the image according the specfied filter option
    func filterImage(image: UIImage, filterOption: String)->RGBAImage{
        var myRGBA = RGBAImage(image: image)!
        let f = filterOptions()
        for y in 0..<myRGBA.height{
            for x in 0..<myRGBA.width{
                let index = y * myRGBA.width + x
                var pixel = myRGBA.pixels[index]
                let redDiff = Int(pixel.red)-avgRed
                let greenDiff = Int(pixel.green)-avgGreen
                let blueDiff = Int(pixel.blue)-avgBlue
                switch (filterOption) {
                case f.f1://"25 percent"
                    let f1 = filter1()
                    let red = Double(pixel.red) * Double(f1.red)
                    let blue = Double(pixel.blue) * Double(f1.blue)
                    let green = Double(pixel.green) * Double(f1.green)
                    pixel.red = UInt8(max(0,min(255,red)))
                    pixel.green = UInt8(max(0,min(255,green)))
                    pixel.blue = UInt8(max(0,min(255,blue)))
                    myRGBA.pixels[index]=pixel
                    break;
                case f.f2://"50 percent"
                    let f2 = filter2()
                    let red = Double(pixel.red) * Double(f2.red)
                    let blue = Double(pixel.blue) * Double(f2.blue)
                    let green = Double(pixel.green) * Double(f2.green)
                    pixel.red = UInt8(max(0,min(255,red)))
                    pixel.green = UInt8(max(0,min(255,green)))
                    pixel.blue = UInt8(max(0,min(255,blue)))
                    myRGBA.pixels[index]=pixel
                    break;
                case f.f3://"75 percent"
                    let f3 = filter3()
                    let red = Double(pixel.red) * Double(f3.red)
                    let blue = Double(pixel.blue) * Double(f3.blue)
                    let green = Double(pixel.green) * Double(f3.green)
                    pixel.red = UInt8(max(0,min(255,red)))
                    pixel.green = UInt8(max(0,min(255,green)))
                    pixel.blue = UInt8(max(0,min(255,blue)))
                    myRGBA.pixels[index]=pixel
                    break;
                case f.f4://"grayscale"
                    let gray = 0.299 * Double(pixel.red) + 0.587 * Double(pixel.green) + 0.114 * Double(pixel.blue)
                    let grayFinal = round(gray)
                    pixel.red = UInt8(grayFinal)
                    pixel.green = UInt8(grayFinal)
                    pixel.blue = UInt8(grayFinal)
                    myRGBA.pixels[index]=pixel
                    break;
                case f.f5://"randomRed"
                    let rand = Double(arc4random_uniform(100))/100
                    if(redDiff>0){
                        pixel.red = UInt8(max(0,min(255,(UInt8(avgRed)+UInt8(redDiff))*(UInt8(rand)))))
                        myRGBA.pixels[index]=pixel
                    }
                case f.f6://"randomBlue"
                    let rand = Double(arc4random_uniform(100))/100
                    if(blueDiff>0){
                        pixel.blue = UInt8(max(0,min(255,(UInt8(avgBlue)+UInt8(blueDiff))*(UInt8(rand)))))
                        myRGBA.pixels[index]=pixel
                    }
                case f.f7://"randomGreen"
                    let rand = Double(arc4random_uniform(100))/100
                    if(greenDiff>0){
                        pixel.green = UInt8(max(0,min(255,(UInt8(avgGreen)+UInt8(greenDiff))*(UInt8(rand)))))
                        myRGBA.pixels[index]=pixel
                    }
                default: print("No Such Case")
                }//end switch
            }//end inner for
        }//end outer for
        return myRGBA
    }//end setFilter
}//end class ImageProcessor

//var my_image = UIImage(named: "sample")!
//var imageRGBA1 = RGBAImage(image:my_image)
//imageRGBA1?.toUIImage()
//var ip = ImageProcessor()
//ip.processImage(my_image)
///************************
// Filter Options
// 
// f1 = "25 percent contrast"
// f2 = "50 percent contrast"
// f3 = "75 percent contrast"
// f4 = "grayscale"
// f5 = "randomRed"
// f6 = "randomBlue"
// f7 = "randomGreen"
// 
// **************************/
//let f = filterOptions()
//var imageRGBA2 = ip.filterImage(my_image, filterOption: f.f7) //<-- Change the option here
//imageRGBA2.toUIImage()



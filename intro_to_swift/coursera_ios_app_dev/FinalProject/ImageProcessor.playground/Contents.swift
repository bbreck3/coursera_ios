//: Playground - noun: a place where people can play

import UIKit

struct filter1{
    var name = "50 % contrast"
    var rePercent = 50
    var greenPercent = 50
    var bluePercent = 50
}

class ImageProcessor{
    
    //local variables
    var image_ = UIImage()
    var avgRed:Int
    var avgBlue:Int
    var avgGreen:Int
    var redDiff:Int
    var greenDiff:Int
    var blueDiff:Int
    var red: UInt8
    var green: UInt8
    var blue: UInt8
    var redStr: String
    var blueStr
    //contructor
    init(){
        avgRed = 0
        avgBlue = 0
        avgGreen = 0
        redDiff = 0
        blueDiff = 0
        greenDiff = 0
        red = 0
        green = 0
        blue = 0
    }
    //method to process the image
    func processImage(image: UIImage, name: String){
        //let image = UIImage(named: name)!
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
        //pixal statistics
        let count = myRGBA.width * myRGBA.height
        avgRed = totalRed/count
        avgGreen = totalGreen/count
        avgBlue = totalBlue/count
    }
    
    //getters and setters
    var image: UIImage{
        set{ image_ = image }
        get{return image_}
    }
    var redFilter: UInt8{
        set{red = UInt8(max(0,min(255,avgRed+redDiff*5)))}
        get{return red}
    }
    var redFilterStr: String{
        set
    }
    var greenFilter: UInt8{
        set{green = UInt8(max(0,min(255,avgGreen+greenDiff*5)))}
        get{return green}
    }
    var blueFilter: UInt8{
        set{blue = UInt8(max(0,min(255,avgBlue+blueDiff*5)))}
        get{return blue}
    }
    func setFilter(red: UInt8, green: UInt8, blue: UInt8, imageProcesor: ImageProcessor, image: UIImage)->RGBAImage{
        imageProcesor.redFilter = red
        imageProcesor.greenFilter = green
        imageProcesor.blueFilter = blue
        var myRGBA = RGBAImage(image: image)!
        for y in 0..<myRGBA.height{
            for x in 0..<myRGBA.width{
                let index = y * myRGBA.width + x
                var pixel = myRGBA.pixels[index]
                let redDiff = Int(pixel.red)-avgRed
                let greenDiff = Int(pixel.green)-avgGreen
                let blueDiff = Int(pixel.blue)-avgBlue
                if(redDiff>0){
                    print(imageProcesor.redFilter)
                    pixel.red = imageProcesor.redFilter
                    myRGBA.pixels[index]=pixel
                }
                if(greenDiff>0){
                    pixel.green = imageProcesor.greenFilter//UInt8(max(0,min(255,avgGreen+greenDiff-5)))
                    myRGBA.pixels[index]=pixel
                }
                if(blueDiff>0){
                    pixel.blue = imageProcesor.blueFilter//UInt8(max(0,min(255,avgBlue+blueDiff*2)))
                    myRGBA.pixels[index]=pixel
                }
            }
        }
        return myRGBA
    }
    
    
}//end class

var ip = ImageProcessor()
let imageName = "sample"
var my_image = UIImage(named: "sample")!
//ip.image = my_image
ip.processImage(my_image, name: imageName)
var newRGBAImage = ip.setFilter(100, green: 30, blue: 55, imageProcesor: ip, image: my_image)
var final = newRGBAImage.toUIImage()


//let newImage = UIImage(named: image)!
//var myRGBA = RGBAImage(image: newImage)!










//let newImage = myRGBA.toUIImage()

//var image = UIImage(named: "sample")!
//var myRGBA = RGBAImage(image: image)!
//let y = 10
//let x = 10
//
//let index = y * myRGBA.width + x
//var pixel = myRGBA.pixels[index]
//
//var totalRed = 0
//var totalGreen = 0
//var totalBlue = 0
//
//for y in 0..<myRGBA.height{
//    for x in 0..<myRGBA.width{
//        let index = y * myRGBA.width + x
//        var pixel = myRGBA.pixels[index]
//        totalRed+=Int(pixel.red)
//        totalGreen+=Int(pixel.green)
//        totalBlue+=Int(pixel.blue)
//
//    }
//}
//
//let count = myRGBA.width * myRGBA.height
//let avgRed = totalRed/count
//let avgGreen = totalGreen/count
//let avgBlue = totalBlue/count

//for y in 0..<myRGBA.height{
//    for x in 0..<myRGBA.width{
//        let index = y * myRGBA.width + x
//        var pixel = myRGBA.pixels[index]
//        let redDiff = Int(pixel.red)-avgRed
//        let greenDiff = Int(pixel.green)-avgGreen
//        let blueDiff = Int(pixel.blue)-avgBlue
//        if(redDiff>0){
//            pixel.red = UInt8(max(0,min(255,avgRed+redDiff/5)))
//            myRGBA.pixels[index]=pixel
//        }
//        if(greenDiff>0){
//            pixel.green = UInt8(max(0,min(255,avgGreen+greenDiff-5)))
//            myRGBA.pixels[index]=pixel
//        }
//        if(blueDiff>0){
//            pixel.blue = UInt8(max(0,min(255,avgBlue+blueDiff*2)))
//            myRGBA.pixels[index]=pixel
//        }
//    }
//}


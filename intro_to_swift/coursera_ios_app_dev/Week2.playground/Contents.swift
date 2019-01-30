//: Playground - noun: a place where people can play

import UIKit

var image = [[1,4,9],
            [2,5,7],
            [3,5,7]]

func raiseLowerValuesOfImage(inout image:[[Int]]){
    for row in 0..<image.count{
        for col in 0..<image[row].count{
            image[row][col]
            if image[row][col] < 5 {
                image[row][col]=5
            }
        }
    }
}

raiseLowerValuesOfImage(&image)

let noValue:Int? = nil
let unwrappedValue = noValue!

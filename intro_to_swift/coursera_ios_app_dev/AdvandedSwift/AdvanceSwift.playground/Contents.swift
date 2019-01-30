//: Playground - noun: a place where people can play

import UIKit


///Inheritance
class SuperNumber: NSNumber{
    override func getValue(value: UnsafeMutablePointer<Void>) {
        super.getValue(value)
    }
}

//extension
extension NSNumber {
    func superCoolGetter() -> Int{
        return 5
    }
}
//protocal -- like an interface
protocol dancable {
    func dance()
}
//example implementing the protocol
class Person:dancable{
    func dance() {
        print("Dancing!")
    }
}

//enums
enum TypesOfVeggies : String{
    case Carrots
    case Tomatoes
    case Celery
}

let carrot = TypesOfVeggies.Carrots
carrot.rawValue

func eatVeggies(veggie: TypesOfVeggies){
    
}

let randomVeggie = TypesOfVeggies(rawValue: "Lead")
eatVeggies(TypesOfVeggies.Carrots)

//initilizer
class Car{
    var cupHolder: String
    init(cupHolder: String){
        self.cupHolder = cupHolder
    }
}
let car = Car(cupHolder: "Cool")
//let newCar = Car()
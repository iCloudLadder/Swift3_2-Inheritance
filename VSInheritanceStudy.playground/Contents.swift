//: Playground - noun: a place where people can play

import UIKit

// >> 继承

// >> 基类
// 不继承于其它类的类,称之为基类(base calss)。
// Swift 中的类并不是从一个通用的基类继承而来。如果你不为你定义的类指定一个超类的话,这个类就自动成为基类

class Vehicle {
    var currentSpeed = 0.0
    var description: String {
        return "travleing at \(currentSpeed) miles per hour"
    }
    
    func makeNoise() {
        
    }
}

let someVehicle = Vehicle()
print("someVehicle: \(someVehicle.description)")


// >> 子类
// 子类生成(Subclassing)指的是在一个已有类的基础上创建一个新的类。
// 子类继承超类的特性,并且可以优化或 改变它。你还可以为子类添加新的特性。

// 为了指明某个类的超类,将超类名写在子类名的后面,用冒号分隔:
class SuperClass {} // 基类
class SubClass: SuperClass { }// 子类 继承 基类


class Bicycle: Vehicle {
    var hasBasket = false
}
// class Bicycle 自动继承 Vehicle类的所有特性，比如 currentSpeed和description属性,还有它的makeNois e 方法。
// 除了继承的特性， Bicycle 类还定义类一个储存属性 hasBasket 默认值 false，类型推断为 Bool类型

let bicycle = Bicycle()
bicycle.hasBasket = true
bicycle.currentSpeed = 16
print("Bicycle: \(bicycle.description)")


// 子类还可以继续被继承

class Tandem: Bicycle {
    var currentNumberOfPassengrs = 0
}
// 创建了一个Tandem实例，可以使用所有新的属性和继承的属性，以及继承的其他特性
let tandem = Tandem()
tandem.hasBasket = true
tandem.currentNumberOfPassengrs = 3
tandem.currentSpeed = 25.0
print("Tandem: \(tandem.description)")


// >>> 重写
/*
    子类可以为继承来的实例方法(instance method),类方法(class method),实例属性(instance propert y),或下标脚本(subscript)提供自己定制的实现(implementation)。我们把这种行为叫重写(overriding)。


    要重写某个特性,你需要在重写定义的前面加上 override ￼ 关键字
    这么做,你就表明了你是想提供一个重写 版本,而非错误地提供了一个相同的定义。
    意外的重写行为可能会导致不可预知的错误,任何缺少 override ￼ 关键字的重写都会在编译时被诊断为错误。


    override 关键字会提醒 Swift 编译器去检查该类的超类(或其中一个父类)是否有匹配重写版本的声明。这个检查可以确保你的重写定义是正确的。
*/


//  访问超类的方法,属性及下标脚本

/*

当你在子类中重写超类的方法,属性或下标脚本时,有时在你的重写版本中使用已经存在的超类实现会大有裨
益。比如,你可以优化已有实现的行为,或在一个继承来的变量中存储一个修改过的值。

在合适的地方,你可以通过使用 super 前缀来访问超类版本的方法,属性或下标脚本:
• 在方法 someMethod 的重写实现中,可以通过 super.someMethod() 来调用超类版本的 someMethod 方法。
• 在属性 someProperty 的 getter 或 setter 的重写实现中,可以通过 super.someProperty 来访问超类版本的 someProperty 属性。
• 在下标脚本的重写实现中,可以通过 super[someIndex] 来访问超类版本中的相同下标脚本。

*/




// >> 重写方法
// 在子类中,你可以重写继承来的实例方法或类方法,提供一个定制或替代的方法实现。


class Train: Vehicle {
    override func makeNoise() {
        print("Choo Choo")
    }
}
let train = Train()
train.makeNoise()

// >> 重写属性
// 你可以重写继承来的实例属性或类属性,提供自己定制的getter和setter,或添加属性观察器使重写的属性可以 观察属性值什么时候发生改变。

// let 属性 和 static 类属性不能被重写

// 重写属性的Getters和Setters
/*
    你可以提供定制的 getter(或 setter)来重写任意继承来的属性,无论继承来的属性是存储型的还是计算型的 属性。子类并不知道继承来的属性是存储型的还是计算型的,它只知道继承来的属性会有一个名字和类型。你在 重写一个属性时,必需将它的名字和类型都写出来。这样才能使编译器去检查你重写的属性是与超类中同名同类 型的属性相匹配的。


    **可以将一个继承来的只读属性重写为一个读写属性,只需要你在重写版本的属性里提供 getter 和 setter 即可
    ** 但不可以将一个继承来的读写属性重写为一个只读属性。
    ** 如果你在重写属性中提供了 setter,那么你也一定要提供 getter
    如果你不想在重写版本中的 getter 里修改 继承来的属性值,你可以直接通过 super.someProperty 来返回继承来的值,其中 someProperty 是你要重写的属 性的名字。

*/

class Car: Vehicle {
    var gear = 1
    override var description: String {
        return super.description + "in gear \(gear)"
    }
}

let car = Car()
car.currentSpeed = 30.0
car.gear = 3
print("Car: \(car.description)")




// >> 重写属性观察器(Property Observer)

// 你可以在属性重写中为一个继承来的属性添加属性观察器。
// 这样一来,当继承来的属性值发生改变时,你就会被 通知到,无论那个属性原本是如何实现的
/* **
    你不可以为继承来的常量存储型属性或继承来的只读计算型属性添加属性观察器。
    这些属性的值是不可以被设置 的,所以,为它们提供 willSet 或 didSet 实现是不恰当。

    此外还要注意,你不可以同时提供重写的 setter 和 重写的属性观察器。如果你想观察属性值的变化,并且你已经为那个属性提供了定制的 setter,那么你在 setter 中就可以观察到任何值变化了。
*/

class AutomaticCar: Car {
    override var currentSpeed: Double {
        // set { } // error, setter 不可于 观察器同时重写
        didSet {
            gear = Int(currentSpeed / 10) + 1
        }
    }
}

let automatic = AutomaticCar()
automatic.currentSpeed = 45.0
print("AutomaticCar: \(automatic.description)")






// >> 防止重写
/*
    可以通过把方法,属性或下标脚本标记为 final 来防止它们被重写,只需要在声明关键字前加上 final 特性即可。
    (例如: final var , final func , final class func , 以及 final subscript )

    如果你重写了 final 方法,属性或下标脚本,在编译时会报错。
    在类扩展中的方法,属性或下标脚本也可以在扩展的定义里标记为 final。

    可以通过在关键字 class 前添加 final 特性( final class )来将整个类标记为 final 的,这样的类是不可被 继承的,任何子类试图继承此类时,在编译时会报错。

*/

class BaseClass {
    final var one = 1
    final func testFinalFunc(){
    }
    final class func classFinalFunc(){
    }
}

class OneSubClass: BaseClass {
    /*
    override var one: Int { // error
        didSet {
            print("one's value changes")
        }
    }
    */
}

final class FinalBaseClass {
    
}

// class OtherSubclass: FinalBaseClass {}  error


final class FinalSubClass: BaseClass {

}
// class anOtherSubclass: FinalSubClass {}  error














// lazy 属性 被重写后会变成 计算型属性 或 带有观察器的储存属性


class OneSuperClass {
    lazy var oneProperty = "one"
    class var oneClassProperty: String {
        return "one class var"
    }
    
}
class OneChileClass: OneSuperClass {
    
    override var oneProperty: String {
        set {
            print("ddd")
        }
        get {
            return "sss"
        }
    }
    
    override class var oneClassProperty: String {
        set {
            print("override class var set")
        }
        get {
            return "override class var get"
        }
    }
    
}
let one = OneChileClass()
print(one.oneProperty)
OneSuperClass.oneClassProperty
OneChileClass.oneClassProperty













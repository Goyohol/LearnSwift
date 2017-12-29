//
//  ViewController.swift
//  swiftUse
//
//  Created by RainHeroic Kung on 2017/12/18.
//  Copyright © 2017年 RainHeroic Kung. All rights reserved.
//



//import Cocoa  //创建"OS x"程序
import UIKit

/**   扩展   
  定义在文件内，函数外 */
extension Int {     //【一】、添加计算型实例属性 或 计算型类型属性
    var add: Int {return self + 100 }
    var sub: Int { return self - 10 }
    var mul: Int { return self * 10 }
    var div: Int { return self / 5 }
}

struct sum {
    var num1 = 100, num2 = 200
}
struct diff {
    var no1 = 200, no2 = 100
}
struct mult {
    var a = sum()
    var b = diff()
}
extension mult {    //【二】、向已有类型 添加新的构造器
    init(x: sum, y: diff) {
        _ = x.num1 + x.num2
        _ = y.no1 + y.no2
    }
}

extension Int {     //【三】、向已有类型添加新的实例方法 或 类型方法
    func topics(summation: () -> ()) {
        for _ in 0..<self {
            summation()
        }
    }
}

extension Double {  //【四】、可以修改该实例本身(修改 self 或 其属性 的方法必须将实例方法标注为mutating)
    mutating func square() {
        let pi = 3.1415
        self = pi * self * self
    }
}

extension Int {     //【五】、向一个已有类型添加新下标
    subscript(mult: Int) -> Int {
        var no1 = 1
        var tempInt = mult //中间变量：自减，来判断条件
        
        while tempInt > 0 {
            no1 *= 10
            tempInt -= 1
        }
        return (self / no1) % 10
    }
}

extension Int {     //【六】、向已有的类、结构体和枚举添加新的嵌套类型
    enum calc
    {
        case add
        case sub
        case mult
        case div
        case anything
    }
    var print: calc {//var print属性 向calc枚举，添加新的嵌套类型
        switch self
        {
        case 0:
            return .add
        case 1:
            return .sub
        case 2:
            return .mult
        case 3:
            return .div
        default:
            return .anything
        }
    }
}


/**   协议
 定义在文件内，函数外 */
//【一】、对属性的规定
protocol protocola {    //协议protocola
    var marks: Int { get set }
    var result: Bool { get }
    
    func attendance() -> String
    func markssecured() -> String
}
protocol protocolb: protocola {   //继承自 协议protocola的 协议protocolb
    var present: Bool { get set }
    var subject: String { get set }
    var stname: String { get set }
}
//【二】、对 Mutating方法的规定
protocol daysofaweek {
    mutating func show() //修改(mutating) 实例
}
//【三】、构造器的规定
protocol tcpprotocol {
    init(no1: Int)
}
//【四】、协议类型
protocol Generator {
    associatedtype members //associatedtype:实现泛型功能 (声明一个类型的占位符作为协议定义的一部分)
    func next() -> members?
}
//【五】、在扩展中添加协议成员
protocol AgeClasificationProtocol {
    var age: Int { get }
    func agetype() -> String
}
class AddProtoclMemberPerson {
    let firstname: String
    let lastname: String
    var age: Int
    init(firstname: String, lastname: String) {
        self.firstname = firstname
        self.lastname = lastname
        self.age = 10
    }
}
extension AddProtoclMemberPerson : AgeClasificationProtocol {
    func fullname() -> String {
        var c: String
        c = firstname + " " + lastname
        return c
    }
    
    func agetype() -> String {
        switch age {
        case 0...2:
            return "Baby"
        case 2...12:
            return "Child"
        case 13...19:
            return "Teenager"
        case let x where x > 65:
            return "Elderly"
        default:
            return "Normal"
        }
    }
}
//【六】、协议的继承
protocol aProtoc {
    var no1: Int { get set }
    func calc(sum: Int)
}
protocol ResultProtoc {
    func print(target: aProtoc)
}
class inheritStudent: aProtoc {
    var no1: Int = 10
    
    func calc(sum: Int) {
        no1 -= sum
        print("学生尝试 \(sum) 次通过")
        
        print("no1 is:",no1)
        if no1 <= 0 {
            print("学生缺席考试")
        }
    }
}

class inheritStudent2: ResultProtoc {
    func print(target: aProtoc) {
        target.calc(sum: 1)
    }
}
class Classb: ResultProtoc {
    func print(target: aProtoc) {
        target.calc(sum: 5) //首次执行
    }
}
//【七】、类专属协议
protocol classdeTcpProtocol {
    init(no1: Int)
}
//【七】、协议合成
protocol Stname {
    var name: String { get }
}
protocol Stage {
    var age: Int { get }
}
//【八】、检验协议的一致性
protocol HasArea {
    var area: Double { get }
}






//扩展 泛型类型
struct extensStack<Element> {
    var items = [Element]()
    mutating func push(_ item: Element) {
        items.append(item)
    }
    mutating func pop() -> Element {
        return items.removeLast()
    }
}
extension extensStack {
    var topItem: Element? {
        return items.isEmpty ? nil : items[items.count - 1]
    }
}


//关联类   associatedtype
protocol associateContainer {    // Container协议
    associatedtype ItemType
    mutating func append(_ item: ItemType)     // 添加一个新元素到容器里
    
    var count: Int { get }     // 获取容器中元素的数
    
    subscript(i: Int) -> ItemType { get }     // 通过索引值类型为 Int的下标检索到容器中的每一个元素
}


//Where语句：定义 参数的约束
protocol Container {    // Container 协议
    associatedtype ItemType
    // 添加一个新元素到容器里
    mutating func append(_ item: ItemType)
    // 获取容器中元素的数
    var count: Int { get }
    // 通过索引值类型为 Int 的下标检索到容器中的每一个元素
    subscript(i: Int) -> ItemType { get }
}
extension Array: Container {   // 扩展，将 Array 当作 Container 来使用
}


//访问控制
public class SomePublicClass {} //public:可以访问 自己模块中源文件里的任何实体，别人也可以通过引入该模块来访问源文件里的所有实体。
internal class SomeInternalClass {} //internal:可以访问 自己模块中源文件里的任何实体，但是别人不能访问该模块中源文件里的实体。
fileprivate class SomeFilePrivateClass {} //fileprivate:文件内私有，只能在当前源文件中使用。
private class SomePrivateClass {} //private:只能在类中访问，离开了这个类或者结构体的作用域外面就无法访问。

public var somePublicVariable = 0
internal let someInternalConstant = 0
fileprivate func someFilePrivateFunction() {}
private func somePrivateFunction() {}
//》》》未指定访问级别  默认为 internal
class noStateInternalClass {}   // 访问级别为 internal
let noStateInternalConstant = 0 // 访问级别为 internal

//【二】、枚举类型访问权限
public enum authorityStudent {
    case Name(String)
    case Mark(Int,Int,Int)
}
//【三】、子类访问权限
public class authoritySuperClass {
    fileprivate func show() {
        print("超类")
    }
}
// 访问级别不能低于超类 internal > public
internal class authoritySubClass: authoritySuperClass  {
    override internal func show() {
        print("子类")
    }
}
//【四】、常量、变量、属性、下标访问权限
private class fkuPrivateClass {}
//public var privateInstance = fkuPrivateClass()   //Variable cannot be declared public because its type 'fkuPrivateClass' uses a private type
private var privateInstance = fkuPrivateClass()
//【七】、协议访问权限: 协议与协议提供的方法 访问级别 相同
public protocol TcpProtocol {
    init(no1: Int)
}
public class protocMainClass {
    var no1: Int // local storage
    init(no1: Int) {
        self.no1 = no1 // initialization
    }
}
//【八】、泛型访问权限: 取泛型类型、函数本身、泛型类型参数三者中的最低访问级别
public struct authorityTOS<T> {
    var items = [T]()
    fileprivate mutating func push(item: T) {
        //使用private，报错：'push' is inaccessible due to 'private' protection level
        items.append(item)
    }
    
    mutating func pop() -> T {
        return items.removeLast()
    }
}
//【九】、类型别名 的访问级别: 一个类型别名的访问级别不可高于原类型的访问级别
public protocol visitContainer {
    associatedtype ItemType //使用typealias，报错：Typealias is missing an assigned type; use 'associatedtype' to define an associated type requirement
    mutating func append(item: ItemType)
    var count: Int { get }
    subscript(i: Int) -> ItemType { get }
}








class ViewController: UIViewController ,UITextFieldDelegate { //添加协议

    @IBOutlet weak var quitKeyBoardBtn: UIButton! //拖的控件

    
    var array1 = Array<Int>()
    var array2 : Array<Int> = Array<Int>()
    var array3 : Array<Int> = Array()
    var array4 : Array = Array<Int>()
    var array5 : Array = [Int]()
    var array6 : [Int] = Array()
    var array7 : [Int] = [Int]()
    var array8 = [1, 2, 3, 4]
    
    let str = "abc"
    let str2 = "is"
    let str3 = "a"
    let str4 = "hero"
    let str5 = "666666"
    
    let numOfYou = 123456
    let numOfRab = 31
    
    var showStr = String()
    
    
    
    /** UI */
    var tf = UITextField();
    var button = UIButton();
    
    
    
    /** 可选(Optionals)类型 */
    var optionalInteger1: Int?
    var optionalInteger2: Optional<Int> = nil
    
    var optionalString:String? = nil
    var optionalString222:String!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        /** 语言的使用 */
        
//        //基本类型的操作
//        self.basicTypeFunc()
//        
//        //类型的操作
//        self.typeFunc()
//        
//        //变量的声明
//        self.declarationFunc()
//        
//        //使用 简单的 Unicode字符
//        self.unicodeFunc()
//        
//        //字符串(String)操作
//        self.stringFunc()
//       
//        //unicode字符串 操作
//        self.unicodeStringFunc()
//
//        //元组的操作
//        self.tupleFunc()
//        //数组的操作
//        self.arrayFunc()
//        //字典的操作
//        self.dictionaryFunc()
//
//        //函数的使用
//        self.functionUseFunc()
//        //闭包(closures)的使用
//        self.closuresUseFunc()
//        
//        //枚举(enumerate)的使用
//        self.enumerateUseFunc()
//        //结构体(struct)的使用
//        self.structUseFunc()
//        
//        //类(class)的使用
//        self.classUseFunc()
//        //属性(property)的使用
//        self.propertyUseFunc()
//        
//        //类的介绍(class)
//        self.classIntroduceFunc()
//
//        //方法(method)的使用
//        self.methodUseFunc()
//        
//        //下标脚本(subscript)的使用
//        self.subscriptUseFunc()
//        
//        //构造器的使用
//        self.initializerFunc()
//        //析构器的使用
//        self.deinitializerFunc()
//        
//        //可选链（Optional Chaining）
//        self.OptionalChainingFunc()
//        
//        //自动引用计数（ARC）
//        self.seeARCFunc()
//        
//        //类型转换
//        self.typeTransformFunc()
//        
//        //扩展(extension)
//        self.extensionUseFunc()
//        //协议(protocol)
//        self.protocolUseFunc()
//        
//        //泛型(Generics)
//        self.GenericsUseFunc()
//        
//        //访问控制(access control)
//        self.AccessControlUseFunc()
        
        
        
        
        
        /** UI界面 */
        let screenBounds:CGRect = UIScreen.main.bounds  //获取屏幕大小
        
        let labelRect = CGRect(x: 0, y: 20, width:screenBounds.width , height: 50)
        let noticeLB = UILabel.init(frame: labelRect)
        noticeLB.text = "UI展示 界面"
        noticeLB.textAlignment = NSTextAlignment.center //字体居中
        noticeLB.font = UIFont.boldSystemFont(ofSize: 20)   //字体大小
        noticeLB.adjustsFontSizeToFitWidth = true       //大小自适应
        self.view .addSubview(noticeLB)
        
        let presentBtn = UIButton .init(frame: CGRect(x: 100, y: 100, width: 200, height: 30))
        presentBtn .setTitle("跳转到下个界面", for: UIControlState.normal)
        presentBtn .backgroundColor = UIColor.cyan;
        presentBtn .addTarget(self, action: #selector(ViewController.presentToAnother), for: UIControlEvents.touchUpInside)
        self.view .addSubview(presentBtn)
        
        
        let rect = CGRect(x: 100, y: 150, width: 200, height: 30)
        tf = UITextField .init(frame: rect)         //输入框
        tf.borderStyle = UITextBorderStyle.line
        tf.placeholder = "输入内容"
        tf.clearButtonMode = UITextFieldViewMode.whileEditing
        tf.delegate = self
        self.view .addSubview(tf)
        
        let rect_Btn = CGRect(x: 200, y: 200, width: 150, height: 30)
        button = UIButton.init(frame: rect_Btn);    //取消(键盘)按钮
        button .setTitle("取消使用键盘", for: UIControlState.normal)
        button .backgroundColor = UIColor.red;
        button .addTarget(self, action: #selector(ViewController.dowith), for: UIControlEvents.touchUpInside)
        self.view .addSubview(button)
        
        
        
        
        
        let swiftUseLB = UILabel.init(frame: CGRect(x: 10, y: UIScreen.main.bounds.height - UIScreen.main.bounds.width, width: UIScreen.main.bounds.width - 2*10, height: UIScreen.main.bounds.width))
        self.view .addSubview(swiftUseLB)
        swiftUseLB.textAlignment = .center
        swiftUseLB.adjustsFontSizeToFitWidth = true
        swiftUseLB.font = UIFont.boldSystemFont(ofSize: 100)
        swiftUseLB.textColor = UIColor.red
        swiftUseLB.text = "swift使用"
        
    }
    
    func presentToAnother() { //跳转到下个界面
        let anotherVC = AnotherViewController()
        self .present(anotherVC, animated: true) { 
            print("present 跳转已完成")
        }
    }
    func dowith() { //按钮点击
        tf .resignFirstResponder();
    }
    //storyboard拖的方法
    @IBAction func clickToQuiteUsingKeyBoard(_ sender: Any) {
        tf .resignFirstResponder();
    }
    
    
    // MARK: - UITextFieldDelegate
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        print("ShouldBegin Editing")
        
        return true
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print("DidBegin Editing")
        
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        print("DidEnd Editing")
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let alertC = UIAlertController.init(title: "标题标题的", message: nil, preferredStyle: UIAlertControllerStyle.alert)
        alertC.message = "点击点击点击"
        let okAction = UIAlertAction.init(title: "确认", style: UIAlertActionStyle.default) { (okAction) in
            
            alertC .dismiss(animated: true, completion: { 
                
            })
            
        }
        let cancelAction = UIAlertAction.init(title: "取消", style: UIAlertActionStyle.cancel) { (cancelAction) in
            
            alertC .dismiss(animated: true, completion: {
                
            })
            
        }
        
        alertC .addAction(okAction)
        alertC .addAction(cancelAction)
        
        self .present(alertC, animated: true) { 
            
        }
        
        
        return true
    }
    
    
    
    
    
    
    
    
    
    
    //访问控制(access control):【一】、函数类型访问权限: 函数的访问级别需要根据该函数的参数类型和返回类型的访问级别得出
////    func someFunction() -> (SomeInternalClass, SomePrivateClass) {
////        //Error：Method must be declared fileprivate its result uses a private type
////        //一个类 SomeInternalClass 的访问级别是internal，另一个 SomePrivateClass 的访问级别是private。所以该元组的访问级别是 private
////        
////        // 函数实现
////        
////    }
//    private func someFunction() -> (SomeInternalClass, SomePrivateClass) {
//        // 函数实现
//
//    }
    func AccessControlUseFunc() {
        print("--------访问控制(access control)----------")
        
        //print(" 【一】、函数类型访问权限: 函数的访问级别需要根据该函数的参数类型和返回类型的访问级别得出")
        
        
        print(" 【二】、枚举类型访问权限: 枚举中成员的访问级别继承自该枚举")
        var studDetails = authorityStudent.Name("Swift")
        var studMarks = authorityStudent.Mark(98,97,95)
        
        switch studMarks {
        case .Name(let studName):
            print("学生名: \(studName).")
        case .Mark(let Mark1, let Mark2, let Mark3):
            print("学生成绩: \(Mark1),\(Mark2),\(Mark3)")
        }
        
        print(" 【三】、子类访问权限: 子类的访问级别不得高于父类的访问级别。")
        let sup = authoritySuperClass()
        sup.show()
        let sub = authoritySubClass()
        sub.show()
        
//        print(" 【四】、常量、变量、属性、下标访问权限")
//        print("     常量、变量、属性：不能拥有比它们的类型 更高的访问级别。")
//        print("     下标：也不能拥有比索引类型或返回类型 更高的访问级别。")
        
        
        print(" 【五】、Getter 和 Setter访问权限")
        class Samplepgm {
            fileprivate var counter: Int = 0{
                willSet(newTotal){
                    print("计数器: \(newTotal)")
                }
                didSet{
                    if counter > oldValue {
                        print("新增加数量 \(counter - oldValue)")
                    }
                }
            }
        }
        let NewCounter = Samplepgm()
        NewCounter.counter = 100
        NewCounter.counter = 800
        
        
        print(" 【六】、构造器和默认构造器访问权限")
        class classA {
            required init() {
                var a = 10
                print("classA初始化"," 成员a =",a)
            }
        }
        class classB: classA {
            required init() {
                var b = 30
                print("classB初始化"," 成员b =",b)
            }
        }
        let res = classA()
        let show = classB()
        
        print(" 【七】、协议访问权限: 协议与协议提供的方法 访问级别 相同")
        class protocSubClass: protocMainClass, TcpProtocol {
            var no2: Int
            init(no1: Int, no2 : Int) {
                self.no2 = no2
                super.init(no1:no1)
            }
            // Requires only one parameter for convenient method
            required override convenience init(no1: Int)  {
                self.init(no1:no1, no2:0)
            }
        }
        let protocRes = protocMainClass(no1: 20)
        let protocShow = protocSubClass(no1: 30, no2: 50)
        print("protocRes.no1 is: \(protocRes.no1)")
        print("protocShow.no1 is: \(protocShow.no1)")
        print("protocShow.no2 is: \(protocShow.no2)")
        
        print(" 【八】、泛型访问权限: 取泛型类型、函数本身、泛型类型参数三者中的最低访问级别")
        var authoritytos = authorityTOS<String>()
        authoritytos.push(item: "Swift")
        print(authoritytos.items)
        authoritytos.push(item: "泛型")
        print(authoritytos.items)
        authoritytos.push(item: "类型参数")
        print(authoritytos.items)
        authoritytos.push(item: "类型参数名")
        print(authoritytos.items)
        let deletetos = authoritytos.pop() //移除顶部元素
        print(authoritytos.items)
        
        print(" 【九】、类型别名 的访问级别: 一个类型别名的访问级别不可高于原类型的访问级别")
        struct visitStack<T>: visitContainer {
            // original visitStack<T> implementation
            var items = [T]()
            mutating func push(item: T) {
                items.append(item)
            }
            mutating func pop() -> T {
                return items.removeLast()
            }
            
            // conformance to the Container protocol
            mutating func append(item: T) {
                self.push(item: item)
            }
            
            var count: Int {
                return items.count
            }
            
            subscript(i: Int) -> T {
                return items[i]
            }
        }
        
        func allItemsMatch<
            C1: Container, C2: Container>
            (someContainer: C1, anotherContainer: C2) -> Bool
            where C1.ItemType == C2.ItemType, C1.ItemType: Equatable {
            // check that both containers contain the same number of items
            if someContainer.count != anotherContainer.count {
                return false
            }
            // check each pair of items to see if they are equivalent
            for i in 0..<someContainer.count {
                if someContainer[i] != anotherContainer[i] {
                    return false
                }
            }
            
            // all items match, so return true
            return true
        }
        var tos = visitStack<String>()
        tos.push(item: "Swift")
        print(tos.items)
        tos.push(item: "泛型")
        print(tos.items)
        tos.push(item: "Where 语句")
        print(tos.items)
        var eos = ["(new) Swift", "(new) 泛型", "(new) Where 语句"]
        print(eos)
        
        
        
        print("----------------------------")
    }
    
    func GenericsUseFunc() {
        print("--------泛型(Generics)----------")
        
        print(">>>非泛型函数，用来交换两个 Int值")
        func swapTwoInts(_ a: inout Int, _ b: inout Int) { // 定义一个交换两个变量的函数
            let temporaryA = a
            a = b
            b = temporaryA
        }
        var numb1 = 100
        var numb2 = 200
        print("交换前数据: \(numb1) 和 \(numb2)")
        swapTwoInts(&numb1, &numb2)
        print("交换后数据: \(numb1) 和 \(numb2)")
        
        print(">>>非泛型函数，用来交换两个 String值")
        func swapTwoStrings(_ a: inout String, _ b: inout String) {
            let temporaryA = a
            a = b
            b = temporaryA
        }
        var str = "abc"
        var str2 = "fku"
        print("交换前数据: \(str) 和 \(str2)")
        swapTwoStrings(&str, &str2)
        print("交换后数据: \(str) 和 \(str2)")
        
        print(">>>非泛型函数，用来交换两个 Double值")
        func swapTwoDoubles(_ a: inout Double, _ b: inout Double) {
            let temporaryA = a
            a = b
            b = temporaryA
        }
        var doubleNum1 = 123.456
        var doubleNum2 = 0.00125
        print("交换前数据: \(doubleNum1) 和 \(doubleNum2)")
        swapTwoDoubles(&doubleNum1, &doubleNum2)
        print("交换后数据: \(doubleNum1) 和 \(doubleNum2)")
        
        //以上代码，它们功能代码是相同的，只是类型上不一样，这时我们可以使用泛型，从而避免重复编写代码。
        print("· · · · · · · · ·")
        //泛型:使用了占位类型名（在这里用字母 T 来表示）来代替 实际类型名（例如 Int、String 或 Double）。
        print(" 【一】、泛型函数(exchange): 用来交换两个Int 和 String")
        func swapTwoValues<T>(_ a: inout T, _ b: inout T) { // 定义一个交换两个变量的函数
            let temporaryA = a
            a = b
            b = temporaryA
        }
        var exchangeNumb1 = 100
        var exchangeNumb2 = 200
        print("Int类型交换前数据: \(exchangeNumb1) 和 \(exchangeNumb2)")
        swapTwoValues(&exchangeNumb1, &exchangeNumb2)
        print("Int类型交换后数据: \(exchangeNumb1) 和 \(exchangeNumb2)")
        var exchangeStr1 = "A"
        var exchangeStr2 = "B"
        print("String类型交换前数据: \(exchangeStr1) 和 \(exchangeStr2)")
        swapTwoValues(&exchangeStr1, &exchangeStr2)
        print("String类型交换后数据: \(exchangeStr1) 和 \(exchangeStr2)")
        
        
        print()
        print(">>>非泛型版本的栈: Int型的栈")
        struct IntStack {
            var items = [Int]()
            mutating func push(_ item: Int) {
                items.append(item)
            }
            mutating func pop() -> Int {
                return items.removeLast()
            }
        }
        var stack = IntStack()
        print(" 整数元素入栈: ")
        stack.push(1)
        stack.push(2)
        print("stack.items =",stack.items);
        
        print("· · · · · · · · ·")
        print(" 【二】、泛型的栈")
        struct Stack<Element> {
            var items = [Element]() //Element:占位类型名
            mutating func push(_ item: Element) { //入栈
                items.append(item)
            }
            mutating func pop() -> Element {      //出栈
                return items.removeLast()
            }
        }
        
        var stackOfStrings = Stack<String>()
        print(" 字符串元素入栈: ")
        stackOfStrings.push("google")
        stackOfStrings.push("fku")
        print("出栈前", "stackOfStrings.items =",stackOfStrings.items);
        
        let deletetos = stackOfStrings.pop()
        print(" 出栈的元素: " + deletetos)
        print("出栈后", "stackOfStrings.items =",stackOfStrings.items);
        
        var stackOfInts = Stack<Int>()
        print(" 整数元素入栈: ")
        stackOfInts.push(1)
        stackOfInts.push(2)
        print("stackOfInts.items =",stackOfInts.items);
        
        
        print(" 【三】、扩展泛型类型")
        var extensStrStack = extensStack<String>()
//        print(extensStrStack.topItem)
//        print(extensStrStack.topItem ?? "kong")
        print(" 字符串元素入栈: ")
        extensStrStack.push("google")
        extensStrStack.push("fku")
        print(extensStrStack.items)
        if let topItem = extensStrStack.topItem {
            print(" 栈中的顶部元素是：\(topItem).") //后入的 在顶层
        }
        
        print(" 【四】、类型约束") //指定了一个必须继承自指定类的类型参数，或者遵循一个特定的协议或协议构成。
        // 非泛型函数，查找指定字符串在数组中的索引
        func findIndex(ofString valueToFind: String, in array: [String]) -> Int? {
            for (index, value) in array.enumerated() {
                if value == valueToFind {
                    return index // 找到返回索引值
                }
            }
            return nil
        }
        let strings = ["google", "weibo", "taobao", "fku", "facebook"]
        if let foundIndex = findIndex(ofString: "fku", in: strings) {
            print("fku 的索引为 \(foundIndex)")
        }
        
        print(" 【五】、关联类   associatedtype关键字 设置 关联类型实例")
        struct associateStack<Element>: associateContainer {  // Stack结构体遵从 Container协议
            // associateStack<Element> 的原始实现部分
            var items = [Element]()
            mutating func push(_ item: Element) {
                items.append(item)
            }
            mutating func pop() -> Element {
                return items.removeLast()
            }
            // Container协议的实现部分
            mutating func append(_ item: Element) {
                self.push(item)
            }
            var count: Int {
                return items.count
            }
            subscript(i: Int) -> Element {
                return items[i]
            }
        }
        var tos = associateStack<String>()
        tos.push("google")
        tos.push("fku")
        tos.push("taobao")
        
        print("元素列表:",tos.items)    // 元素列表
        print("元素个数:",tos.count)    // 元素个数
        
        print(" 【六】、Where语句：定义 参数的约束")
        // 遵循Container协议的泛型TOS类型
        struct whereStack<Element>: Container {
            // whereStack<Element> 的原始实现部分
            var items = [Element]()
            mutating func push(_ item: Element) {
                items.append(item)
            }
            mutating func pop() -> Element {
                return items.removeLast()
            }
            // Container 协议的实现部分
            mutating func append(_ item: Element) {
                self.push(item)
            }
            var count: Int {
                return items.count
            }
            subscript(i: Int) -> Element {
                return items[i]
            }
        }
        
        func allItemsMatch<C1: Container, C2: Container>
            (_ someContainer: C1, _ anotherContainer: C2) -> Bool
            where C1.ItemType == C2.ItemType, C1.ItemType: Equatable { //where语句逐个比较
                // 检查两个容器含有相同数量的元素
                if someContainer.count != anotherContainer.count {
                    return false
                }
                // 检查每一对元素是否相等
                for i in 0..<someContainer.count {
                    if someContainer[i] != anotherContainer[i] {
                        return false
                    }
                }
                // 所有元素都匹配，返回 true
                return true
        }
        var whereTos = whereStack<String>()
        whereTos.push("google")
        whereTos.push("fku")
        whereTos.push("taobao")
        var whereAos = ["google", "fku", "taobao"]
        
        if allItemsMatch(whereTos, whereAos) {
            print("匹配所有元素")
        } else {
            print("元素不匹配")
        }
        
        
        
        print("----------------------------")
    }
    
    func protocolUseFunc() {
        print("--------协议(protocol)----------")
        
        print(" 【一】、对属性的规定")
        class classc: protocolb { //满足协议classb 的 类classc
            var marks = 96
            let result = true //只读属性
            var present = false
            var subject = "Swift 学科"
            var stname = "Protocols"
            
            func attendance() -> String {
                return "The \(stname) has secured 99% attendance"
            }
            func markssecured() -> String {
                return "\(stname) has scored \(marks)"
            }
        }
        let studdet = classc()
        studdet.stname = "fuk"//可读可写属性
        studdet.marks = 98//可读可写属性
//        studdet.result = true //只读属性  (Cannot assign to property: 'result' is a 'let' constant)
        print("方法",studdet.markssecured())
        print("实例的属性",studdet.marks)
        print("实例的属性",studdet.result)
        print("实例的属性",studdet.present)
        print("实例的属性",studdet.subject)
        print("实例的属性",studdet.stname)
        
        print(" 【二】、对 Mutating方法的规定")
        enum days: daysofaweek { //（定义在函数内、外都可以）满足 daysofaweek协议的 枚举days
            case sun, mon, tue, wed, thurs, fri, sat
            mutating func show() { //修改(mutating) 实例
                switch self {
                case .sun:
                    self = .sun
                    print("Sunday")
                case .mon:
                    self = .mon
                    print("Monday")
                case .tue:
                    self = .tue
                    print("Tuesday")
                case .wed:
                    self = .wed
                    print("Wednesday")
                case .thurs:
                    self = .thurs
                    print("Wednesday")
                case .fri:
                    self = .fri
                    print("Wednesday")
                case .sat:
                    self = .sat
                    print("Saturday")
                default:
                    print("NO Such Day")
                }
            }
        }
        var res = days.wed
        res.show()
        
        print(" 【三】、对构造器的规定")
        print(">>>要求协议的遵循者 实现 指定的构造器")
        class obclass: tcpprotocol {
            var no1: Int // 局部变量
            required init(no1 : Int) { //(加上"required") 要求协议的遵循者 实现 指定的构造器
                self.no1 = no1// 构造器实现
            }
        }
        let obres = obclass(no1 :10)
        print("obres.no1 is:",obres.no1)
        print(">>>重写了 父类的指定构造器  (加上“override”)")
        class mainClass {
            var no1: Int // 局部变量
            init(no1: Int) {
                self.no1 = no1 // 初始化
            }
        }
        class subClass: mainClass, tcpprotocol { //继承自mainClass的子类，遵循tcpprotocol协议
            var no2: Int
            init(no1: Int, no2 : Int) { //重写构造器
                self.no2 = no2
                super.init(no1:no1)
            }
            // 因为遵循协议，需要加上"required"; 因为继承自父类，需要加上"override"
            required override convenience init(no1: Int)  { //required、override
                self.init(no1:no1, no2:0)
            }
        }
        let showres = mainClass(no1: 20)
        let show = subClass(no1: 30, no2: 50)
        
        print("showres.no1 is: \(showres.no1)")
        print("res.no1 is: \(show.no1)")
        print("res.no2 is: \(show.no2)")
        
        
        print(" 【四】、协议类型") //Generator协议里：关键字associatedtype 实现泛型功能
        var items = [10,20,30].makeIterator()
        while let x = items.next() {
            print(x)
        }
        print("· · · · · · · · ·")
        for lists in [1,2,3].map( {i in i*5}) {
            print(lists)
        }
        print([100,200,300])
        print([1,2,3].map({i in i*10}))
        
        print(" 【五】、在扩展中添加协议成员") //把协议作为类相应实例的成员
        let addProtocPerson = AddProtoclMemberPerson(firstname:"andi", lastname:"das")
        print(addProtocPerson.fullname())
        print(addProtocPerson.agetype())

        print(" 【六】、协议的继承") //在继承的协议基础上增加新的内容要求。
        class Player {
            var stmark: ResultProtoc!
            
            init(stmark: ResultProtoc) {
                self.stmark = stmark
            }
            
            func print(target: aProtoc) {
                stmark.print(target: target)
            }
        }
        var marks = Player(stmark: inheritStudent2())
        var marksec = inheritStudent()
        marks.print(target: marksec)    //初始 target.calc(sum: 1)
        marks.print(target: marksec)
        marks.print(target: marksec)
        marks.stmark = Classb()         //初始 target.calc(sum: 5)
        marks.print(target: marksec)
        marks.print(target: marksec)
        marks.print(target: marksec)
        
        
        print(" 【七】、类专属协议")   //通过添加class关键字,限制协议只能适配到(class)类型。   //????????????????
        //该class关键字必须是第一个出现在协议的继承列表中，其次，才是其他继承协议。
        class MainClass {
            var no1: Int // 局部变量
            init(no1: Int) {
                self.no1 = no1 // 初始化
            }
        }
        class SubClass: MainClass, classdeTcpProtocol { //????????????????
            var no2: Int
            init(no1: Int, no2 : Int) {
                self.no2 = no2
                super.init(no1:no1)
            }
            // 因为遵循协议，需要加上"required"; 因为继承自父类，需要加上"override"
            required override convenience init(no1: Int)  {
                self.init(no1:no1, no2:0)
            }
        }
        let classdeRes = MainClass(no1: 20)
        let classdeShowRes = SubClass(no1: 30, no2: 50)
        print("classdeRes.no1 is: \(classdeRes.no1)")
        print("classdeShowRes.no1 is: \(classdeShowRes.no1)")
        print("classdeShowRes.no2 is: \(classdeShowRes.no2)")
        
        print(" 【八】、协议合成") //合成多个协议， 需要同时遵循多个协议
        struct Person: Stname, Stage {
            var name: String
            var age: Int
        }
        func show(celebrator: Stname & Stage) {
            print("\(celebrator.name) is \(celebrator.age) years old")
        }
        
        let studname = Person(name: "Priya", age: 21)
        print(studname)
        let stud = Person(name: "Rehan", age: 29)
        print(stud)
        let student = Person(name: "Roshan", age: 19)
        print(student)
        
        
        print(" 【九】、检验协议的一致性")
        // 定义了Circle类，都遵循了HasArea协议
        class Circle: HasArea {
            let pi = 3.1415927
            var radius: Double
            var area: Double { return pi * radius * radius }
            init(radius: Double) { self.radius = radius }
        }
        // 定义了Country类，都遵循了HasArea协议
        class Country: HasArea {
            var area: Double
            init(area: Double) { self.area = area }
        }
        // Animal是一个没有实现HasArea协议的类
        class Animal {
            var legs: Int
            init(legs: Int) { self.legs = legs }
        }
        
        let objects: [AnyObject] = [
            Circle(radius: 2.0),
            Country(area: 243_610),
            Animal(legs: 4)
        ]
        for object in objects {
            // 对迭代出的每一个元素进行检查，看它是否遵循了HasArea协议
            if let objectWithArea = object as? HasArea {
                print("面积为 \(objectWithArea.area)")
            } else {
                print("没有面积")
            }
        }
        
        
        
        print("----------------------------")
    }
    
    func extensionUseFunc() {
        print("--------扩展(extension)----------")
        //扩展(extension)  都定义 在文件内，函数外
        
        print(" 【一】、计算型属性: 添加计算型实例属性 或 计算型类型属性")
        let addition = 3.add
        print("加法运算后的值：\(addition)")
        let subtraction = 120.sub
        print("减法运算后的值：\(subtraction)")
        let multiplication = 39.mul
        print("乘法运算后的值：\(multiplication)")
        let division = 55.div
        print("除法运算后的值: \(division)")
        let mix = 30.add + 35.sub
        print("混合运算结果：\(mix)")
        
        
        print(" 【二】、构造器: 向已有类型 添加新的构造器")
        let a = sum(num1: 100, num2: 200)
        let b = diff(no1: 200, no2: 100)
        
        let getMult = mult(x: a, y: b)
        print("getMult sum\(getMult.a.num1, getMult.a.num2)")
        print("getMult diff\(getMult.b.no1, getMult.b.no2)")
        
        
        print(" 【三】、方法: 向已有类型添加新的实例方法和类型方法")
        1.topics(summation: {
            print("打印，在1的扩展模块内")
        })
        3.topics(summation: {
            print("打印，在3的扩展模块内")
        })
        
        print(" 【四】可变实例方法: 可以修改该实例本身(修改 self 或 其属性 的方法必须将实例方法标注为mutating)")
        var Trial1 = 3.3
        Trial1.square()
        print("圆的面积为: \(Trial1)")
        var Trial2 = 5.8
        Trial2.square()
        print("圆的面积为: \(Trial2)")
        var Trial3 = 120.3
        Trial3.square()
        print("圆的面积为: \(Trial3)")
        
        print(" 【五】、下标: 向一个已有类型添加新下标")
        //向int类型，添加新下标  （“subscript(mult: Int) -> Int {”）
        print(12[0]) //该下标[n]返回：除相应的十进制数字的返回值
        print(7869[1])
        print(786543[2])
        
        print(" 【六】、嵌套类型: 向已有的类、结构体和枚举添加新的嵌套类型")
        func result(numb: [Int]) {
            for i in numb {
                switch i.print {    //var print属性 向calc枚举，添加新的嵌套类型
                case .add:
                    print("10")
                case .sub:
                    print("20")
                case .mult:
                    print("30")
                case .div:
                    print("40")
                default:
                    print("50")
                }
            }
        }
        result(numb: [0, 1, 2, 3, 4,5,6])
        
        
        
        print("----------------------------")
    }
    
    func typeTransformFunc() {
        print("--------类型转换----------")
        
        print(" 【一】、定义一个类层次")
        class Subjects {
            var physics: String
            init(physics: String) {
                self.physics = physics
            }
        }
        class Chemistry: Subjects {
            var equations: String
            init(physics: String, equations: String) {
                self.equations = equations
                super.init(physics: physics)
            }
        }
        class Maths: Subjects {
            var formulae: String
            init(physics: String, formulae: String) {
                self.formulae = formulae
                super.init(physics: physics)
            }
        }
        
        let samplechem = Chemistry(physics: "固体物理", equations: "赫兹")
        print("实例物理学是: \(samplechem.physics)")
        print("实例方程式: \(samplechem.equations)")
        let samplemaths = Maths(physics: "流体动力学", formulae: "千兆赫")
        print("实例物理学是: \(samplemaths.physics)")
        print("实例公式是: \(samplemaths.formulae)")
        
        print(" 【二】、检查类型： is关键字")
        let sa = [
            Chemistry(physics: "固体物理", equations: "赫兹"),
            Maths(physics: "流体动力学", formulae: "千兆赫"),
            Chemistry(physics: "热物理学", equations: "分贝"),
            Maths(physics: "天体物理学", formulae: "兆赫"),
            Maths(physics: "微分方程", formulae: "余弦级数")]
        
        var chemCount = 0
        var mathsCount = 0
        for item in sa {
            // 如果是一个 Chemistry 类型的实例，返回 true，相反返回 false。
            if item is Chemistry {
                chemCount += 1
            } else if item is Maths {
                mathsCount += 1
            }
        }
        print("化学科目包含 \(chemCount) 个主题，数学包含 \(mathsCount) 个主题")
        
        
        print(" 【三】、向下转型：用类型转换操作符(as? 或 as!)")
        //当你不确定向下转型可以成功时，用类型转换的条件形式(as?)。条件形式的类型转换总是返回一个可选值（optional value），并且若下转是不可能的，可选值将是 nil。
        //只有你可以确定向下转型一定会成功时，才使用强制形式(as!)。当你试图向下转型为一个不正确的类型时，强制形式的类型转换会触发一个运行时错误。
        for item in sa {
            // 类型转换的 条件形式(as?)
            if let show = item as? Chemistry {
                print("化学主题是: '\(show.physics)', \(show.equations)")
            } else if let example = item as? Maths {
                //不能使用 类型转换的 强制形式(as!)  
                //error：Initializer for conditional binding must have Optional type, not 'Maths'
                print("数学主题是: '\(example.physics)',  \(example.formulae)")
            }
        }
        
        
        print(" 【四】、AnyObject的类型转换：AnyObject可以代表任何class类型的实例。")
        var anyObj_exampleany = [AnyObject]()
        anyObj_exampleany.append(12 as AnyObject) //添加”as AnyObject“
        anyObj_exampleany.append(3.14159 as AnyObject)
        anyObj_exampleany.append("Any 实例" as AnyObject)
        anyObj_exampleany.append(Chemistry(physics: "固体物理", equations: "兆赫"))
        
        for item2 in anyObj_exampleany {
            switch item2 {
            case let someInt as Int:
                print("整型值为 \(someInt)")
            case let someDouble as Double where someDouble > 0:
                print("Pi 值为 \(someDouble)")
            case let someString as String:
                print("\(someString)")
            case let phy as Chemistry:
                print("主题 '\(phy.physics)', \(phy.equations)")
            default:
                print("None")
            }
        }
        
        print(" 【五】、Any的类型转换：Any可以表示任何类型，还包括方法类型（function types）。")
        // 可以存储Any类型的数组 exampleany
        var any_exampleany = [Any]()
        any_exampleany.append(12)
        any_exampleany.append(3.14159)
        any_exampleany.append("字符串 实例")
        any_exampleany.append(Chemistry(physics: "固体物理", equations: "兆赫"))
        
        for item2 in any_exampleany {
            switch item2 {
            case let someInt as Int:
                print("整型值为 \(someInt)")
            case let someDouble as Double where someDouble > 0:
                print("Pi 值为 \(someDouble)")
            case let someString as String:
                print("\(someString)")
            case let phy as Chemistry:
                print("主题 '\(phy.physics)', \(phy.equations)")
            default:
                print("None")
            }
        }
        
        
        
        print("----------------------------")
    }
    
    func seeARCFunc() {
        print("--------自动引用计数（ARC）----------")
        
        class Person {
            let name: String
            init(name: String) {
                self.name = name
                print("\(name) 开始初始化")
            }
            deinit {
                print("\(name) 被析构")
            }
        }
        
        // 值会被自动初始化为nil，目前还不会引用到Person类的实例
        var reference1: Person?
        var reference2: Person?
        var reference3: Person?
        
        // 创建Person类的新实例
        reference1 = Person(name: "fukkkk")
        
        //赋值给其他两个变量，该实例又会多出两个强引用
        reference2 = reference1
        reference3 = reference1
        
        //断开第一个强引用
        reference1 = nil
        //断开第二个强引用
        reference2 = nil
        //断开第三个强引用，并调用 析构函数
        reference3 = nil
        
        
        print(" 【一】、循环强引用")
        class StrongPerson {
            let name: String
            init(name: String) { self.name = name }
            var apartment: Apartment?
            deinit { print("\(name) 被析构") }
        }
        class Apartment {
            let number: Int
            init(number: Int) { self.number = number }
            var tenant: StrongPerson?
            deinit { print("Apartment #\(number) 被析构") }
        }
        // 两个变量都被初始化为nil
        var scc: StrongPerson?
        var number73: Apartment?
        // 赋值
        scc = StrongPerson(name: "scc")
        number73 = Apartment(number: 73)
        
        print("循环强引用被创建")   //感叹号是用来展开和访问可选变量 scc 和 number73 中的实例
        scc!.apartment = number73
        number73!.tenant = scc
        
        // 断开 scc 和 number73 变量所持有的强引用时，引用计数并不会降为 0，实例也不会被 ARC 销毁
        // 注意，当你把这两个变量设为nil时，没有任何一个析构函数被调用。
        // 强引用循环阻止了Person和Apartment类实例的销毁，并在你的应用程序中造成了内存泄漏
        scc = nil       //没有调用 StrongPerson相应的析构函数。
        number73 = nil  //没有调用 Apartment相应的析构函数。
        
        
        print(">>>解决:实例之间的循环强引用")
        print(">>> >>弱引用：weak修饰")
        class Module {
            let name: String
            init(name: String) { self.name = name }
            var sub: SubModule?
            deinit { print("\(name) 主模块") }
        }
        class SubModule {
            let number: Int
            init(number: Int) { self.number = number }
            
            weak var topic: Module?  //弱引用：weak修饰
            deinit { print("子模块 topic 数为 \(number)") }
        }
        var toc: Module?
        var list: SubModule?
        toc = Module(name: "ARC")
        list = SubModule(number: 4)
        toc!.sub = list
        list!.topic = toc

        toc = nil   //调用 Module相应的析构函数。
        list = nil  //调用 SubModule相应的析构函数。
        
        print(">>> >>无主引用实例：仅一个实例对象")
        class Student {
            let name: String
            var section: Marks?
            init(name: String) {
                self.name = name
            }
            
            deinit { print("\(name)") }
        }
        class Marks {
            let marks: Int
            unowned let stname: Student
            init(marks: Int, stname: Student) {
                self.marks = marks
                self.stname = stname
            }
            
            deinit { print("学生的分数为 \(marks)") }
        }
        
        var module: Student?
        module = Student(name: "ARC")
        module!.section = Marks(marks: 98, stname: module!) //无主引用实例
        module = nil //调用 Student相应的析构函数  、 调用 Marks相应的析构函数。
        
        
        
//        print(" 【二】、闭包引起的循环强引用")
//        //范围：类定义之外！
//        class HTMLElement {
//            
//            let name: String
//            let text: String?
//            
//            lazy var asHTML: () -> String = {
//                [unowned self] in
//                if let text = self.text {
//                    return "<\(self.name)>\(text)</\(self.name)>"
//                } else {
//                    return "<\(self.name) />"
//                }
//            }
//            
//            init(name: String, text: String? = nil) {
//                self.name = name
//                self.text = text
//            }
//            
//            deinit {
//                print("\(name) is being deinitialized")
//            }
//        }
//        
//        // 创建实例并打印信息
//        var paragraph: HTMLElement? = HTMLElement(name: "p", text: "hello, world")
//        print(paragraph!.asHTML())
//        
//        // HTMLElement实例将会被销毁，并能看到它的析构函数打印出的消息
//        paragraph = nil
//
//
//        print(" 解决：在闭包上加“[unowned self] in”语句")
//                //范围：类定义之外！
//                class HTMLElement {
//        
//                    let name: String
//                    let text: String?
//        
//                    lazy var asHTML: () -> String = {
//                        [unowned self] in
//                        if let text = self.text {
//                            return "<\(self.name)>\(text)</\(self.name)>"
//                        } else {
//                            return "<\(self.name) />"
//                        }
//                    }
//        
//                    init(name: String, text: String? = nil) {
//                        self.name = name
//                        self.text = text
//                    }
//        
//                    deinit {
//                        print("\(name) is being deinitialized")
//                    }
//                }
//        
//                // 创建实例并打印信息
//                var paragraph: HTMLElement? = HTMLElement(name: "p", text: "hello, world")
//                print(paragraph!.asHTML())
//                
//                // HTMLElement实例将会被销毁，并能看到它的析构函数打印出的消息
//                paragraph = nil
//
//        
//        print("查看效果：playground里使用、活参考笔记")
        
        
        
        
        print("----------------------------")
    }
    
    
    
    func OptionalChainingFunc() {
        print("--------可选链（Optional Chaining）----------")
        
        
        class Human {
            var charact: SCharact?
        }
        
        class SCharact {
            var numberOfRooms = 1
        }
        let human = Human()
        
        //【一】、链接可选“residence!”属性
        //print(" 【一】、使用感叹号(!)可选链实例")
//        let roomCount = john.residence!.numberOfRooms
//        //将导致运行时错误：没有可以供解析的residence值
//        //(fatal error: unexpectedly found nil while unwrapping an Optional value)
        
        //【二】、链接可选“residence?”属性，如果residence存在则取回numberOfRooms的值
        print(" 【二】、使用问号(?)可选链实例")
        if let roomCount = human.charact?.numberOfRooms {
            print("John 的房间号为 \(roomCount)。")
        } else {
            print("不能查看房间号") //human.charact为nil
        }
        
        
        
        print(" 【三】、为可选链定义模型类")
        class Person {
            var residence: Residence?
        }
        // 定义了一个变量 rooms，它被初始化为一个Room[]类型的空数组
        class Residence {
            var rooms = [Room]()
            var numberOfRooms: Int {
                return rooms.count
            }
            subscript(i: Int) -> Room {
                return rooms[i]
            }
            func printNumberOfRooms() {
                print("房间号为 \(numberOfRooms)")
            }
            var address: Address?
        }
        // Room 定义一个name属性和一个设定room名的初始化器
        class Room {
            let name: String
            init(name: String) { self.name = name }
        }
        
        // 模型中的最终类叫做Address
        class Address {
            var buildingName: String?
            var buildingNumber: String?
            var street: String?
            func buildingIdentifier() -> String? {
                if (buildingName != nil) {
                    return buildingName
                } else if (buildingNumber != nil) {
                    return buildingNumber
                } else {
                    return nil
                }
            }
        }
        print(">>>通过可选链调用 方法")
        let john = Person()
        if ((john.residence?.printNumberOfRooms()) != nil) {
            print("输出房间号")
        } else {
            print("无法输出房间号") //john.residence为nil
        }
        print(">>>通过可选链调用 下标脚本") //使用可选链，来尝试从下标脚本获取值并检查下标脚本的调用是否成功
        if let firstRoomName = john.residence?[0].name {
            print("第一个房间名 \(firstRoomName).")
        } else {
            print("无法检索到房间")
        }
        
        
        let fuck = Person()
        let fucksHouse = Residence()
        fuck.residence = fucksHouse
        
        let fucksAddress = Address()
        fucksAddress.buildingName = "The Larches"
        fucksAddress.street = "Laurel Street"
        fuck.residence!.address = fucksAddress
        if let fucksStreet = fuck.residence?.address?.street {
            print("fuck 所在的街道是 \(fucksStreet)。")
        } else {
            print("无法检索到街道。 ")
        }
        
        print(">>> >>访问下标:通过可选链接的调用")
        fucksHouse.rooms.append(Room(name: "客厅"))
        fucksHouse.rooms.append(Room(name: "厨房"))
        //使用可选链通过Residence下标脚本来获取在rooms数组中的实例
        if let firstRoomName = fuck.residence?[0].name {
            print("第一个房间名为\(firstRoomName)")
        } else {
            print("无法检索到房间")
        }
        print(">>> >>访问可选类型的下标")
        var testScores = ["Dave": [86, 82, 84], "Bev": [79, 94, 81]]
        testScores["Dave"]?[0] = 91
        testScores["Bev"]?[0] += (testScores["Bev"]?[0])! //自增  （++ 已废除）
        testScores["Brian"]?[0] = 72 //无效
        print(testScores)
        
        
        print(" 【四】、连接多层链接")
        print(">>>两层可选链来联系residence和address属性")
        if let johnsStreet = john.residence?.address?.street {
            print("John 的地址为 \(johnsStreet).")
        } else {
            print("不能检索街道")
        }
        
        
        print(">>>为address的street属性设定一个实际值   (john.residence.address的值)")
        class NewPerson {
            var residence: NewResidence?
        }
        class NewResidence {
            
            var rooms = [NewRoom]()
            var numberOfRooms: Int {
                return rooms.count
            }
            subscript(i: Int) -> NewRoom {
                get{
                    return rooms[i]
                }
                set {
                    rooms[i] = newValue
                }
            }
            func printNumberOfRooms() {
                print("房间号为 \(numberOfRooms)")
            }
            var address: Address?
        }
        class NewRoom {
            let name: String
            init(name: String) { self.name = name }
        }
        class NewAddress {
            var buildingName: String?
            var buildingNumber: String?
            var street: String?
            func buildingIdentifier() -> String? {
                if (buildingName != nil) {
                    return buildingName
                } else if (buildingNumber != nil) {
                    return buildingNumber
                } else {
                    return nil
                }
            }
        }
        
        let newFuck = NewPerson()
        newFuck.residence?[0] = NewRoom(name: "浴室")
        if let newFuckFirstRoomName = newFuck.residence?[0].name {
            print("第一个房间是\(newFuckFirstRoomName)")
        } else {
            print("无法检索房间")
        }
        let newFucksHouse = NewResidence()
        newFucksHouse.rooms.append(NewRoom(name: "客厅"))
        newFucksHouse.rooms.append(NewRoom(name: "厨房"))
        newFuck.residence = newFucksHouse
        if let newFuckFirstRoomName = newFuck.residence?[0].name {
            print("第一个房间是\(newFuckFirstRoomName)")
        } else {
            print("无法检索房间")
        }
        
        print(" 【五】、方法调用：对返回可选值的函数进行链接")
        let j7 = Person()
        if j7.residence?.printNumberOfRooms() != nil {
            print("指定了房间号")
        }  else {
            print("未指定房间号")
        }
        let j7sHouse = Residence()
        j7.residence = j7sHouse //j7.residence存在，会执行printNumberOfRooms()方法
        if j7.residence?.printNumberOfRooms() != nil {
            print("指定了房间号")
        }  else {
            print("未指定房间号")
        }
        
        
        
        print("----------------------------")
    }
    
    func deinitializerFunc() {
        print("--------析构器的使用----------")

        
        class BaseClass {
            var counter = 0;  // 引用计数器
            
            init() {
                counter += 1;
            }
            deinit {
                counter -= 1;
            }
        }
        var show: BaseClass? = BaseClass()
        print(show?.counter ?? "不存在")
        show = nil
        print(show?.counter)
        print(show?.counter ?? "不存在")
        
        
        
        //范围：类定义之外！
////        var quetoCounter = 0;  // 引用计数器
////        class BaseClass {
////            init() {
////                quetoCounter += 1;
////            }
////            
////            deinit { // 执行析构过程
////                quetoCounter -= 1;
////            }
////        }
////        
////        var show: BaseClass? = BaseClass()
////        print(quetoCounter)
////        show = nil //执行deinit方法：计算器减去 1，show 占用的内存就会释放
////        print(quetoCounter)
////        
//        print("查看效果：playground里使用")
        
        
        
        
        print("----------------------------")
    }
    
    func initializerFunc() {
        print("--------构造器的使用----------")
        
        print(" 【一】、构造器:init()") //构造器:init()
        //可以(1).在构造器中为存储型属性设置初始值；同样，也可以(2).在属性声明时为其设置默认值。
        print("   (1).构造器中，设置初始值")
        struct firRectangle {
            var length: Double
            var breadth: Double
            init() {
                //(1).构造器中为存储型属性设置初始值。
                length = 6
                breadth = 12
            }
        }
        var firArea = firRectangle()
        print("矩形面积为 \(firArea.length*firArea.breadth)")
        print("   (2).默认属性值")
        struct secRectangle {
            //(2).在属性声明时为其设置默认值
            var length = 6  // 设置默认值
            var breadth = 12// 设置默认值
        }
        var secArea = secRectangle()
        print("矩形的面积为 \(secArea.length*secArea.breadth)")
        
        
        print(" 【二】、构造参数：定义构造器 init() 时，提供构造参数")
        struct thiRectangle {
            var length: Double
            var breadth: Double
            var area: Double
            
            init(fromLength length: Double, fromBreadth breadth: Double) { //构造参数：fromLength、fromBreadth
                self.length = length
                self.breadth = breadth
                area = length * breadth
            }
            init(fromLeng leng: Double, fromBread bread: Double) {          //构造参数：fromLength、fromBread
                self.length = leng
                self.breadth = bread
                area = leng * bread
            }
        }
        let ar = thiRectangle(fromLength: 6, fromBreadth: 12)  //构造参数：fromLength、fromBreadth
        print("面积为: \(ar.area)")
        let are = thiRectangle(fromLeng: 36, fromBread: 12)    //构造参数：fromLength、fromBread
        print("面积为: \(are.area)")
        
        print(" 【三】、外部参数：使用外部参数名来传值，并调用构造器")
        struct Color {
            let red, green, blue: Double
            init(red: Double, green: Double, blue: Double) {
                self.red   = red
                self.green = green
                self.blue  = blue
            }
            init(white: Double) {
                red   = white
                green = white
                blue  = white
            }
        }
        // 创建一个新的Color实例，通过三种颜色的外部参数名来传值，并调用构造器
        let magenta = Color(red: 1.0, green: 0.0, blue: 1.0)
        print("red 值为: \(magenta.red)")
        print("green 值为: \(magenta.green)")
        print("blue 值为: \(magenta.blue)")
        // 创建一个新的Color实例，通过三种颜色的外部参数名来传值，并调用构造器
        let halfGray = Color(white: 0.5)
        print("red 值为: \(halfGray.red)")
        print("green 值为: \(halfGray.green)")
        print("blue 值为: \(halfGray.blue)")
        
        print(" 【四】、没有外部名称参数：下划线”_“来描述")//不希望为构造器的某个参数提供外部名字，可使用下划线"_"来显示描述它的外部名。
        struct fouRectangle {
            var length: Double
            
            init(frombreadth breadth: Double) {
                length = breadth * 10
            }
            init(frombre bre: Double) {
                length = bre * 30
            }
            //不提供外部名字  使用下划线"_"来显示描述它的外部名。
            init(_ area: Double) {
                length = area
            }
        }
        // 调用提供外部名字
        let breadrectArea = fouRectangle(frombreadth: 180.0)
        print("调用提供外部名字","面积为: \(breadrectArea.length)")
        // 调用提供外部名字
        let brereArea = fouRectangle(frombre: 370.0)
        print("调用提供外部名字","面积为: \(brereArea.length)")
        print("· · · · · · · · · · · · ·")
        // 调用不提供外部名字
        let rectArea = fouRectangle(180.0)
        print("没有外部名称参数","面积为: \(rectArea.length)")
        // 调用不提供外部名字
        let reArea = fouRectangle(370.0)
        print("没有外部名称参数","面积为: \(reArea.length)")
        // 调用不提供外部名字
        let recArea = fouRectangle(110.0)
        print("没有外部名称参数","面积为: \(recArea.length)")
        
        print(" 【五】、可选属性类型:optional type：使用“?”") //逻辑上允许取值为空的存储型属性
        struct optionalTypeRectangle {
            var length: Double?
            
            init(frombreadth breadth: Double) {
                length = breadth * 10
            }
            init(frombre bre: Double) {
                length = bre * 30
            }
            init(_ area: Double) {
                length = area
            }
        }
        let optionalRectarea = optionalTypeRectangle(180.0)
        print("面积为：\(String(describing: optionalRectarea.length))")
        let optionalRearea = optionalTypeRectangle(370.0) //可选类型，必须 对应“String(describing: )”方法
        print("面积为：\(optionalRearea.length)")
        let optionalRecarea = optionalTypeRectangle(110.0)
        print("面积为：\(optionalRecarea.length)")
        
        
        print(" 【六】、默认构造器：所有属性值都设置为默认值")
        class ShoppingListItem {
            var name: String?
            var quantity = 1
            var purchased = false
        }
        var item = ShoppingListItem()
        print("名字为: \(item.name)")
        print("数理为: \(item.quantity)")
        print("是否付款: \(item.purchased)")
        
        print(" 【七】、逐一成员构造器")
        //结构体对(1).所有存储型属性提供了默认值 且 自身(2.)没有提供定制的构造器，它们能自动获得一个逐一成员构造器
        struct Rectangle {
            var length = 100.0, breadth = 200.0
        }
        let area = Rectangle(length: 24.0, breadth: 32.0)
        //结构体Rectangle 自动获得了一个逐一成员构造器“init(width:height:)”
        print("矩形: \(area.length)")
        print("矩形: \(area.breadth)")
        
        
        print()
        print(" 【八】、值类型的构造器代理：通过调用其它构造器来完成实例的部分构造过程")
        struct Size {
            var width = 0.0, height = 0.0
        }
        struct Point {
            var x = 0.0, y = 0.0
        }
        
        struct Rect {
            var origin = Point()
            var size = Size()
            init() {}
            init(origin: Point, size: Size) {
                self.origin = origin
                self.size = size
            }
            init(center: Point, size: Size) {
                let originX = center.x - (size.width / 2)
                let originY = center.y - (size.height / 2)
                self.init(origin: Point(x: originX, y: originY), size: size)
            }
        }
        
        // origin和size属性都使用定义时的默认值Point(x: 0.0, y: 0.0)和Size(width: 0.0, height: 0.0)
        let basicRect = Rect()
        print("Size 结构体初始值: \(basicRect.size.width, basicRect.size.height) ")
        print("Rect 结构体初始值: \(basicRect.origin.x, basicRect.origin.y) ")
        
        // 将origin和size的参数值赋给对应的存储型属性
        let originRect = Rect(origin: Point(x: 2.0, y: 2.0),
                              size: Size(width: 5.0, height: 5.0))
        print("Size 结构体初始值: \(originRect.size.width, originRect.size.height) ")
        print("Rect 结构体初始值: \(originRect.origin.x, originRect.origin.y) ")
        
        //先通过center和size的值计算出origin的坐标。
        //然后再调用（或代理给）init(origin:size:)构造器来将新的origin和size值赋值到对应的属性中
        let centerRect = Rect(center: Point(x: 4.0, y: 4.0),
                              size: Size(width: 3.0, height: 3.0))
        print("Size 结构体初始值: \(centerRect.size.width, centerRect.size.height) ")
        print("Rect 结构体初始值: \(centerRect.origin.x, centerRect.origin.y) ")
        
        print(" 【九】、指定构造器")
        //初始化类中提供的所有属性，并根据父类链往上调用父类的构造器来实现父类的初始化。
        class mainClass {
            var no1 : Int // 局部存储变量
            init(no1 : Int) {
                self.no1 = no1 // 初始化
            }
        }
        class subClass : mainClass {
            var no2 : Int // 新的子类存储变量
            init(no1 : Int, no2 : Int) {
                self.no2 = no2 // 初始化
                super.init(no1:no1) // 初始化超类   （⭐️⭐️⭐️⭐️⭐️父类链⭐️⭐️⭐️⭐️⭐️）
            }
        }
        let res = mainClass(no1: 10)
        let res2 = subClass(no1: 10, no2: 20)
        print("res 为: \(res.no1)")
        print("res2 为: \(res2.no1)")
        print("res2 为: \(res2.no2)")
        
        print(" 【十】、便利构造器：封装一层构造器")
        //可以定义便利构造器来调用 同一个类中的指定构造器，并为其参数提供默认值。
        //也可以定义便利构造器来创建一个特殊用途或特定输入的实例。
        class convenienceMainClass {
            var no1 : Int // 局部存储变量
            init(no1 : Int) {
                self.no1 = no1 // 初始化
            }
        }
        class convenienceSubClass : mainClass {
            var no2 : Int
            init(no1 : Int, no2 : Int) {
                self.no2 = no2
                super.init(no1:no1) // 初始化超类   （⭐️⭐️⭐️⭐️⭐️父类链⭐️⭐️⭐️⭐️⭐️）
            }
            // 便利方法只需要一个参数
            override convenience init(no1: Int)  {
                self.init(no1:no1, no2:0)
            }
        }
        let convenience_res = convenienceMainClass(no1: 20)
        let convenience_res2 = convenienceSubClass(no1: 30, no2: 50)
        print("res的no1 为: \(convenience_res.no1)")
        print("res2的no1 为: \(convenience_res2.no1)")
        print("res2的no2 为: \(convenience_res2.no2)")
        let conv_res = convenienceSubClass(no1: 20) //便利构造器 (只需要一个参数)
        print("conv_res的no1 为: \(conv_res.no1)")
        print("conv_res的no2 为: \(conv_res.no2)")
        
        print(" 【十一】、构造器的继承和重载")
        //子类不会默认继承父类的构造器。父类的构造器仅在确定和安全的情况下被继承。
        //重写一个父类指定构造器时，需要写override修饰符。
        class inheritSuperClass {
            var corners = 4
            var description: String {
                return "\(corners) 边"
            }
        }
        let rectangle = inheritSuperClass()
        print("矩形: \(rectangle.description)")
        
        class inheritSubClass: inheritSuperClass { //继承自父类
            override init() {  //重载构造器
                super.init() // 初始化超类   （⭐️⭐️⭐️⭐️⭐️父类链⭐️⭐️⭐️⭐️⭐️）
                corners = 5
            }
        }
        let inherSubClass = inheritSubClass()
        print("五角型: \(inherSubClass.description)")
        
        
        class MainClass {
            var name: String
            
            init(name: String) {    //指定构造器
                self.name = name
            }
            convenience init() {    //便利构造器
                self.init(name: "[匿名]")
            }
        }
        let main = MainClass(name: "fuk")   //指定构造器
        print("MainClass 名字为: \(main.name)")
        let main2 = MainClass()             //便利构造器
        print("没有对应名字: \(main2.name)")
        
        class SubClass: MainClass {
            var count: Int
            init(name: String, count: Int) {
                self.count = count
                super.init(name: name)
            }
            override convenience init(name: String) {//便利构造器
                self.init(name: name, count: 1)
            }
        }
        let sub = SubClass(name: "fuk")
        print("MainClass 名字为: \(sub.name)")
        let sub2 = SubClass(name: "fuk", count: 3)
        print("count 变量: \(sub2.count)")
        let sub3 = SubClass(name: "sd") //便利构造器
        print("count 变量: \(sub3.count)")
        
        print()
        print(" 【十二】、类的可失败构造器：一个类，结构体或枚举类型的对象，构造自身的过程中有可能失败")
        struct Animal {
            let species: String
            init?(species: String) {
                if species.isEmpty { return nil }
                self.species = species
            }
        }
        //通过该可失败构造器来构建一个Animal的对象，并检查其构建过程是否成功
        // someCreature 的类型是 Animal? ，而不是 Animal
        let someCreature = Animal(species: "长颈鹿")
        // 打印 "动物初始化为长颈鹿"
        if let giraffe = someCreature {
            print("动物初始化为\(giraffe.species)")
        }
        
        print(" 【十三】、枚举类型的可失败构造器")
        enum TemperatureUnit {
            // 开尔文，摄氏，华氏
            case Kelvin, Celsius, Fahrenheit
            init?(symbol: Character) {
                switch symbol {
                case "K":
                    self = .Kelvin
                case "C":
                    self = .Celsius
                case "F":
                    self = .Fahrenheit
                default:
                    return nil
                }
            }
        }
        let fahrenheitUnit = TemperatureUnit(symbol: "F")
        if fahrenheitUnit != nil {
            print("这是一个已定义的温度单位，所以初始化成功。",fahrenheitUnit)
        }
        let unknownUnit = TemperatureUnit(symbol: "X")
        if unknownUnit == nil {
            print("这不是一个已定义的温度单位，所以初始化失败。",unknownUnit)
        }
        
        print(" 【十四】、覆盖 可失败构造器")
        class Planet {
            var name: String
            
            init(name: String) {
                self.name = name
            }
            convenience init() {
                self.init(name: "[No Planets]")
            }
        }
        let plName = Planet(name: "Mercury")
        print("行星的名字是: \(plName.name)")
        let noplName = Planet()
        print("没有这个名字的行星: \(noplName.name)")
        
        class planets: Planet {
            var count: Int
            
            init(name: String, count: Int) {
                self.count = count
                super.init(name: name)
            }
            override convenience init(name: String) {
                self.init(name: name, count: 1)
            }
        }
        
        print(" 【十五】、可失败构造器 init! (与“init?”相同)")
        struct StudRecord {
            let stname: String
            
            init!(stname: String) {
                if stname.isEmpty {return nil }
                self.stname = stname
            }
        }
        let stmark = StudRecord(stname: "fk")
        if let name = stmark {
            print("指定了学生名")
        }
        let blankname = StudRecord(stname: "")
        if blankname == nil {
            print("学生名为空")    
        }
        
        
        
        print("----------------------------")
    }
    
    func subscriptUseFunc() {
        print("--------下标脚本(subscript)的使用----------")
        
        print(" 【一】、结构体 使用下标脚本")
        struct subexample { //通过 subexample结构体，创建了一个除法运算的实例
            let decrementer: Int
            subscript(index: Int) -> Int {
                return decrementer / index
            }
        }
        let division = subexample(decrementer: 100)
        print("100 除以 9 等于 \(division[9])") //division[9] 即为 100除以9
        print("100 除以 2 等于 \(division[2])")
        print("100 除以 3 等于 \(division[3])")
        print("100 除以 5 等于 \(division[5])")
        print("100 除以 7 等于 \(division[7])")
        
        print(" 【二】、数组 使用下标脚本")
        class daysofaweek {
            private var days = ["Sunday", "Monday", "Tuesday", "Wednesday",
                                "Thursday", "Friday", "saturday"]
            subscript(index: Int) -> String {
                get {
                    return days[index]   // 声明下标脚本的值
                }
                set(newValue) {
                    self.days[index] = newValue   // 执行赋值操作
                }
            }
        }
        var p = daysofaweek()
        print(p[0])
        print(p[1])
        print(p[2])
        print(p[3])
        
        print(" 【三】、字典 使用下标脚本")//字典 实现了通过下标脚本对其实例中存放的值进行存取操作。
        var numberOfLegs = ["spider": 8, "ant": 6, "cat": 4]
        numberOfLegs["bird"] = 2
        print(numberOfLegs)
        
        
        print()
        struct Matrix {
            let rows: Int, columns: Int
            var show: [Double]
            init(rows: Int, columns: Int) {
                self.rows = rows
                self.columns = columns
                show = Array(repeating: 0.0, count: rows * columns)
                //创建了一个足够容纳rows * columns个数的Double类型数组。 数组的大小和数组每个元素初始值0.0。
            }
            subscript(row: Int, column: Int) -> Double {
                get {
                    return show[(row * columns) + column]
                }
                set {
                    show[(row * columns) + column] = newValue
                }
            }
        }
        // 创建了一个新的 3 行 3 列的Matrix实例
        var mat = Matrix(rows: 3, columns: 3)
        
        // 通过下标脚本设置值
        mat[0,0] = 1.0
        mat[0,1] = 2.0
        mat[1,0] = 3.0
        mat[1,1] = 5.0
        // 通过下标脚本获取值
        print("\(mat[0,0])")
        print("\(mat[0,1])")
        print("\(mat[1,0])")
        print("\(mat[1,1])")
        
        
        
        print("----------------------------")
    }
    
    func methodUseFunc() {
        print("--------方法(method)的使用----------")
        
        print(">>>>> 实例方法") //(1).可以访问和修改实例属性;(2).提供与实例目的相关的功能
        class Counter {
            var count = 0
            func increment() {
                count += 1
            }
            func incrementBy(amount: Int) {
                count += amount
            }
            func reset() {
                count = 0
            }
        }
        let counter = Counter()// 初始计数值是0
        
        counter.increment() // 计数值现在是1
        print(counter.count)
        counter.incrementBy(amount: 5)// 计数值现在是6
        print(counter.count)
        counter.reset()     // 计数值现在是0
        print(counter.count)
        
        
        print("局部参数 和 外部参数")
        //Swift 默认仅给方法的第一个参数名称一个局部参数名称;默认同时给第二个和后续的参数名称为全局参数名称。
        class division {
            var count: Int = 0
            func incrementBy(no1: Int, no2: Int) {
                count = no1 / no2
                print(count)
            }
        }
        
        let divi = division()
        divi.incrementBy(no1: 1800, no2: 3)
        divi.incrementBy(no1: 1600, no2: 5)
        divi.incrementBy(no1: 11000, no2: 3)
       
        print("是否提供外部名称设置")
        //(1).以第一个标识符为准(first)；
        //(2).有下划线(_)，后续的参数无需提供外部名称
        class multiplication {
            var count: Int = 0
            func incrementBy(first no1: Int,_ no2: Int) {
                count = no1 * no2
                print(count)
            }
        }
        
        let multi = multiplication()
        multi.incrementBy(first: 800, 3)
        multi.incrementBy(first: 100, 5)
        multi.incrementBy(first: 15000, 3)
        
        
        print(" 【一】、self 属性")
        class calculations {
            let a: Int
            let b: Int
            let res: Int
            
            init(a: Int, b: Int) {
                self.a = a
                self.b = b
                res = a + b
                print("Self 内: \(res)")
            }
            
            func tot(c: Int) -> Int {
                return res - c
            }
            func result() {
                print("结果为: \(tot(c: 20))")
                print("结果为: \(tot(c: 50))")
            }
        }
        
        let pri = calculations(a: 600, b: 300)
        let sum = calculations(a: 1200, b: 300)
        pri.result()
        sum.result()
        
        
        print(" 【二】、实例方法中修改值类型   变异(mutating)") //变异(mutating)相应的方法
        struct area {
            var length = 1
            var breadth = 1
            
            func area() -> Int {
                return length * breadth
            }
            mutating func scaleBy(res: Int) { //变异(mutating)这个方法
                length *= res
                breadth *= res
                print(length)
                print(breadth)
            }
        }
        
        var val = area(length: 3, breadth: 5)
        val.scaleBy(res: 3)
        val.scaleBy(res: 30)
        val.scaleBy(res: 300)
        
        print(" 【三】、在可变方法中给 self 赋值   变异(mutating)") //变异(mutating)对应的方法
        struct rectArea {
            var length = 1
            var breadth = 1
            
            func area() -> Int {
                return length * breadth
            }
            mutating func scaleBy(res: Int) { //变异(mutating)这个方法
                self.length *= res
                self.breadth *= res
                print(length)
                print(breadth)
            }
        }
        var ar = rectArea(length: 3, breadth: 5)
        ar.scaleBy(res: 13)
        
        
        print()
        print(">>>>> 类型方法")
        class Math { //类的类型方法
            class func abs(number: Int) -> Int
            {
                if number < 0
                {
                    return (-number)
                } else {
                    return number
                }
            }
        }
        
        struct absno { //结构体的类型方法
            static func abs(number: Int) -> Int //结构体、枚举的类型方法，在方法的func关键字之前加上关键字static。
            {
                if number < 0
                {
                    return (-number)
                } else {
                    return number
                }
            }
        }
        let no = Math.abs(number: -35)
        let num = absno.abs(number: -5)
        
        print("类的类型方法",no)
        print("结构体的类型方法",num)
        
        
        
        print("----------------------------")
    }
    
    func propertyUseFunc() {
        print("--------属性(property)的使用----------")
        print(" 【一】、存储属性")
        struct Number {
            var digits: Int
            let pi = 3.1415
        }
        var n = Number(digits: 12345)
        n.digits = 67
        //        n.pi = 8.7 // 'pi' 是一个常量，你不能修改它。
        print("\(n.digits)")
        print("\(n.pi)")
        
        print(" 【二】、延迟 存储属性") //一般用于：(1).延迟对象的创建; (2).当属性的值依赖于其他未知类
        class sample {
            lazy var no = number() // `var` 关键字是必须的
        }
        class number {
            var name = "Fuck Swift 阿西吧"
        }
        var firstsample = sample()
        print(firstsample.no.name)
        
        
        print()
        print(" 【三】、计算属性")
        class calculate {
            var no1 = 0.0, no2 = 0.0
            var length = 300.0, breadth = 150.0
            
            var middle: (Double, Double) {
                get{        // getter 来获取值
                    return (length / 2, breadth / 2)
                }
                
                set(axis){  // setter 来间接设置其他属性或变量的值
                    no1 = axis.0 - (length / 2)
                    no2 = axis.1 - (breadth / 2)
                }
            }
        }
        var result = calculate()
        
        print(result.middle) //getter 来获取值
        
        result.middle = (0.0, 10.0) //setter 来间接设置其他属性或变量的值
        print("calculate.no1:",result.no1)
        print("calculate.no2:",result.no2)
        
        
        print(" 【四】、只读计算属性") //只有getter,没有setter 的计算属性就是只读计算属性。
        class film {
            var head = ""
            var duration = 0.0
            var metaInfo: [String:String] {
                return [
                    "head": self.head,
                    "duration":"\(self.duration)"
                ]
            }
        }
        var movie = film()
        movie.head = "Swift 版本"
        movie.duration = 3.09
        print(movie.metaInfo["head"]!)
        print(movie.metaInfo["duration"]!)
        
        
        print()
        print(" 【五】、属性观察器  willSet、didSet")
        class Samplepgm {
            var counter: Int = 0{
                willSet(newTotal){
                    print("计数器: \(newTotal)")
                }
                didSet{
                    if counter > oldValue {
                        print("新增数 \(counter - oldValue)")
                    }
                }
            }
        }
        let NewCounter = Samplepgm()
        NewCounter.counter = 100
        NewCounter.counter = 800
        
        
        print()
        print(" 【六】、获取和设置 类型属性的值")
        struct StudMarks {
            static let markCount = 97
            static var totalCount = 0
            var InternalMarks: Int = 0 { //类型属性 作为类型定义的一部分写在类型最外层的花括号({ })内
                didSet {
                    if InternalMarks > StudMarks.markCount {
                        InternalMarks = StudMarks.markCount
                    }
                    if InternalMarks > StudMarks.totalCount {
                        StudMarks.totalCount = InternalMarks
                    }
                }
            }
        }
        var stud1Mark1 = StudMarks()
        var stud1Mark2 = StudMarks()
        
        stud1Mark1.InternalMarks = 98
        print(stud1Mark1.InternalMarks)
        stud1Mark2.InternalMarks = 87
        print(stud1Mark2.InternalMarks)
        
        
        
        print("----------------------------")
    }
    
    
    func classIntroduceFunc() {
        print("--------类的介绍(class)----------")
        
        print(" 【一】、基类:没有继承其它类的类，称之为基类（Base Class）")
        class StudDetails {
            var stname: String!
            var mark1: Int!
            var mark2: Int!
            var mark3: Int!
            init(stname: String, mark1: Int, mark2: Int, mark3: Int) {
                self.stname = stname
                self.mark1 = mark1
                self.mark2 = mark2
                self.mark3 = mark3
            }
        }
        let stname = "swift"
        let mark1 = 98
        let mark2 = 89
        let mark3 = 76
        
        let sds = StudDetails(stname:stname, mark1:mark1, mark2:mark2, mark3:mark3);
        
        print(sds.stname)
        print(sds.mark1)
        print(sds.mark2)
        print(sds.mark3)
        
        
        print(" 【二】、子类:指的是在一个已有类的基础上创建一个新的类")
        class StudentDetails {
            var mark1: Int;
            var mark2: Int;
            
            init(stm1:Int, results stm2:Int) {
                mark1 = stm1;
                mark2 = stm2;
            }
            
            func show() {
                print("Mark1:\(self.mark1), Mark2:\(self.mark2)")
            }
        }
        
        class Tom : StudentDetails {
            init() {
                super.init(stm1: 93, results: 89)
            }
        }
        let tom = Tom()
        tom.show()
        
        
        print()
        print(" 【三】、重写方法:使用 override关键字来重写超类的方法")
        class SuperClass {
            func show() {
                print("这是超类 SuperClass")
            }
        }
        class SubClass: SuperClass  {
            override func show() { //override 关键字来重写超类的方法
                print("这是子类 SubClass")
            }
        }
        let superClass = SuperClass()
        superClass.show()
        let subClass = SubClass()
        subClass.show()
        
        print(" 【四】、重写属性")
        class Circle {
            var radius = 12.5
            var area: String {
                return "矩形半径 \(radius) "
            }
        }
        // 继承超类 Circle
        class Rectangle: Circle {
            var pridd = 7 //初始值
            override var area: String { //使用 override关键字
                return super.area + " ，但现在被重写为 \(pridd)"
            }
        }
        let rect = Rectangle()
        rect.radius = 25.0
        rect.pridd = 3   //被重写
        print("Radius \(rect.area)")
        
        print(" 【五】、重写属性观察器")
        class CircleObserv {
            var radius = 12.5
            var area: String {
                return "矩形半径为 \(radius) "
            }
        }
        class RectangleObserv: CircleObserv {
            var print = 7
            override var area: String {
                return super.area + " ，但现在被重写为 \(print)"
            }
        }
        let rect_observ = RectangleObserv()
        rect_observ.radius = 25.0
        rect_observ.print = 3
        print("半径: \(rect.area)")
        
        class Square: RectangleObserv {
            override var radius: Double {
                didSet { //属性观察器
                    print = Int(radius/5.0)+1
                }
            }
        }
        let sq_observ = Square()
        sq_observ.radius = 100.0
        print("半径: \(sq_observ.area)")
        
        print()
        print(" 【六】、防止重写:使用final关键字防止它们被重写") //重写了final方法，属性或下标脚本，在编译时会报错。
//        final class CircleFinal {
//            final var radius = 12.5
//            var area: String {
//                return "矩形半径为 \(radius) "
//            }
//        }
//        //使用之后不能重写
//        class RectangleFinal: CircleFinal { //error: inheritance from a final class 'CircleFinal'
//            var pridd = 7
//            override var area: String { //error: var overrides a 'final' var
//                return super.area + " ，但现在被重写为 \(pridd)"
//            }
//        }
//        let rectFinal = RectangleFinal()
//        rectFinal.radius = 25.0
//        rectFinal.pridd = 3
//        print("半径: \(rectFinal.area)")
//        
//        class Sqtte: RectangleFinal {
//            override var radius: Double { //error: var overrides a 'final' var
//                didSet {
//                    pridd = Int(radius/5.0)+1
//                }
//            }
//        }
//        let sq = Sqtte()
//        sq.radius = 100.0
//        print("半径: \(sq.area)")
        
        
        
        print("----------------------------")
    }
    
    func classUseFunc() {
        print("--------类(class)的使用----------")
        
        class MarksStruct {
            var mark: Int
            init(mark: Int) {//实例化时，填写 属性
                self.mark = mark
            }
        }
        let markStruct = MarksStruct(mark: 250)
        print("实例化时，填写好成绩为 \(markStruct.mark)")
        
        class studentMarks {//已经定义好了 属性
            var mark = 300
        }
        let studMarks = studentMarks()
        print("成绩为 \(studMarks.mark)")
        class blablaMarks { //已经定义好了 属性
            var mark1 = 300
            var mark2 = 400
            var mark3 = 900
        }
        let blaMarks = blablaMarks()
        print("Mark1 is \(blaMarks.mark1)")
        print("Mark2 is \(blaMarks.mark2)")
        print("Mark3 is \(blaMarks.mark3)")
        
        print()
        print(">>>恒等运算符")
        class SampleClass {
            let myProperty: String
            init(s: String) {
                myProperty = s
            }
        }
    
        let spClass1 = SampleClass(s: "Hello")
        let spClass2 = SampleClass(s: "Hello")
//        if spClass1 === spClass1 {// true
//            print("引用相同的类实例 \(spClass1)")
//        }
        if spClass1 === spClass2 {// false
            print("引用相同的类实例 \(spClass1)")
        }
        if spClass1 !== spClass2 {// true
            print("引用不相同的类实例 \(spClass2)")
        }
        
        
        
        print("----------------------------")
    }
    
    
    func structUseFunc() {
        print("--------结构体(struct)的使用----------")
        
        struct studentMarks {
            var mark1 = 100
            var mark2 = 78
            var mark3 = 98
        }
        let marks = studentMarks()
        print("Mark1 是 \(marks.mark1)")//通过”.号“来访问结构体成员的值
        print("Mark2 是 \(marks.mark2)")
        print("Mark3 是 \(marks.mark3)")
        
        print()
        struct MarksStruct {
            var mark: Int
            
            init(mark: Int) {
                self.mark = mark
            }
        }
        var aStruct = MarksStruct(mark: 98) //结构体实例化时传值
        var bStruct = aStruct //克隆一个结构体     （aStruct和bStruct 是使用相同值的结构体！）
        bStruct.mark = 97
        print("mark",aStruct.mark) // 98
        print("克隆的结构体","mark",bStruct.mark) // 97
        
        print()
        print("结构体实例是通过值传递，而不是通过引用传递。")
        struct markStruct{
            var mark1: Int
            var mark2: Int
            var mark3: Int
            
            init(mark1: Int, mark2: Int, mark3: Int){
                self.mark1 = mark1
                self.mark2 = mark2
                self.mark3 = mark3
            }
        }
        print("优异成绩:")
        var good = markStruct(mark1: 98, mark2: 96, mark3:100)
        print(good.mark1)
        print(good.mark2)
        print(good.mark3)
        print("糟糕成绩:")
        var fail = markStruct(mark1: 34, mark2: 42, mark3: 13)
        print(fail.mark1)
        print(fail.mark2)
        print(fail.mark3)
        
        
        
        print("----------------------------")
    }
    
    
    func enumerateUseFunc() {
        print("--------枚举(enumerate)的使用----------")
        // 定义枚举
        enum DaysofaWeek {
            case Sunday
            case Monday
            case TUESDAY
            case WEDNESDAY
            case THURSDAY
            case FRIDAY
            case Saturday
        }
        
        var weekDay = DaysofaWeek.THURSDAY
        switch weekDay
        {
        case .Sunday:
            print("星期天")
        case .Monday:
            print("星期一")
        case .TUESDAY:
            print("星期二")
        case .WEDNESDAY:
            print("星期三")
        case .THURSDAY:
            print("星期四")
        case .FRIDAY:
            print("星期五")
        case .Saturday:
            print("星期六")
        }
        weekDay = .Monday
        switch weekDay
        {
        case .Sunday:
            print("星期天")
        case .Monday:
            print("星期一")
        case .TUESDAY:
            print("星期二")
        case .WEDNESDAY:
            print("星期三")
        case .THURSDAY:
            print("星期四")
        case .FRIDAY:
            print("星期五")
        case .Saturday:
            print("星期六")
        }
        
        
        print()
        print("相关值：(1).不同数据类型、(2).值的创建基于常量或变量、(3).每次创建时，才会被设置，且它的值可以是不同的。")
        enum Student{
            case Name(String)
            case Mark(Int,Int,Int)
        }
        var studDetails = Student.Name("fake")
        switch studDetails {
        case .Name(let studName):
            print("学生的名字是: \(studName)。")
        case .Mark(let Mark1, let Mark2, let Mark3):
            print("学生的成绩是: \(Mark1),\(Mark2),\(Mark3)。")
        }
        var studMarks = Student.Mark(98,97,95)
        switch studMarks {
        case .Name(let studName):
            print("学生的名字是: \(studName)。")
        case .Mark(let Mark1, let Mark2, let Mark3):
            print("学生的成绩是: \(Mark1),\(Mark2),\(Mark3)。")
        }
        
        print("原始值：(1).相同数据类型、(2).预先填充的值、(3).原始值始终是相同的")
        enum Month: Int {
            case January = 1, February, March, April, May, June, July, August, September, October, November, December
        }
        
        let yearMonth = Month.May.rawValue
        print("数字月份为: \(yearMonth)。")
        
        
        
        print("----------------------------")
    }
    
    func closuresUseFunc() {
        print("--------闭包(closures)的使用----------")
        
        let divide = {(val1: Int, val2: Int) -> Int in
            return val1 / val2
        }
        let result = divide(200, 20)
        print (result)
        
        print()
        print ("【一】、sorted(by:)方法       sorted(by:条件)")//会根据您提供的用于排序的闭包函数将已知类型数组中的值进行排序。
        let names = ["A","B","AT", "AE", "D", "S", "BE"]
        //使用普通函数(或内嵌函数)提供排序功能,闭包函数类型需为(String, String) -> Bool。
        func backwards(s1: String, s2: String) -> Bool {
            return s1 > s2
        }
        var reversedNames = names.sorted(by: backwards)
        print(reversedNames)
        var reversed22 = names.sorted(by: >) //String类型  有 关于大于号(>)的字符串实现
        print(reversed22)
        
        print ("【二】、使用 尾随闭包")//尾随闭包：书写在函数括号之后的闭包表达式，函数支持将其作为最后一个参数调用。
        var reversed3 = names.sorted() { $0 > $1 }
        //var reversed3 = names.sorted { $0 > $1 }//函数只需要 闭包表达式这一个参数，当您使用尾随闭包时，可以把()省略掉。
        print(reversed3)
        
        print ("【三】、使用 参数名称缩写（$0,$1,……）") //可以直接通过$0,$1,$2来顺序调用闭包的参数。
        let nums = [1, 4, 2, 7, 6, 12, 5]
        var reversedNumbers = nums.sorted( by: { $0 > $1 } )  //$0 > $1：逆序     $0 < $1：顺序
        print(reversedNumbers)
        
        
        print ("【四】、捕获值 [用途]") //其定义的上下文中捕获常量或变量。
        func makeIncrementor(forIncrement amount: Int) -> () -> Int { //返回值是：一个“( )-> Int”的函数。
            var runningTotal = 0
            func incrementor() -> Int {
                runningTotal += amount
                return runningTotal
            }
            return incrementor
        }
        let incrementByTen = makeIncrementor(forIncrement: 10)
        print(incrementByTen()) // 返回的值为10
        print(incrementByTen()) // 返回的值为20
        print(incrementByTen()) // 返回的值为30
        
        print("【五】、闭包和函数都是引用类型") /** 指针指向问题 */
        incrementByTen()    // 返回的值为40
        let alsoIncrementByTen = incrementByTen //将alsoIncrementByTen的值 设置为 incrementByTen对应的闭包的引用
        print(alsoIncrementByTen())// 返回的值也为50
        
        
        
        print("----------------------------")
    }
        
    func functionUseFunc() {
        print("--------函数的使用----------")
    
        
        func fku(str: String) -> String {
            return (str)
        }
        print(fku(str: "fk u!haha~"))
        
        func fku2(name: String, site: String) -> String {
            return name + site
        }
        print(fku2(name: "百度：", site: "www.baidu.com"))
        print(fku2(name: "Google：", site: "www.google.com"))
        
        print("\n 【一】、元组作为函数返回值") //元组作为函数返回值
        func minMax(array: [Int]) -> (min: Int, max: Int) { //元祖  (min: Int, max: Int)
            var currentMin = array[0]
            var currentMax = array[0]
            for value in array[1..<array.count] {
                if value < currentMin {
                    currentMin = value
                } else if value > currentMax {
                    currentMax = value
                }
            }
            return (currentMin, currentMax) //返回的元祖
        }
        let bounds = minMax(array: [8, -6, 2, 109, 3, 71])
        print("最小值为 \(bounds.min) ，最大值为 \(bounds.max)")
        
        print("【二】、没有返回值的函数")
        func fku3(str: String) {
            print("axiba：\(str)")
        }
        fku3(str:"you sillyB")
        
        
        //局部参数名  局部参数名在函数的实现内部使用。
        //外部参数名  你可以在局部参数名前指定好外部参数名，中间以空格分隔，外部参数名用于在函数调用时传递给函数的参数。
        print("\n 【三】、可变参数:") //可以接受零个或多个值，其数量是不确定的。     通过在变量类型名后面加入（...）的方式来定义。
        func vari<N>(members: N...){
            for i in members {
                print(i)
            }
        }
        vari(members: 4,3,5)
        vari(members: 2.5, 3.1, 6.66)
        vari(members: "Google", "Baidu", "Caonima")
        
        
        print("\n 【四】、声明变量参数:")//在参数定义前加 inout关键字，这样就可以改变这个参数的值了。
        func swapTwoInts(_ a: inout Int, _ b: inout Int) {
            let temporaryA = a
            a = b
            b = temporaryA
        }
        
        var x = 1
        var y = 5
        swapTwoInts(&x, &y)
        print("x 现在的值 \(x), y 现在的值 \(y)")
        
        
        //函数类型: 由函数的参数类型和返回类型组成。
        func inputs(no1: Int, no2: Int) -> Int {
            return no1/no2
        }
        //inputs 函数类型有两个 Int 型的参数(no1、no2)并返回一个 Int 型的值。
        
        print("\n 【五】、使用函数类型") //就像使用其他类型一样! 定义一个类型为函数的常量或变量，并将适当的函数赋值给它!
        func sum(a: Int, b: Int) -> Int {
            return a + b
        }
        print("函数类型  作为参数类型")
        var addition: (Int, Int) -> Int = sum
        print("输出结果: \(addition(40, 89))")//作为参数类型
        
        print("函数类型  作为返回类型")
        func another(addition: (Int, Int) -> Int, a: Int, b: Int) {
            print("输出结果: \(addition(a, b))")
        }
        another(addition: sum, a: 10, b: 20)//作为返回类型
        
        
        print("\n 【六】、函数嵌套")
        func calcDecrement(forDecrement total: Int) -> () -> Int {
            var overallDecrement = 0
            
            func decrementer() -> Int {
                overallDecrement -= total
                return overallDecrement
            }
            return decrementer
        }
        
        let decrem = calcDecrement(forDecrement: 30)
        print(decrem())
        
        
        
        print("----------------------------")
    }
    
    
    
    func dictionaryFunc() {
        print("--------字典的操作----------")
        
        
        //字典  （键、值）
        var someDict:[Int:String] = [1:"One", 2:"Two", 3:"Three"]
        let someVar = someDict[1]
        print( "key = 1 的值为 \(someVar)" )
        print( "key = 2 的值为 \(String(describing: someDict[2]))" )
        print( "key = 3 的值为 \(someDict[3])" )
        
        
        print()
        //修改字典内容 [一]
        //        let oldVal = someDict.updateValue("One 新的值", forKey: 1)
        //        let newVar = someDict[1]
        //修改字典内容 [二]
        var oldVal = someDict[1]
        someDict[1] = "One 新的值"
        let newVar = someDict[1]
        
        print( "key = 1 旧旧旧旧旧的值 \(oldVal)" )
        print( "key = 1 的值为 \(newVar)" )
        
        
        print()
        //遍历字典 [一]  使用“for in”遍历
        for (key, value) in someDict {
            print("遍历的 key \(key) -  字典 value \(value)")
        }
        //遍历字典 [二] 使用“enumerate()”方法来进行字典遍历，返回的是字典的索引及 (key, value) 对
        for (key, value) in someDict.enumerated() {
            print("遍历的 key \(key) -----  字典的(key, value)对:\(value)") //value.key、value.value
        }
        
        
        //字典转换为数组
        let dictKeys = [Int](someDict.keys)
        let dictValues = [String](someDict.values)
        
        print("输出字典的键(key)")
        for (key) in dictKeys {
            print("\(key)")
        }
        print("输出字典的值(value)")
        for (value) in dictValues {
            print("\(value)")
        }
        
        
        print()
        //移除“Key-Value”对 [一]
        //        var removedValue = someDict.removeValue(forKey: 2)
        //移除“Key-Value”对 [二]
        someDict[2] = nil
        
        print( "key = 1 的值为 \(someDict[1])" )
        print( "key = 2 的值为 \(someDict[2])" )
        print( "key = 3 的值为 \(someDict[3])" )
        
        
        
        
    }
    
    func tupleFunc() {
        print("--------元组的操作----------")
        
        print(" 元组的元素 个数固定，不允许增加、删除")
        var stu = (404,"错误") //元组的元素 个数固定，不允许增加、删除
        print(stu)
        print(" 支持嵌套")
        let msg = ("基本信息", ("goyohol",18)) //支持嵌套
        print(msg)
        
        print(" 分别获取元组的元素")
        var (a,b) = stu
        print("a is:", a)
        print("b is:", b)
        
        print(" 不需要的值:使用\"_\"的方式来处理")
        let (first,_) = stu //如果仅需要元组中的个别的值，可以使用"_"的方式来处理不需要的值
        print("first is:", first)
        
        print(" 通过序号，获得元组的值")
        print("status.0 is \(stu.0)") //通过序号获得元组的值
        
        print(" 可以修改 元素的值")
        stu.0 = 500 //可以修改
        let message = (staus: 100, msg:"哈哈")
        print("message is \(message.staus)  and \(message.msg)")
        
        
        
        print("----------------------------")
    }
    func arrayFunc() {
        print("--------数组的操作----------")
        
        print(array1,array2,array3,array4,array5,array6,array7,array8)
        
        print()
        for x in 0...10{//"全区间":0,1,2……8,9,10
            print("\(x) ", terminator: "")//terminator:分割
        }
        print()
        for x in 0..<10{//"半开区间":0,1,2……8,9
            print("\(x) ", terminator: "")//terminator:分割
        }
        print()
        
        
        print()
        //swift遍历数组
        //[一].for in遍历
        let traverseArr:Array<Int> = [1,2,3,4,6,7,8,9,22]
        let legh = traverseArr.count
        for i in 0 ..< legh {
            print("traverseArr元素：\(traverseArr[i])")
            print("索引值：\(i)")
        }
        
        //[二].遍历数组
        for x in traverseArr{ //打印数组
            print("\(x) ", terminator: "")//terminator:分割
        }
        print()
        
        //[三].使用索引－值方式enumerate（）方式
        for(indexs,item) in traverseArr.enumerated(){
            print("索引:\(indexs)  值:\(item)")
        }
        
        
        print("\n 数组的操作、处理")
        
        //数组 合并（两种已存在的相同类型的数组）
        let intsA = [Int](repeating: 2, count:2)
        let intsB = [Int](repeating: 1, count:3)
        let intsC = intsA + intsB
        for item in intsC {
            print(item)
        }
        
        
        
        print("----------------------------")
    }

    
    func unicodeStringFunc() {
        print("--------unicode字符串 操作----------")
        
        //Unicode 字符串
        var unicodeString   = "ab巴洛克123"
        print("UTF-8 编码: ")
        for code in unicodeString.utf8 {
            print("\(code) ")
        }
        print()
        print("UTF-16 编码: ")
        for code in unicodeString.utf16 {
            print("\(code) ")
        }
        
        //print()
        //print("unicodeScalars",unicodeString.unicodeScalars) //????????????????????????
        //for code in unicodeString.unicodeScalars {
        //    print("\(code) ")
        //}
        
        
        
        print("----------------------------")
    }
    
    func stringFunc() {
        print("--------字符串(String)操作----------")
        
        // 使用字符串字面量创建 空字符串
        let stringA = ""
        if stringA.isEmpty {
            print( "stringA 是空的" )
        } else {
            print( "stringA 不是空的" )
        }
        // 实例化 String 类来创建空字符串
        let stringB = String()
        if stringB.isEmpty {
            print( "stringB 是空的" )
        } else {
            print( "stringB 不是空的" )
        }
        
        print()
        let partA   = 20
        let constA = 100
        let partC:Float = 20.0
        //字符串中插入值
        let totalStr = "\(partA) 乘于 \(constA) 等于 \(partC * 100)"
        print("字符串中插入值","   ", totalStr )
        
        let part_1 = "反反复复付："
        let part_2 = "adjkdjfklsjfksljaldjalkfdj"
        //字符串连接 [一]
        var togeStr = part_1 + part_2
        print("字符串连接","   ",togeStr)
        
        var var22:String = "Hello!"
        let varB3:String = "Jsadafd"
        //字符串连接 [二]
        var22.append( varB3 )
        print("字符串连接","   ","varC  =  \(var22)")
        
        //字节数量
        print("字符串的字节数量:",part_1.lengthOfBytes(using: .utf8))
        //字符串长度
        let addd = part_1.characters.count
        print("字符串的长度为：",addd)
        
        //转换字符串数字为整型
        let intString: String = "256"
        let myInt: Int? = Int(intString)
        print("转为整型后，",myInt!+12)
        
        
        
        print("----------------------------")
    }
    
    func unicodeFunc() {
        print("--------使用 简单的 Unicode字符----------")
    
        let _fuck = "Hello,Fuck Swift!"
        print(_fuck)
        //简单的 Unicode 字符
        let 法克 = "法克世界"
        print(法克)
        
        
        
        print("----------------------------")
    }
    
    func declarationFunc() {
        print("--------变量的声明----------")
        
        /** 变量声明 [一] */
        let blaA = 42
        print("直接赋值！    blaA:",blaA)
        /** 变量声明 [二] */
        var blaB:Float
        blaB = 3.14159
        print("先定义类型!   blaB:",blaB) //变量输出 ： 变量和常量可以使用 print
        
        
        
        print("----------------------------")
    }
    
    func typeFunc() {
        print("--------类型的操作----------")
        
        /** 类型别名 */
        typealias FuckU = Int
        let intFuck: FuckU = 100
        print("类型别名定义的数：",intFuck)
        
        /** 类型判断 */
        //如果你没有显式指定类型，Swift 会使用类型推断（type inference）来选择合适的类型。
        // varA 会被推测为 Int 类型
        let varA = 42;  print("varA:",varA)
        // varB 会被推测为 Double 类型
        let varB = 3.14159; print("varB:",varB)
        let varB_change = (Int)(3.14159); print("强转为整型 varB_change:",varB_change)
        // varC 也会被推测为 Double 类型
        let varC = 3 + 0.14159; print("varC:",varC)
        
        print()
        /** 可选(Optionals)类型 */
        optionalInteger1 = 42
        print("optionalInteger1 is:",optionalInteger1!)// 42   （用后缀操作符 ！来访问这个值）
        
        
        //optionalString = "fadfafdafdafaadsd"
        
        //强制解析
        //感叹号表示"我知道这个可选有值，请使用它"。这被称为可选值的强制解析（forced unwrapping）。
        //print(optionalString!) //报错————fatal error: unexpectedly found nil while unwrapping an Optional value
        //print("可选optionalString is",optionalString);
        //print("可选optionalString is",optionalString ?? "adaf"); //没有的话，选择“adaf”
        if optionalString != nil {
            print(optionalString!)
        }else{
            print("字符串为 nil")
        }
        //使用!来获取一个不存在的可选值会导致运行时错误。使用!来强制解析值之前，一定要确定可选包含一个非nil的值。
        
        //自动解析
        //你可以在声明可选变量时使用感叹号（!）替换问号（?）。这样可选变量在使用时就不需要再加一个感叹号（!）来获取值，它会自动解析。
        optionalString222 = "Hello, Swift!"
        if optionalString222 != nil {
            print(optionalString222)
        }else{
            print("optionalString222 值为 nil")
        }
        
        
        
        print("----------------------------")
    }
    
    func basicTypeFunc() {
        print("--------基本类型的操作----------")
        
        let a = 1 + 2;  // 编码规范推荐使用这种写法
        let b = 3+4 // 这样也是OK的
        print("a=\(a)","b=\(b)")
        print()
        
        //Swift不要求在每行语句的结尾使用分号(;)，但当你在同一行书写多条语句时，必须用分号隔开
        let myString = "Hello,Fuck World!"; print(myString)
        
        let one = "ab cd ef gh i lm"
        print(one);
        
        print(str,str2,str3,str4,str5)
        
        showStr = String.init(format: "%@%d", str4,numOfRab)
        print(showStr)
        
        print(numOfYou,numOfRab,"str2 is:\(str2)")
        
        
        
        print("----------------------------")
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}







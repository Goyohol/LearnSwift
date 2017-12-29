//
//  AnotherViewController.swift
//  swiftUse
//
//  Created by RainHeroic Kung on 2017/12/27.
//  Copyright © 2017年 RainHeroic Kung. All rights reserved.
//

import UIKit


class AnotherViewController: UIViewController, UITextViewDelegate,UIPickerViewDataSource,UIPickerViewDelegate {

    //全局变量
    fileprivate var _actvi = UIActivityIndicatorView()
    
    var letter:Array<Any> = []
    var number:Array<Any> = []
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.init(colorLiteralRed: 0.3, green: 0.6, blue: 0.2, alpha: 0.6)
        
        self .createUI() //UI搭建
        
        
        // Do any additional setup after loading the view.
    }

    
    func createUI() { //UI搭建
        //返回按钮
        let backBtn = UIButton.init(frame: CGRect(x:10, y:20, width:50, height:35))
        backBtn .setTitle("返回", for: UIControlState.normal)
        backBtn .backgroundColor = UIColor.cyan;
        backBtn .addTarget(self, action: #selector(backToFather), for: UIControlEvents.touchUpInside)
        self.view .addSubview(backBtn)
        
        //跳转按钮
        let presentBtn = UIButton .init(frame: CGRect(x: UIScreen.main.bounds.width-120, y: 20, width: 120 - 10, height: 35))
        presentBtn.titleLabel?.adjustsFontSizeToFitWidth = true //按钮标题 大小自适应
        presentBtn .setTitle("跳转到下个界面", for: UIControlState.normal)
        presentBtn .backgroundColor = UIColor.cyan;
        presentBtn .addTarget(self, action: #selector(ViewController.presentToAnother), for: UIControlEvents.touchUpInside)
        self.view .addSubview(presentBtn)
        
        
        let noticeLB = UILabel.init(frame: CGRect(x:0 ,y:0, width:150 ,height:50))
        noticeLB.center = CGPoint(x:self.view.center.x ,y:presentBtn.center.y)
        noticeLB.backgroundColor = UIColor.brown
        noticeLB.text = "控件使用、展示"
        noticeLB.textColor = UIColor.red
        noticeLB.adjustsFontSizeToFitWidth = true //字体自适应
        noticeLB.textAlignment = NSTextAlignment.center
        self.view .addSubview(noticeLB)
        
        //>>>>>标签：UILabel
        //>>>>>按钮：UIButton
        //>>>>>输入框：UITextField
        
        
        //>>>>>多段选择器：UISegmentedControl
        let selectArr = ["1","123","blabla","老子","fku"]  //若加上“as [Any]”，是可放置(多种)任何 元素
        let seg = UISegmentedControl.init(items: selectArr)
        seg.frame = CGRect(x:10 ,y:70 , width:UIScreen.main.bounds.width/2 - 2*10 ,height:35)
        seg.selectedSegmentIndex = 2;//设置选择项：第三项
        self.view .addSubview(seg)
        //添加 事件(值变化)
        seg .addTarget(self, action: #selector(segcTouched), for: UIControlEvents.valueChanged)
        
        
        //>>>>>滑块：UISlider
        let slider = UISlider.init(frame: CGRect(x:UIScreen.main.bounds.width/2 + 10 ,y:70 , width:UIScreen.main.bounds.width/2 - 20 ,height:35))
        slider.value = 30; //设置默认值
        slider.minimumValue = 0     //最小值
        slider.maximumValue = 100   //最大值
        slider.minimumTrackTintColor = UIColor.red  //划过去的线的颜色
        slider.maximumTrackTintColor = UIColor.blue //未划过线的颜色
        slider.thumbTintColor = UIColor.orange;     //中间球设置颜色
        
//        //未划过线 对应的图片
//        slider .setMinimumTrackImage(UIImage.init(named: "navgationBar_ios7"), for: UIControlState.normal)
//        //划过去线 对应的图片
//        slider .setMaximumTrackImage(UIImage.init(named: "sliderPassed"), for: UIControlState.normal)
        
        //中间圆球 对应的图片
        slider .setThumbImage(UIImage.init(imageLiteralResourceName: "biochemistry"), for: UIControlState.normal)
        let mid_Image = self .OriginImageAndscaleToSize(image: UIImage.init(named: "biochemistry")!, size: CGSize(width:12, height:12));
        slider .setThumbImage(mid_Image, for: UIControlState.normal)        //正常状态
        slider .setThumbImage(mid_Image, for: UIControlState.highlighted)   //高亮(滑动)状态
        //最小值 对应的图片
        let min_Image = self .OriginImageAndscaleToSize(image: UIImage.init(named: "cup")!, size: CGSize(width:12, height:12));
        slider.minimumValueImage = min_Image
        //最大值 对应的图片
        let max_Image = self .OriginImageAndscaleToSize(image: UIImage.init(named: "diamond")!, size: CGSize(width:12, height:12));
        slider.maximumValueImage = max_Image

        self.view .addSubview(slider)
        //添加 事件(值变化)
        slider .addTarget(self, action: #selector(sliderMoved), for: UIControlEvents.valueChanged)
        
        
        //>>>>>开关：UISwitch
        let 开关 = UISwitch.init(frame: CGRect(x:10 ,y:70+50 , width:UIScreen.main.bounds.width/2 - 2*10 ,height:35))
        开关.isSelected = true
        self.view .addSubview(开关)
        开关 .addTarget(self, action: #selector(switchTouched), for: UIControlEvents.valueChanged)
        
        
        //>>>>>进度指示器：UIActivityIndicatorView
        _actvi = UIActivityIndicatorView .init(frame: CGRect(x:UIScreen.main.bounds.width/2 + 10 ,y:70+50 , width:35 ,height:35))
        _actvi.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.whiteLarge //大号
        _actvi.backgroundColor = UIColor.white  //设置背景颜色
        _actvi.color = UIColor.red              //设置旋转的颜色
        self.view .addSubview(_actvi)
        _actvi.hidesWhenStopped = false;//false: 刚进入界面,会显示控件。 并且停止旋转,也会显示(没有在转动而已)。
//        _actvi .startAnimating() //开启转动
        
        
        //>>>>>进度条：UIProgressView
        let progressV = UIProgressView .init(frame: CGRect(x:10 ,y:70+50*2 , width:UIScreen.main.bounds.width/2 - 2*10 ,height:35))
        progressV.progress = 0.3 //当前进度：0~1
        progressV.progressTintColor = UIColor.red   //划过去部分 线的颜色
        progressV.trackTintColor = UIColor.yellow   //未划过部分 线的颜色
        progressV.progressImage = UIImage.init(named: "navgationBar_ios7")  //划过去部分 的图片
        progressV.trackImage = UIImage.init(named: "sliderPassed")          //未划过部分 的图片
        self.view .addSubview(progressV)
        progressV.tag = 100 //设置tag值
        
        
        //>>>>>分页控制器：UIPageControl
        let pageC = UIPageControl.init(frame: CGRect(x:UIScreen.main.bounds.width/2 + 10 ,y:70+50*2 , width:100 ,height:35))
        //pageC.tintAdjustmentMode = UIViewTintAdjustmentMode.dimmed
        pageC.backgroundColor = UIColor.blue        //背景色
        pageC.pageIndicatorTintColor = UIColor.red  //下标颜色
        pageC.currentPageIndicatorTintColor = UIColor.orange //当前(选择)的下标颜色
        pageC.numberOfPages = 5 //总分页数
        pageC.currentPage = 2;  //当前分页
        self.view .addSubview(pageC)
        pageC .addTarget(self, action: #selector(pageCclicked), for: UIControlEvents.valueChanged)
        
        
        //>>>>>计步器(+、-)：UIStepper
        let stepper = UIStepper.init(frame: CGRect(x:10 ,y:70+50*3 , width:UIScreen.main.bounds.width/2 - 2*10 ,height:35))
        stepper.minimumValue = 0    //最小值，默认为0
        stepper.maximumValue = 20   //最大值，默认为100
        stepper.value = 10  //当前值
        stepper.stepValue = 2   //步进值
        //分割线图片
        stepper .setDividerImage(UIImage(named: "time")!.withRenderingMode(.alwaysOriginal), forLeftSegmentState: .normal, rightSegmentState: .normal) //正常状态
//        stepper .setDividerImage(UIImage(named: "time")!.withRenderingMode(.alwaysOriginal), forLeftSegmentState: .normal, rightSegmentState: .highlighted) //高亮状态
        
        //“＋”按钮图片
        stepper .setIncrementImage(UIImage(named: "diamond")!.withRenderingMode(.alwaysOriginal), for: UIControlState.normal)  //渲染： !.withRenderingMode(.alwaysOriginal)
        //“－”按钮图片
        stepper .setDecrementImage(UIImage(named: "cup")!.withRenderingMode(.alwaysOriginal), for: UIControlState.normal)
        self.view .addSubview(stepper)
        stepper .addTarget(self, action: #selector(stepperClicked), for: UIControlEvents.valueChanged)
        
        
        //>>>>>文本框(输入)：UITextView
        let textTV = UITextView.init(frame: CGRect(x:UIScreen.main.bounds.width/2 + 10 ,y:70+50*3 , width:UIScreen.main.bounds.width/2 - 2*10 ,height:35+50))
        textTV.delegate = self as UITextViewDelegate  //UITextViewDelegate
        self.view .addSubview(textTV)
        textTV.tag = 1000
        
        
        //>>>>>布局总视图：UIStackView
        let stackV = UIStackView.init(frame: CGRect(x:10 ,y:70+50*4 , width:UIScreen.main.bounds.width/2 - 2*10 ,height:150))
        stackV.axis = UILayoutConstraintAxis.vertical //垂直分布
        stackV.distribution = .fillEqually
        stackV.alignment = .center  //水平居中
//        stackV.alignment = .firstBaseline //最底部
//        stackV.alignment = .trailing//
//        stackV.alignment = .lastBaseline  //最顶部
        stackV.backgroundColor = UIColor.white
        self.view .addSubview(stackV)
        let stack_imgV1:UIImageView = UIImageView(image: UIImage(named: "cup"))
        let stack_imgV2:UIImageView = UIImageView(image: UIImage(named: "time"))
        let stack_imgV3:UIImageView = UIImageView(image: UIImage(named: "diamond"))
        stackV .addArrangedSubview(stack_imgV1)   //添加 控件
        stackV .addArrangedSubview(stack_imgV2)   //添加 控件
        stackV .addArrangedSubview(stack_imgV3)   //添加 控件
        let stack_imgV2_5:UIImageView = UIImageView(image: UIImage(named: "biochemistry"))
        stackV .insertArrangedSubview(stack_imgV2_5, at: 2) //插入 控件
        
        
        //>>>>>图片视图：UIImageView
        let imgV = UIImageView.init(frame: CGRect(x:UIScreen.main.bounds.width/2 + 10 ,y:70+50*4+50 , width:UIScreen.main.bounds.width/2 - 2*10 ,height:100))
        imgV.backgroundColor = UIColor.white
        imgV.image = #imageLiteral(resourceName: "biochemistry") //宏定义：`#`加`imageLiteral(resourceName: "biochemistry")`
        self.view .addSubview(imgV)
        
        
        //>>>>>日期选择器：UIDatePicker
        let datePicker = UIDatePicker.init(frame: CGRect(x:10 ,y:70+50*4+(150+10) ,width:UIScreen.main.bounds.width - 2*10 ,height:100))
        datePicker.backgroundColor = UIColor.blue
        datePicker.tintColor = UIColor.red
        datePicker.locale = NSLocale.init(localeIdentifier: "zh") as Locale //设置 本地化支持的语言（中文)
        datePicker.datePickerMode = UIDatePickerMode.date; //显示方式是只显示年月日
        datePicker.datePickerMode = UIDatePickerMode.time
        datePicker.datePickerMode = UIDatePickerMode.dateAndTime
        datePicker .addTarget(self, action: #selector(datePickerPicked), for: UIControlEvents.valueChanged)
        self.view .addSubview(datePicker)
        
        //>>>>>选择器：UIPickerView
        let X_pickV = CGFloat(10.0)
        let Y_pickV = CGFloat(70+50*4+(150+10)+(100+10))
        let W_pickV = CGFloat(UIScreen.main.bounds.width/2 - 2*10)
        let H_pickV = CGFloat(100)
        //CGRect的x,y,width,height 分开定义好
        let pickerV = UIPickerView.init(frame: CGRect(x:X_pickV ,y:Y_pickV ,width:W_pickV ,height:H_pickV))
        pickerV.backgroundColor = UIColor.yellow
        pickerV.delegate = self as UIPickerViewDelegate
        pickerV.dataSource = self as UIPickerViewDataSource
        self.view .addSubview(pickerV)
        self.letter = ["aaa","bbb","ccc","ddd","eee"]
        self.number = ["111","222","333","444","555"]
        pickerV .reloadAllComponents()//刷新数据
        
        
        
        
    }
    //自定义图片的大小    通过此方法可以更改滑块的任意大小和形状
    func OriginImageAndscaleToSize(image :UIImage, size: CGSize) -> UIImage {
        UIGraphicsBeginImageContext(size);//size为CGSize类型，即你所需要的图片尺寸
        image .draw(in: CGRect(x:0, y:0, width:size.width, height:size.height) )
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext();
        return scaledImage!;
    }
    
    
    func segcTouched(seg: UISegmentedControl) {
        print("点击的位置：",seg.selectedSegmentIndex)
    }
    func sliderMoved(slider: UISlider) {
        print("slider的值:",slider.value)
        
        let progressV = self.view .viewWithTag(100) as! UIProgressView //强转为UIProgressView
        progressV.progress = slider.value / slider.maximumValue
    }
    func switchTouched(swi7: UISwitch) {
        switch swi7.isOn {
        case true:
            print("开关：已打开")
            
            _actvi .startAnimating() //开启转动
            break
        case false:
            print("开关：已关闭")
            
            _actvi .stopAnimating() //停止转动
            break
        }
        print("")
    }
    func pageCclicked(pageC: UIPageControl) {
        print("当前选择的下标:",pageC.currentPage)
    }
    func stepperClicked(stepper: UIStepper) {
        print("stepper的值",stepper.value)
    }
    func datePickerPicked(datePicker: UIDatePicker) {
        print("当前日期date：",datePicker.date)
    }
    
    
    //MARK:UITextViewDelegate
    func textViewDidBeginEditing(_ textView: UITextView) {
        print("textTV已经开始编辑")
    }
    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        print("textTV结束编辑")
        
        return true
    }
    
    //MARK:UIPickerViewDataSource
    func numberOfComponents(in pickerView: UIPickerView) -> Int {   //指定pickerview有几个表盘
        return 2 //第一个展示字母、第二个展示数字
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {//指定各表盘上有几行数据
        var result = 0
        switch (component) {
        case 0:
            result = self.letter.count;//根据数组的元素个数返回几行数据
            break;
        case 1:
            result = self.number.count;
            break;
            
        default:
            break;
        }
        return result
    }
    //MARK:UIPickerViewDelegate
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {//指定每行如何展示数据（此处和tableview的cellFor类似）
        var title:String = ""
        switch (component) {
        case 0:
            title = self.letter[row] as! String;
            break;
        case 1:
            title = self.number[row] as! String;
            break;
        default:
            break;
        }
        return title;
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch component {
        case 0: //letter数组  下标：0
            print("对应数组:self.letter row:\(row)      \(self.letter[row])" )
        default://number数组  下标：1
            print("对应数组:self.number row:\(row)      \(self.number[component])" )
        }
    }
    
    
    
    
    
    
    
    
    
    func backToFather() { //跳到上一层
        self .dismiss(animated: true) { 
            print("present 往上一层跳转 已完成")
        }
    }
    func presentToAnother() { //跳转到下个界面
        let twoWithNav_VC = TwoWithNavgationViewController()
        let nav_VC = UINavigationController.init(rootViewController: twoWithNav_VC)
        self .present(nav_VC, animated: true)
    }
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let textTV = self.view .viewWithTag(1000) as! UITextView
        textTV .resignFirstResponder()
    }
    
    
    
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

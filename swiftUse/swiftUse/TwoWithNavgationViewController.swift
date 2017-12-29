//
//  TwoWithNavgationViewController.swift
//  swiftUse
//
//  Created by RainHeroic Kung on 2017/12/27.
//  Copyright © 2017年 RainHeroic Kung. All rights reserved.
//

import UIKit

class TwoWithNavgationViewController: UIViewController, UITableViewDelegate,UITableViewDataSource {

    var dataArr:Array<Any> = []
    
    
    
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        /** 状态栏 */
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
//        self.view.backgroundColor = UIColor.init(colorLiteralRed: 0.1, green: 0.2, blue: 0.7, alpha: 0.35)
        
        
        self .createNavBar()
        
        self .createUI()
        
        
        
        // Do any additional setup after loading the view.
    }

    func createNavBar() {
        /** 导航栏 */
        //【一】、设置为图片（状态栏+导航栏）
//        let Nav_BG_img = UIImage.init(imageLiteralResourceName: "navgationBar_ios7")
//        let RightSize_Nav_BG_img = Nav_BG_img .resizableImage(withCapInsets: UIEdgeInsetsMake(0, 0, 0, 0), resizingMode: UIImageResizingMode.stretch)//自适应大小
//        self.navigationController?.navigationBar .setBackgroundImage(RightSize_Nav_BG_img, for: UIBarMetrics.default)
//        //【二-1】、导航栏的最底部颜色设置
//        self.navigationController?.navigationBar.backgroundColor = UIColor.red
//        //【二-2】、表层颜色(barTintColor)，即首先看到的颜色
//        self.navigationController?.navigationBar.barTintColor = UIColor.gray
        
        //【三-1】、设置字体:标题字体
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.blue,NSFontAttributeName:UIFont(name: "Heiti SC", size: 16.0)!]
        //【三-3】、填充字体颜色
        self.navigationController?.navigationBar.tintColor = UIColor.red //颜色
        //【三-2】、设置字体:BarButtonItem    ？？？？？？？？？
        self.navigationItem.leftBarButtonItem? .setTitleTextAttributes([NSForegroundColorAttributeName:UIColor.yellow,NSFontAttributeName: UIFont(name: "Chalkduster", size: 5)!], for: UIControlState.normal)
        
        
        //【四】、是否隐藏导航栏 (默认：false)
        //self.navigationController?.navigationBar.isHidden = true
        
        //【五】、去掉透明导航栏边的黑边
        //self.navigationController?.navigationBar.shadowImage = UIImage.init()
        //self.navigationController!.navigationBar.shadowImage = UIImage()
        
        
        //【六】、将导航栏设置成透明
        self.navigationController?.navigationBar .setBackgroundImage(UIImage(), for: UIBarMetrics.default)
//        self.navigationController?.navigationBar.isTranslucent = true
        
        
        //标题、BarButtonItem
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(title: "返回", style: UIBarButtonItemStyle.plain, target: self, action: #selector(backToFather))
        self.navigationItem.title = "第三个界面：含UINavigationBar"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: UIBarButtonSystemItem.rewind,  target: self, action: #selector(backToFather))
    }
    func backToFather() {
        self .dismiss(animated: true, completion: nil)
    }
    
    
    
    
    
    func createUI() {
        let ceterV = UIView.init(frame: CGRect(x:0, y:0 ,width:UIScreen.main.bounds.width/2, height:UIScreen.main.bounds.width/2) )
        ceterV.center = CGPoint(x:UIScreen.main.bounds.width/2 ,y:UIScreen.main.bounds.height/2) //中心
        ceterV.backgroundColor = UIColor.red
        ceterV.layer.masksToBounds = true
        ceterV.layer.cornerRadius = (UIScreen.main.bounds.width/2)/2
        self.view .addSubview(ceterV)
        
        let noticeLB = UILabel.init(frame: CGRect(x:0, y:0 ,width:ceterV.bounds.size.width/2, height:ceterV.bounds.size.width/2) )
        noticeLB.center = CGPoint(x:ceterV.bounds.size.width/2 ,y:ceterV.bounds.size.height/2) //中心
        noticeLB.backgroundColor = UIColor.cyan
        noticeLB.textAlignment = NSTextAlignment.center
        noticeLB.text = "点击\\push到下个界面"
        noticeLB.numberOfLines = 0
        noticeLB.lineBreakMode = NSLineBreakMode.byCharWrapping
        ceterV .addSubview(noticeLB)
        
        //添加手势
        let tapGes = UITapGestureRecognizer.init(target: self, action: #selector(pushToAnohterVC))
        ceterV .addGestureRecognizer(tapGes)
        
        
        
        
        
        //>>>>>滑动列表：UITableView
        let tabV = UITableView.init(frame: CGRect(x:10, y:5+64 ,width:UIScreen.main.bounds.size.width - 2*10, height:200) )
        tabV.delegate = self as UITableViewDelegate
        tabV.dataSource = self as UITableViewDataSource
//        tabV .register(UITableViewCell .classForCoder(), forCellReuseIdentifier: "cellID") //【二】、方式二
        self.view .addSubview(tabV)
        tabV.layer.borderWidth = 1                   //边框宽度
        tabV.layer.borderColor = UIColor.blue.cgColor //边框颜色(CGColor)
        self.dataArr = ["a","bbbbbbbbbbb","333323333333","fffo","sdsdsda","xccvcc","231","goto","sdffaadsfd"]
        
        
        //>>>>>网页加载控件：
        let webV = UIWebView.init(frame: CGRect(x:10, y:UIScreen.main.bounds.height-200 - 10 ,width:UIScreen.main.bounds.size.width - 2*10, height:200))
        self.view .addSubview(webV)
        webV.layer.borderWidth = 1                      //边框宽度
        webV.layer.borderColor = UIColor.cyan.cgColor   //边框颜色(CGColor)
        let Url_request = URL.init(string: "https://www.baidu.com")
        let request = URLRequest.init(url: Url_request!)
        webV .loadRequest(request)
        
        
    }
    
    func pushToAnohterVC() {
        let threeWithNav_VC = ThreeWithNavigationViewController()
        threeWithNav_VC.title = "第四个 界面(UIWebView)"
        self.navigationController? .pushViewController(threeWithNav_VC, animated: true)
        
    }
    
    //MARK:UITableViewDelegate,UITableViewDataSource
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("click ar row:\(indexPath.row)    ,and item is:\(self.dataArr[indexPath.row])")
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row%2 == 0 {
            return 30.0     //偶数行
        } else {
            return 60.0    //奇数行
        }
    }
    func numberOfSections(in tableView: UITableView) -> Int {   //组数
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArr.count   //每组元素的个数
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        //【二】、方式二
//        var cell = tableView .dequeueReusableCell(withIdentifier: "cellID", for: indexPath)
//        if cell == nil {
//            cell = UITableViewCell.init(style: UITableViewCellStyle.default, reuseIdentifier: "cellID")
//        }
//        cell.textLabel?.text = self.dataArr[indexPath.row] as? String
//        return cell
        
        //【一】、方式一
        var cell = tableView .dequeueReusableCell(withIdentifier: "cellID")
        if cell == nil {
            cell = UITableViewCell.init(style: UITableViewCellStyle.default, reuseIdentifier: "cellID")
        }
        cell?.textLabel?.text = self.dataArr[indexPath.row] as? String
        return cell!
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

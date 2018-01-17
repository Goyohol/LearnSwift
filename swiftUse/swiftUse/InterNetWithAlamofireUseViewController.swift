//
//  InterNetWithAlamofireUseViewController.swift
//  swiftUse
//
//  Created by RainHeroic Kung on 2018/1/17.
//  Copyright © 2018年 RainHeroic Kung. All rights reserved.
//

import UIKit

//引入
import MBProgressHUD// 进度指示器
import Alamofire // 网络请求类

let ExampleURL = "http://www.apiopen.top:88/femaleNameApi?page=1"


class InterNetWithAlamofireUseViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource {

    var dataArr = NSMutableArray()  //数据源数组
    var tabV = UITableView()        //UItableview
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.white
        
        
        //返回按钮
        let backBtn = UIButton.init(frame: CGRect(x: 50, y: 100, width: UIScreen.main.bounds.width - 2*50, height: 100))
        self.view .addSubview(backBtn)
        backBtn.backgroundColor = UIColor.red
        backBtn .setTitle("返回", for: UIControlState.normal)
        backBtn .addTarget(self, action: #selector(backToFather), for: UIControlEvents.touchUpInside)
        
        
        
        self .createUI()
        
        self .netRequest()
        
        

        // Do any additional setup after loading the view.
    }

    func backToFather() { //跳到上一层
        self .dismiss(animated: true) {
            print("present 往上一层跳转 已完成")
        }
    }
    
    
    
    
    func createUI() {
        let picImgV = UIImageView.init(frame: CGRect(x: 5, y: UIScreen.main.bounds.height - 100, width: UIScreen.main.bounds.width - 2*5, height: UIScreen.main.bounds.height - 100 ) )
        
        
        
        
        
        self.tabV = UITableView.init(frame: CGRect(x: 10, y: 100 + 100+20, width: UIScreen.main.bounds.width - 2*10, height: UIScreen.main.bounds.height - (100 + 100+20) - 100 ), style: UITableViewStyle.plain)
        self.view .addSubview(self.tabV)
        self.tabV.layer.borderColor = UIColor.red.cgColor
        self.tabV.layer.borderWidth = 2.0
        self.tabV.delegate = self
        self.tabV.dataSource = self
        
    }
    //MARK:UITableViewDataSource
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50.0
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArr.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView .cellForRow(at: indexPath) //放置复用
//        var cell = tableView .dequeueReusableCell(withIdentifier: "cellID")
        if cell == nil {
            cell = UITableViewCell.init(style: UITableViewCellStyle.default, reuseIdentifier: "cellID")
        }
        cell?.textLabel?.text = self.dataArr[indexPath.row] as? String
        
        return cell!
    }
    //MARK:UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("click at:",indexPath.row,"  ","item is:\(self.dataArr[indexPath.row])")
    }
    
    
    
    func netRequest() {
        
        let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
        //hud.delegate = self as? MBProgressHUDDelegate //设置代理   方法: hudWasHidden
        //MBProgressHUD的常用设置
        hud.label.text = "网络请求，数据加载中..."   //文字
        hud.detailsLabel.text = "请耐心等待..."//细节文字
//        hud.bezelView.color = UIColor.clear//小方框背景色
        hud.backgroundView.style = .blur    //屏幕设置背景,blur:毛玻璃效果   //或solidColor
        
        
        
        Alamofire.request(ExampleURL).responseJSON { response in
            print("请求的URL  response.request:",response.request ?? "no")     //原始的URL请求
            print("请求的响应  response.response:",response.response ?? "no")   //HTTP URL响应
            print("请求的数据大小  response.data:",response.data ?? "no")      //服务器返回的数据
            print("请求的返回结果  response.result:",response.result)   //响应序列化结果，在这个闭包里，存储的是JSON数据
            
            if let JSON = response.result.value {
                //print("JSON: \(JSON)")    // json数据
                
                //转换为 字典类型
                let dict = (JSON as AnyObject)
                //print("all datas dict: \(dict)")
                
                if ((dict["code"] as! NSNumber) == 200) { //请求成功
                    
                    let allDataArr = (dict["data"] as! NSArray)
                    for elementDict in allDataArr { //遍历数据
//                        print("各个元素 elementDict:",elementDict as AnyObject)
                        let addDict = elementDict as! NSDictionary
                        
                        
                        //self.dataArr .add(addDict["femalename"] ?? "no value")
                        if ((addDict["femalename"]) != nil) {
                            self.dataArr .add(addDict["femalename"] ?? "no value")
                        } else {
                       
                        }
                    }
                    
//                    print("新的 数组self.dataArr:\n",self.dataArr)
                    
                    
                    
                    
                    
                    //延时 执行
                    let delayQueue = DispatchQueue.init(label: "com.syc.nd")
                    let delayTime : DispatchTimeInterval = .seconds(2) //延时2秒
                    delayQueue.asyncAfter(deadline: .now() + delayTime, execute: {
                        
                        DispatchQueue.main.async { //处理UI:主线程
                            hud.label.text = (dict["msg"] as! String)//文字
                            hud.detailsLabel.text = nil //细节文字
                            
                            self.tabV .reloadData() //刷新UItableview
                        }
                        
                    })
                    
                    
                    hud.hide(animated: true, afterDelay: 3) //3秒后，隐藏
                } else {
                    hud.label.text = (dict["msg"] as! String)//文字
                    hud.detailsLabel.text = nil //细节文字
                    
                    hud.hide(animated: true, afterDelay: 3) //3秒后，隐藏
                }
                
                
            }
        }
        
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

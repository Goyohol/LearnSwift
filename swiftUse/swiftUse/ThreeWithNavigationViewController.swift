//
//  ThreeWithNavigationViewController.swift
//  swiftUse
//
//  Created by RainHeroic Kung on 2017/12/27.
//  Copyright © 2017年 RainHeroic Kung. All rights reserved.
//

import UIKit

class ThreeWithNavigationViewController: UIViewController,UIWebViewDelegate {
    
    var _webV:UIWebView?
    
    
    
    
    
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        /** 导航栏 */
        //【一】、设置为图片（状态栏+导航栏）
//        let Nav_BG_img = UIImage.init(imageLiteralResourceName: "navgationBar_ios7")
//        let RightSize_Nav_BG_img = Nav_BG_img .resizableImage(withCapInsets: UIEdgeInsetsMake(0, 0, 0, 0), resizingMode: UIImageResizingMode.stretch)//自适应大小
//        self.navigationController?.navigationBar .setBackgroundImage(RightSize_Nav_BG_img, for: UIBarMetrics.default)
        //【二-1】、导航栏的最底部颜色设置
//        self.navigationController?.navigationBar.backgroundColor = UIColor.red
//        //【二-2】、表层颜色(barTintColor)，即首先看到的颜色
//        self.navigationController?.navigationBar.barTintColor = UIColor.gray
        
        
        //【五】、去掉 透明导航栏边的黑边
//        self.navigationController?.navigationBar.shadowImage = UIImage.init()
        self.navigationController!.navigationBar.shadowImage = UIImage()
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        /** 导航栏 */
        //【一】、去除 显示的图片（状态栏+导航栏）
        self.navigationController?.navigationBar .setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        //【二-1】、导航栏的最底部颜色设置
        self.navigationController?.navigationBar.backgroundColor = UIColor.clear
        //【二-2】、表层颜色(barTintColor)，即首先看到的颜色
        self.navigationController?.navigationBar.barTintColor = UIColor.clear
        
        //【五】、显示 透明导航栏边的黑边
        self.navigationController?.navigationBar.shadowImage = nil
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        
        
        self .creatUI()
        
        
        
        // Do any additional setup after loading the view.
    }
    
    func creatUI() {
        //>>>>>网页加载控件：
        _webV = UIWebView.init(frame: CGRect(x:10, y:100 ,width:UIScreen.main.bounds.size.width - 2*10, height:UIScreen.main.bounds.height-100 - 10))
        _webV?.delegate = self as UIWebViewDelegate
        self.view .addSubview(_webV!)
        _webV?.layer.borderWidth = 1                      //边框宽度
        _webV?.layer.borderColor = UIColor.cyan.cgColor   //边框颜色(CGColor)
        //加载 请求
        let Url_request = URL.init(string: "https://www.baidu.com")
        let request = URLRequest.init(url: Url_request!)
        _webV? .loadRequest(request)
        
        
        
        let segC = UISegmentedControl.init(items: ["重新加载","向后","向前"])
        segC.frame = CGRect(x:10, y:64 ,width:UIScreen.main.bounds.size.width - 2*10, height:30)
        self.view .addSubview(segC)
        segC .addTarget(self, action: #selector(chozTheItemOfSegC), for: UIControlEvents.valueChanged)
        
    }
    
    func chozTheItemOfSegC(segC: UISegmentedControl) {
        switch segC.selectedSegmentIndex {
        case 0: //重新加载
            _webV? .reload()  //重新加载
            break
        case 1: //向后
            _webV? .goBack()      //向后

            break
        case 2: //向前
             _webV? .goForward()   //向前
            break
        default:
            break
        }
        
        
        segC.selectedSegmentIndex = -1;//(segC默认都不选)小于0即可
    }
    //MARK:UIWebViewDelegate
    func webViewDidStartLoad(_ webView: UIWebView) {
        
    }
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        
    }
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        
        return true
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

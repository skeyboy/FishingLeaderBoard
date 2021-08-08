//
//  H5ViewController.swift
//  FishingLeaderBoard
//
//  Created by 李雨龙 on 2020/4/13.
//  Copyright © 2020 yue. All rights reserved.
//

import UIKit
let isIpad = ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.pad)
typealias AddressChoseResult = (Int, String)->Void
class H5ArticalDetailViewController: JWebViewController {
    @objc var url:String = ""
    @objc var addressChoseResult:AddressChoseResult?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
       let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate

      
//        addSyncJSFunc(functionName: "getToken", parmers: [ appDelegate.getToken()])
//        appDelegate.fetchNewLocationInfo {[weak self] (location:CLLocation?, rgcData:BMKLocationReGeocode?, error:Error?) -> Bool in
//            if let error = error, error != nil  {
//                return true
//            }
//
//            self?.addSyncJSFunc(functionName: "getAreaID", parmers:[rgcData!.adCode])
//            return true
//        }
      let data = try!  JSONSerialization.data(withJSONObject: ["x":"124","y":"345"], options: JSONSerialization.WritingOptions.fragmentsAllowed)
      let json =      String(data: data, encoding: String.Encoding.utf8)
        addSyncJSFunc(functionName: "shareLocation", parmers: [json!])
        
     let tokenData = try!  JSONSerialization.data(withJSONObject: ["token":appDelegate.getToken()], options: JSONSerialization.WritingOptions.fragmentsAllowed)
        
        addSyncJSFunc(functionName: "manualGetToken", parmers: [String(data: tokenData, encoding: String.Encoding.utf8)!])
        addAsyncJSFunc(functionName: "shareAction", parmers: ["title","content","url"]) { (value) in
            
        }
        addAsyncJSFunc(functionName: "popBack", parmers: []) { [weak self](dict:[String : AnyObject]) in
            if let nav = self?.navigationController {
                nav.popViewController(animated: true)
            }
        }
        addAsyncJSFunc(functionName: "look", parmers: ["spotid","type"]) { (dic) in
            DispatchQueue.main.async {
                let vc = EnrollGameNewViewController()
                vc.eventId  = dic["spotid"] as! Int
                vc.isAct = (dic["type"] as! Int) == 1
                vc.hidesBottomBarWhenPushed = true
                self.navigationController?.pushViewController(vc, animated: true)
                
            }
        }
        addAsyncJSFunc(functionName: "refreshToken", parmers: []) { (dic) in
            DispatchQueue.main.async {
                
                let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
                var rootVc = appDelegate.window.rootViewController
                var topVc:UIViewController?
                if rootVc is UINavigationController {
                    topVc =  (rootVc as! UINavigationController).topViewController
                }else{
                    topVc = rootVc
                }
                
                var navVC = UINavigationController.init(rootViewController: LoginAndRegisterViewController())
                navVC.navigationBar.isHidden = true
                appDelegate.reLoginNav = navVC
                topVc!.present(navVC, animated: true) {
                    
                }
            }
        }
        addAsyncJSFunc(functionName: "pushToFishSpot", parmers: ["spotId"]) { (dic) in
            DispatchQueue.main.async {
            let vc = DiaoChangDetailViewController()
                vc.spotId = dic["spotId"] as! Int
                vc.hidesBottomBarWhenPushed = true
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
        addAsyncJSFunc(functionName: "selectAddressDetail", parmers: ["id","address"]) { (dic:[String : AnyObject]) in
            if let result = self.addressChoseResult{
                result(dic["id"] as! Int, dic["address"] as! String)
            }
        }
        addAsyncJSFunc(functionName: "pushToGoodsDetail", parmers: ["goodsID"]) { (dic:[String : AnyObject]) in
            DispatchQueue.main.async {
                                 let vc = FGoodsDetailViewController()
                vc.goodsId = dic["goodsID"] as! Int
                
                                 vc.hidesBottomBarWhenPushed = true
                                 self.navigationController?.pushViewController(vc
                                     , animated: true)

                             }
        }
               //跳转积分商城
               addAsyncJSFunc(functionName: "pushToEventList", parmers: []) { (dict) in
                   DispatchQueue.main.async {
                       let vc = IntegralMallViewController()
                       vc.hidesBottomBarWhenPushed = true
                       self.navigationController?.pushViewController(vc
                           , animated: true)

                   }
               }
        
        //跳转赛事活动
        addAsyncJSFunc(functionName: "pushToEventList", parmers: []) { (dict) in
            DispatchQueue.main.async {
                let vc = SaiShiAndHuoDongTableViewController()
                vc.hidesBottomBarWhenPushed = true
                self.navigationController?.pushViewController(vc
                    , animated: true)

            }
        }
        //h5内部请求调准native的下一个h5页面
        addAsyncJSFunc(functionName: "pushNextH5", parmers: ["url"]) { (dic) in
            DispatchQueue.main.async {
            let h5VC = H5ArticalDetailViewController()
                h5VC.hidesBottomBarWhenPushed = true
                h5VC.url = dic["url"] as! String
                
                self.navigationController?.pushViewController(h5VC
                    , animated: true)
                
                
            }
        }
        
        
        //H5分享
        addAsyncJSFunc(functionName: "articleShare", parmers: ["webpageUrl","title","desc","thubnailUrl"]) {[weak self] (dict:[String : AnyObject]) in
            
            DispatchQueue.main.async {
                
                if (  YuWeChatShareManager.isWXAppInstalled()) {
                    let shareVC = UIAlertController(title: "分享", message: "选择您的分享方式", preferredStyle: isIpad ? .alert : .actionSheet )
                    var type = UInt(0)
                    for item in ["微信好友","朋友圈"] {
                        let action = UIAlertAction(title: item, style: UIAlertAction.Style.default) { (ac) in
                            
                            let thubnailUrl: String? = dict["thubnailUrl"] as? String
                            
                            
                            var image = UIImage.init(named: "logo")
                            
                            if (thubnailUrl == nil || thubnailUrl == "undefined") == false     {
                                image = UIImage.init(data: try! Data(contentsOf: URL.init(string: thubnailUrl! )!))
                            }
                            
                            YuWeChatShareManager.shareToWechat(withWebTitle: dict["title"] as! String,
                                                               description: dict["desc"] as! String, thumbImage: image!, webpageUrl: dict["webpageUrl"] as! String, type: type)
                            type = type + 1
                        }
                        shareVC.addAction(action)
                    }
                    
                    shareVC.addAction(UIAlertAction(title: "取消", style: UIAlertAction.Style.default, handler: { (ac) in
                        
                    }))
                    self?.present(shareVC,
                                  animated: true,
                                  completion: {
                                    
                    })
                }
            }
        }
//        url = Bundle.main.path(forResource: "index", ofType: "html")!
//        var uRL = URL.init(fileURLWithPath: url)
       var   uRL = URL.init(string: url)!
        startUrl(uRL)
    }

}

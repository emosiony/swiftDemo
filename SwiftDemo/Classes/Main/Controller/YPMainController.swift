//
//  YPMainController.swift
//  SwiftDemo
//
//  Created by Jtg_yao on 2019/5/20.
//  Copyright © 2019 jzg. All rights reserved.
//

import UIKit

class YPMainController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "首页"
        // Do any additional setup after loading the view.
        
        YPHttpClientTool.sharedInstance.GET(url: "", params: ["positionId": 101], success: { (responseData : Dictionary<String, Any>) in
            
            let code    : Int    = responseData["errorCode"] as! Int
            let message : String = responseData["message"] as! String
            let result  : Array<Any>  = responseData["result"] as! Array<Any>

            if code == 200 {
                print(result , message)
            } else {
                print(message)
            }
        }) { (error : Error) in
            print(error)
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

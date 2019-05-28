//
//  YPHttpClientTool.swift
//  SwiftDemo
//
//  Created by Jtg_yao on 2019/5/28.
//  Copyright © 2019 jzg. All rights reserved.
//

import UIKit
import Alamofire

public typealias HttpSuccess = (_ result : Dictionary<String, Any>) ->()
public typealias HttpFailure = (_ error : Error) ->()

class YPHttpClientTool: NSObject {
    
    let sessionManager = Alamofire.SessionManager.default
    let headers        = Alamofire.SessionManager.defaultHTTPHeaders

    static var sharedInstance : YPHttpClientTool {
        struct Static {
            static let instance : YPHttpClientTool = YPHttpClientTool()
        }
        return Static.instance
    }
    
    func GET_ParamsNil(url: String, success:@escaping HttpSuccess, failure:@escaping HttpFailure) {
        
        GET(url: url, params: [:], success: success, failure: failure)
    }
    
    func GET(url: String, params: Dictionary<String, Any> , success:@escaping HttpSuccess, failure:@escaping HttpFailure) {
        
        assert(url.count <= 0, "Rquest URL not nil")
        
        sessionManager.request(url, method: HTTPMethod.get, parameters: params, encoding: URLEncoding.methodDependent, headers: headers).responseJSON { (response) in
            
            if (response.error == nil) {
                success((response.value as? Dictionary<String, Any>)!)
            } else {
                failure(response.error!)
            }
        }
    }

    func POST_ParamsNil(url: String, success:@escaping HttpSuccess, failure:@escaping HttpFailure) {
        POST(url: url, params: [:], success: success, failure: failure)
    }
    
    func POST(url: String, params: Dictionary<String, Any>, success:@escaping HttpSuccess, failure:@escaping HttpFailure) {
        sessionManager.request(url, method: HTTPMethod.post, parameters: params, encoding: URLEncoding.methodDependent, headers: headers).responseJSON { (response) in
            if (response.error == nil) {
                success((response.value as? Dictionary<String, Any>)!)
            } else {
                failure(response.error!)
            }
        }
    }
    
    func POST_JSON(url: String, params: Dictionary<String, Any>, success:@escaping HttpSuccess, failure:@escaping HttpFailure) {
        
        sessionManager.request(url, method: HTTPMethod.post, parameters: params, encoding: JSONEncoding.default, headers: headers).responseJSON { (response) in
            
            if (response.error == nil) {
                success((response.value as? Dictionary<String, Any>)!)
            } else {
                failure(response.error!)
            }
        }
    }
}

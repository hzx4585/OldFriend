//
//  Global.swift
//  OldFriend
//
//  Created by 黄之信 on 17/3/30.
//  Copyright © 2017年 MichaelHuang. All rights reserved.
//

import Foundation

// 检测手机号
func check(phoneNumber: String) -> Bool {
    if phoneNumber.characters.count == 0 {
        return false
    }
    let mobile = "^(13[0-9]|15[0-9]|18[0-9]|17[0-9]|147)\\d{8}$"
    let regexMobile = NSPredicate(format: "SELF MATCHES %@",mobile)
    if regexMobile.evaluate(with: phoneNumber) == true {
        return true
    } else {
        return false
    }
}

// 发送验证码
func sendVerificationCode(phoneNumber: Int) -> Int{
    var result = 1
    print("发送验证码")
    let globalQueue = DispatchQueue.global()
    let semaphore = DispatchSemaphore(value: 0)
    globalQueue.async {
        let url: NSURL = NSURL(string: "http://180.76.173.200:9999/regist/verification-send.do?phone=\(phoneNumber)")!
        let request: URLRequest = URLRequest(url: url as URL)
        let session: URLSession = URLSession.shared
        let dataTask: URLSessionDataTask = session.dataTask(with: request, completionHandler: { (data, reponse, error) in
            if (error == nil) {
                var dict:NSDictionary? = nil
                do {
                    dict  = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.init(rawValue: 0)) as? NSDictionary
                } catch {
                    
                }
                print(dict ?? "no value")
                result = dict?["ret"] as! Int
            }
            else {
                print(error)
            }
            semaphore.signal()
        })
        dataTask.resume()
    }
    _ = semaphore.wait(timeout: DispatchTime.distantFuture)
//    print("result%%%%%%%")
//    print(result)
    return result
}

// 检测两次密码是否相同
func checkTwoPasswordWhetherSame(firstPassword: String, secondPassword: String) -> Bool {
    return (firstPassword == secondPassword)
}

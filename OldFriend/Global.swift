//
//  Global.swift
//  OldFriend
//
//  Created by 黄之信 on 17/3/30.
//  Copyright © 2017年 MichaelHuang. All rights reserved.
//

import Foundation

// 检测手机号
// true 手机号正确
// false 手机号错误
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
func sendVerificationCode(phoneNumber: Int) -> NSDictionary{
    var result: NSDictionary = [:]
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
                result = dict!
            }
            else {
                print(error!)
            }
            semaphore.signal()
        })
        dataTask.resume()
    }
    _ = semaphore.wait(timeout: DispatchTime.distantFuture)
    return result as NSDictionary
}

// 检测验证码
func checkVerificationCodeGolobal(verificationCode: String) -> Int {
    var result = 1
    let globalQueue = DispatchQueue.global()
    let semaphore = DispatchSemaphore(value: 0)
    globalQueue.async {
        let url: NSURL = NSURL(string: "http://180.76.173.200:9999/regist/is-verification-right.do?verification=" + verificationCode)!
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
                print(error!)
            }
            semaphore.signal()
        })
        dataTask.resume()
    }
    _ = semaphore.wait(timeout: DispatchTime.distantFuture)
    return result
}

// 注册设置密码
func setPasswordForRegister(firstPassword: String, secondPassword: String) -> Int {
    var result = 1
    
    let semaphore = DispatchSemaphore(value: 0)
    //1.创建会话对象
    let session: URLSession = URLSession.shared
    
    //2.根据会话对象创建task
    let url: NSURL = NSURL(string: "http://180.76.173.200:9999/regist/password-set.do")!
    
    //3.创建可变的请求对象
    let request: NSMutableURLRequest = NSMutableURLRequest(url: url as URL)
    
    //4.修改请求方法为POST
    request.httpMethod = "POST"
    
    //5.设置请求体
    request.httpBody = "password1=\(firstPassword)&password2=\(secondPassword)".data(using: String.Encoding.utf8)
    
    //6.根据会话对象创建一个Task(发送请求）
    /*
     第一个参数：请求对象
     第二个参数：completionHandler回调（请求完成【成功|失败】的回调）
     data：响应体信息（期望的数据）
     response：响应头信息，主要是对服务器端的描述
     error：错误信息，如果请求失败，则error有值
     */
    let dataTask: URLSessionDataTask = session.dataTask(with: request as URLRequest) { (data, response, error) in
        
        if(error == nil){
            //8.解析数据
            //说明：（此处返回的数据是JSON格式的，因此使用NSJSONSerialization进行反序列化处理）
            var dict:NSDictionary? = nil
            do {
                dict  = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.init(rawValue: 0)) as? NSDictionary
            } catch {
                
            }
            print(dict ?? "no value")
            result = dict?["ret"] as! Int
        }
        else {
            print(error!)
        }
        semaphore.signal()
    }
    //5.执行任务
    dataTask.resume()
    _ = semaphore.wait(timeout: DispatchTime.distantFuture)
    return result
}

// 老友账号登录
func oldFriendAccountLogin(phone: String, password: String) -> NSDictionary {
    var result: NSDictionary = [:]
    let globalQueue = DispatchQueue.global()
    let semaphore = DispatchSemaphore(value: 0)
    globalQueue.async {
        let url: NSURL = NSURL(string: "http://180.76.173.200:9999/login/login.do?phone=\(phone)&password=\(password)")!
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
                result = dict!
            }
            else {
                print(error!)
            }
            semaphore.signal()
        })
        dataTask.resume()
    }
    _ = semaphore.wait(timeout: DispatchTime.distantFuture)
    return result as NSDictionary
}

// 手机号快捷登录发送验证码
func mobileLoginSendVerificationCode(phone: String) -> NSDictionary {
    var result: NSDictionary = [:]
    let globalQueue = DispatchQueue.global()
    let semaphore = DispatchSemaphore(value: 0)
    globalQueue.async {
        let url: NSURL = NSURL(string: "http://180.76.173.200:9999/regist/verification-send.do?phone=\(phone)")!
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
                result = dict!
            }
            else {
                print(error!)
            }
            semaphore.signal()
        })
        dataTask.resume()
    }
    _ = semaphore.wait(timeout: DispatchTime.distantFuture)
    return result as NSDictionary
}


// 手机号快捷登录
func mobileLogin(phone: String, verification: String) -> NSDictionary {
    var result: NSDictionary = [:]
    let globalQueue = DispatchQueue.global()
    let semaphore = DispatchSemaphore(value: 0)
    globalQueue.async {
        let url: NSURL = NSURL(string: "http://180.76.173.200:9999/login/login-quick.do?phone=\(phone)&verification=\(verification)")!
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
                result = dict!
            }
            else {
                print(error!)
            }
            semaphore.signal()
        })
        dataTask.resume()
    }
    _ = semaphore.wait(timeout: DispatchTime.distantFuture)
    return result as NSDictionary
}

// 检测两次密码是否相同
func checkTwoPasswordWhetherSame(firstPassword: String, secondPassword: String) -> Bool {
    return (firstPassword == secondPassword)
}

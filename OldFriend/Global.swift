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
func sendVerificationCode() {
    print("发送验证码")
}

func checkTwoPasswordWhetherSame(firstPassword: String, secondPassword: String) -> Bool {
    return (firstPassword == secondPassword)
}

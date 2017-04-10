//
//  FindPasswordPhoneNumberTableViewController.swift
//  OldFriend
//
//  Created by 黄之信 on 17/3/29.
//  Copyright © 2017年 MichaelHuang. All rights reserved.
//

import UIKit

class FindPasswordPhoneNumberTableViewController: UITableViewController {
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var verificationCodeTextField: UITextField!
    @IBOutlet weak var changeVerificationCodeButton: UIButton!
    @IBOutlet weak var verificationImageView: UIImageView!
    
    private func fetchImage() {
        let imageURL = NSURL(string: "http://180.76.173.200:9999/image-verification/generator.do?")
        let url = imageURL
        DispatchQueue.global(qos: .userInitiated).async {
            let imageData = NSData(contentsOf: url as! URL)
            DispatchQueue.main.async {
                if imageData != nil {
                    self.verificationImageView.image = UIImage(data: imageData! as Data) //这里也和UI有关 要放到main里面
                } else {
                    self.verificationImageView = nil
                }
            }
        }
    }
    
    @IBAction func nextStepButtonTapped(_ sender: UIButton) {
        let result = verificationCodeSendAfterImageCheck(phone: phoneTextField.text!, verification: verificationCodeTextField.text!)
        if (result["ret"] as! Int == 0) {
            self.performSegue(withIdentifier: "findPasswordSendVerificationSegue", sender: self)
        }
        else {
            print ("Something wrong")
        }
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        return false
    }
    
    @IBAction func changeVerificationCodeButtonTapped(_ sender: UIButton) {
        fetchImage()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchImage()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        changeVerificationCodeButton.layer.borderWidth = 1
        changeVerificationCodeButton.layer.borderColor = UIColor(red: 240.0/255.0, green:
            138.0/255.0, blue: 140.0/255.0, alpha: 1.0).cgColor
        navigationController?.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        self.tableView.isScrollEnabled = false
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 2
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.0001
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.0001
    }
}

//
//  LoginViewController1.swift
//  常用模式
//
//  Created by ShareAnimation on 2018/1/17.
//  Copyright © 2018年 爱丽丝的梦境. All rights reserved.
//

import UIKit

class LoginViewController1: UIViewController {
    
    //标题
    fileprivate var headerLabel: UILabel = {
        let label = UILabel()
        label.text = "登 入"
        label.font = UIFont.boldSystemFont(ofSize: 36)
        
        return label
    }()
    
    //用户名
    fileprivate var usernameTextFiled:UITextField = {
        let textField = UITextField()
        textField.font = UIFont.systemFont(ofSize: 22)
        textField.placeholder = "请输入手机号码"
        textField.clearButtonMode = .always
        textField.keyboardType = .numberPad
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
        textField.returnKeyType = .next
        
        return textField
    }()
    
    //密码
    fileprivate var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.font = UIFont.systemFont(ofSize: 22)
        textField.placeholder = "请输入密码"
        textField.clearButtonMode = .always
        textField.keyboardType = .asciiCapable
        textField.isSecureTextEntry = true
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
        textField.returnKeyType = .done
        return textField
    }()
    
    //登录
    fileprivate var loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("登录", for: .normal)
        button.backgroundColor = colorWith255RGB(230, g: 230, b: 230)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 22)
        button.layer.cornerRadius = 8.0
        
        return button
    }()
    
    //忘记密码
    fileprivate var forgetPasswordButton:UIButton = {
        let button = UIButton()
        button.setTitle("忘记密码?", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        button.setTitleColor(UIColor.gray, for: .normal)
        return button
    }()
    
    fileprivate lazy var closeButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(doCloseButtonAction), for: .touchUpInside)
        button.setImage(UIImage.init(named: "关闭-2"), for: .normal)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.view.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(doTapViewAction)))

        self.setupViews()
    }
    
    func setupViews() {
        self.view.addSubview(self.headerLabel)
        self.headerLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.view)
            make.top.equalTo(self.view).offset(180)
        }
        
        self.view.addSubview(self.usernameTextFiled)
        self.usernameTextFiled.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.view)
            make.top.equalTo(self.headerLabel.snp.bottom).offset(40)
            make.left.equalTo(self.view).offset(35)
            make.right.equalTo(self.view).offset(-35)
            make.height.equalTo(35)
        }
        
        let usernameGrayLine = UIView()
        usernameGrayLine.backgroundColor = colorWith255RGB(242, g: 242, b: 242)
        self.view.addSubview(usernameGrayLine)
        usernameGrayLine.snp.makeConstraints { (make) in
            make.left.right.equalTo(self.usernameTextFiled)
            make.top.equalTo(self.usernameTextFiled.snp.bottom)
            make.height.equalTo(1.5)
        }
        
        self.view.addSubview(self.passwordTextField)
        self.passwordTextField.snp.makeConstraints { (make) in
            make.left.right.equalTo(usernameGrayLine)
            make.top.equalTo(usernameGrayLine.snp.bottom).offset(25)
            make.height.equalTo(self.usernameTextFiled)
        }
        
        let passworddGrayLine = UIView()
        passworddGrayLine.backgroundColor = usernameGrayLine.backgroundColor
        self.view.addSubview(passworddGrayLine)
        passworddGrayLine.snp.makeConstraints { (make) in
            make.left.right.equalTo(self.passwordTextField)
            make.top.equalTo(self.passwordTextField.snp.bottom)
            make.height.equalTo(usernameGrayLine)
        }
        
        self.view.addSubview(self.loginButton)
        self.loginButton.snp.makeConstraints { (make) in
            make.left.right.equalTo(passworddGrayLine)
            make.top.equalTo(passworddGrayLine.snp.bottom).offset(35)
            make.height.equalTo(45)
        }
        
        self.view.addSubview(self.forgetPasswordButton)
        self.forgetPasswordButton.snp.makeConstraints { (make) in
            make.left.equalTo(self.loginButton)
            make.top.equalTo(self.loginButton.snp.bottom).offset(20)
        }
        
        self.view.addSubview(self.closeButton)
        self.closeButton.snp.makeConstraints { (make) in
            make.right.equalTo(self.view).offset(-20)
            make.top.equalTo(self.view).offset(40)
            make.height.width.equalTo(25)
        }
    }
    
    @objc func doTapViewAction() {
        self.view.endEditing(true)
    }
    
    @objc func doCloseButtonAction() {
        self.dismiss(animated: true, completion: nil)
    }
}

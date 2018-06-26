//
//  ViewController.swift
//  MCTextView
//
//  Created by MC on 2018/6/26.
//  Copyright © 2018年 MC. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let width = self.view.frame.size.width
        
        
        textView.frame = CGRect.init(x: 10, y: 100, width: width - 20, height: 100)
        view.addSubview(textView)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }


    lazy var textView: MCTextView = {
        let view = MCTextView()
        view.textView.font = UIFont.systemFont(ofSize: 16)
        view.limitCount = 200
        view.placeholder = "请输入内容"
        view.returnKeyType = MCReturnKeyType.done
        view.backgroundColor = UIColor.init(white: 0.8, alpha: 1)
        return view
    }()
}


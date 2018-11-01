//
//  MCTextView.swift
//  WisdomSpace
//
//  Created by goulela on 2017/9/18.
//  Copyright © 2017年 MC. All rights reserved.
//

import UIKit


/**
 * 继续完善
 * 点击完成按钮的回调
 * 根据行高自动增高
*/

enum MCReturnKeyType {
    case done      // 完成按钮，点击收起键盘
    case newline   // 换行按钮，点击换行处理
}

class MCTextView: UIView {

    
    /**
     * limitCount
     * 小于等于0的时候，不做任何字数限制
     * 大于0的时候，对字数进行限制
     */
    public var limitCount = 0 {
        didSet {
            if limitCount <= 0 {
                limitCountLabel.isHidden = true
            } else {
                limitCountLabel.isHidden = false
                limitCountLabel.text = "0/\(limitCount)"
            }
        }
    }
    
    public var placeholder = "" {
        didSet {
            placeholderLabel.text = placeholder
        }
    }
    
    
    public var text = "" {
        didSet {
            textView.text = text
            
            if text.isEmpty {
                placeholderLabel.isHidden = false
                limitCountLabel.text = "0/\(limitCount)"

            } else {
                placeholderLabel.isHidden = true
                limitCountLabel.text = "\(text.count)/\(limitCount)"
            }
            
        }
    }
    
    
    public var font : UIFont = UIFont.systemFont(ofSize: 15) {
        didSet {
            textView.font = font
            placeholderLabel.font = font
        }
    }
    

    /**
     * returnKeyType
     * 右下角按钮，是换行还是确定
     */
    public var returnKeyType : MCReturnKeyType? = MCReturnKeyType.newline {
        didSet {
            
            
            if returnKeyType == MCReturnKeyType.done {
                textView.returnKeyType = UIReturnKeyType.done
            } else {
                textView.returnKeyType = UIReturnKeyType.default
            }
        }
    }
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(placeholderLabel)
        self.addSubview(limitCountLabel)
        self.addSubview(textView)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.placeholderLabel.font = textView.font

        
        textView.frame = CGRect.init(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height)
        

        placeholderLabel.frame = CGRect.init(x: 5, y: 5, width: 0, height: 0)
        placeholderLabel.sizeToFit()
        
        
        let width = self.frame.size.width
        let height = self.frame.size.height

        let size = CGSize.init(width: 60, height: 12)
        
        
        limitCountLabel.frame = CGRect.init(x: width - size.width - 5, y: height - size.height - 5, width: size.width, height: size.height)

    }
    
    // 字符串的截取 从头截取到指定index
    private func MCString_prefix(index:Int,text:String) -> String {
        if text.count <= index {
            return text
        } else {
            let index = text.index(text.startIndex, offsetBy: index)
            let str = text.prefix(upTo: index)
            return String(str)
        }
    }

    

    // MARK: 懒加载
    private lazy var placeholderLabel: UILabel = {
        let label = UILabel()
        label.text = "请输入"
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor.init(red: 72/255.0, green: 82/255.0, blue: 93/255.0, alpha: 1)
        return label
    }()
    
    private lazy var textView: UITextView = {
        let view = UITextView()
        view.delegate = self
        view.font = UIFont.systemFont(ofSize: 14)
        view.backgroundColor = UIColor.clear
        view.autocorrectionType = UITextAutocorrectionType.no  // 取消联想功能
        return view
    }()
    
    private lazy var limitCountLabel: UILabel = {
        let label = UILabel()
        label.text = "0/\(limitCount)"
        label.isHidden = true
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor.init(red: 72/255.0, green: 82/255.0, blue: 93/255.0, alpha: 1)
        label.textAlignment = NSTextAlignment.right
        return label
    }()

}


extension MCTextView : UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        if textView.text.count > limitCount {
            
            //获得已输出字数与正输入字母数
            let selectRange = textView.markedTextRange
            
            //获取高亮部分 － 如果有联想词则解包成功
            if let selectRange = selectRange {
                let position =  textView.position(from: (selectRange.start), offset: 0)
                if (position != nil) {
                    return
                }
            }
            
            let textContent = textView.text ?? ""
            let textNum = textContent.count
            
            //截取
            if textNum > limitCount && limitCount > 0 {
                textView.text = MCString_prefix(index: limitCount, text: textContent)
            }
        }
        
        self.limitCountLabel.text =  "\(textView.text.count)/\(limitCount)"
    }

    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        self.placeholderLabel.isHidden = true
        return true
    }

    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            self.placeholderLabel.isHidden = false
        } else {
            self.placeholderLabel.isHidden = true
        }
    }

    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        if returnKeyType == MCReturnKeyType.done {
            if text == "\n"{
                textView.resignFirstResponder()
            }

            return true
        }
        return true
    }
}

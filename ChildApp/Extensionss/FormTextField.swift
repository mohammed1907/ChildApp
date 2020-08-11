//
//  FormTextField.swift
//  Saydaly
//
//  Created by Farghaly
//  Copyright © 2020 Phantasm. All rights reserved.
//

import UIKit

@IBDesignable
class FormTextField: UITextField {

    var showError: Bool = false
    
    let errorLabel: UILabel = UILabel()
    let titleLabel: UILabel = UILabel()
    
    @IBInspectable var rightIcon: UIImage? {
        
        didSet {
            rightViewMode = .always
            rightView = UIImageView(image: rightIcon)
        }
    }
    
    override func layoutSubviews() {
        
        super.layoutSubviews()

        bringSubviewToFront(titleLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        // custom setup
        setupUI()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // custom setup
        setupUI()
    }
    
    func setupUI() -> Void {
        addTarget(self, action: #selector(editingChanged), for: .editingChanged)
        
        errorLabel.frame = CGRect(x: 10, y: frame.size.height - 18, width: frame.size.width, height: 18)
        errorLabel.textColor = UIColor.red
        errorLabel.font =  UIFont.systemFont(ofSize: 12.0)
        addSubview(errorLabel)
    }
    
    override var placeholder: String?{
        didSet{
            if placeholder != oldValue {
                placeholder = oldValue
                titleLabel.text = oldValue
            }
        }
    }
    
//    override func didMoveToSuperview() {
//
//        super.didMoveToSuperview()
//        let labelFont = UIFont.systemFont(ofSize: 14.0)
//
//        titleLabel.frame = CGRect(x: frame.origin.x + 5, y: frame.origin.y - 5, width: (placeholder?.size(withAttributes:[.font:labelFont]).width)!, height: 10)
//        titleLabel.textColor = borderColor
//        titleLabel.alpha = 0
//        titleLabel.backgroundColor = UIColor.white
//        titleLabel.font =  labelFont
//        superview?.addSubview(titleLabel)
//        titleLabel.text = placeholder
//        superview?.bringSubviewToFront(titleLabel)
//    }
////     Only override draw() if you perform custom drawing.
////     An empty implementation adversely affects performance during animation.
//    override func draw(_ rect: CGRect) {
//        // Drawing code
//        borderStyle = .none
//
//        let bottomBorder = CALayer.init()
//        bottomBorder.frame = CGRect(x: 0.0,y: rect.size.height - 1,width: rect.size.width,height: 0.5)
//        bottomBorder.backgroundColor = UIColor.lightGray.cgColor
//        layer.addSublayer(bottomBorder)
//        super.draw(rect)
//    }
//
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        var newBounds = bounds
        newBounds.origin.x += 10
        return newBounds
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        var newBounds = bounds
        newBounds.origin.x += 10
        return newBounds
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        var newBounds = bounds
        newBounds.origin.x += 10
        return newBounds
    }
    
    func showError(message: String) {
        if message.count > 0 {
            errorLabel.isHidden = false
            errorLabel.text = message
            textColor = UIColor.red
            setNeedsDisplay()
        }
    }
    
    @objc func editingChanged() {
        hideErrorMessage()
        if let str = text {
            if str.count > 0 {
                titleLabel.text = placeholder
                titleLabel.alpha = 1
            }
            else {
                titleLabel.text = ""
                titleLabel.alpha = 0
            }
        }
    }
    
    func hideErrorMessage() {
        errorLabel.isHidden = true
        errorLabel.text = ""
        textColor = UIColor.gray
        setNeedsDisplay()
    }
 

}

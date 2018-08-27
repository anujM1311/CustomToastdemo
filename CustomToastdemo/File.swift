//
//  File.swift
//  CustomToastdemo
//
//  Created by Vikash Kumar Sahu on 21/08/18.
//  Copyright © 2018 Vikash Kumar Sahu. All rights reserved.
//

import Foundation
import UIKit

//MARK: Add Toast method function in UIView Extension so can use in whole project.
extension UIView
{
    func showToast(toastMessage:String,duration:CGFloat)
    {
        //View to blur bg and stopping user interaction
        let bgView = UIView(frame: self.frame)
        bgView.backgroundColor = UIColor(red: CGFloat(255.0/255.0), green: CGFloat(255.0/255.0), blue: CGFloat(255.0/255.0), alpha: CGFloat(0.6))

        bgView.tag = 555
        
        //Label For showing toast text
        let lblMessage = UILabel()
        lblMessage.numberOfLines = 0
        lblMessage.lineBreakMode = .byWordWrapping
        lblMessage.textColor = .white
        lblMessage.backgroundColor = UIColor(red: 217.0/255.0, green: 56.0/255.0, blue: 56.0/255.0, alpha: 1.0)
        lblMessage.textAlignment = .left
        lblMessage.font = UIFont.init(name: "NunitoSans", size: 14)
        lblMessage.text = toastMessage
        
        //calculating toast label frame as per message content
        let maxSizeTitle : CGSize = CGSize(width: self.bounds.size.width - 88, height: self.bounds.size.height)
        
        var expectedSizeTitle : CGSize = lblMessage.sizeThatFits(maxSizeTitle)
        
        print(expectedSizeTitle.width)
        
        print(expectedSizeTitle.height)
        
        // UILabel can return a size larger than the max size when the number of lines is 1
        expectedSizeTitle = CGSize(width: self.bounds.size.width-16/*maxSizeTitle.width.getminimum(value2:expectedSizeTitle.width)*/, height: maxSizeTitle.height.getminimum(value2:expectedSizeTitle.height))
        
        print("height == \(self.bounds.size.height)")
        print("expectedSizeTitle == \(expectedSizeTitle.height+24)")
        
        bgView.frame = CGRect(x:((self.bounds.size.width)/2) - ((expectedSizeTitle.width - 16)/2), y: (self.bounds.size.height) - (expectedSizeTitle.height+16) - 56, width: expectedSizeTitle.width - 16 , height: expectedSizeTitle.height + 36)
        
        print("ViewFrame------\(bgView.frame)")
        
        bgView.backgroundColor = UIColor(red: 217.0/255.0, green: 56.0/255.0, blue: 56.0/255.0, alpha: 1.0)
        bgView.layer.cornerRadius = 5.0
        bgView.layer.masksToBounds = true
        
        lblMessage.frame = CGRect(x:16, y: expectedSizeTitle.height/2 + 8, width: expectedSizeTitle.width-40, height: expectedSizeTitle.height)
        lblMessage.layer.cornerRadius = 8
        lblMessage.layer.masksToBounds = true
       // lblMessage.padding = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        
        print("Lbl Frame:- \(lblMessage.frame)")
        
        let myFirstButton = UIButton()
        myFirstButton.frame = CGRect(x: bgView.frame.size.width - 27, y: (bgView.frame.size.height/2) - 8, width: 16, height: 16)
      //  myFirstButton.frame = CGRectMake(bgView.frame.size.width - 20, (bgView.frame.size.height/2) - 10, 20, 20)
       // myFirstButton.backgroundColor = UIColor
        myFirstButton.setBackgroundImage(UIImage(named: "Close Button"), for: .normal)
        bgView.addSubview(lblMessage)
        bgView.addSubview(myFirstButton)
        
        
        self.addSubview(bgView)
        lblMessage.alpha = 1
        
       
        
        
//        UIView.animateKeyframes(withDuration:TimeInterval(duration) , delay: 0, options: [] , animations: {
//            lblMessage.alpha = 1
//        }, completion: {
//            sucess in
//            UIView.animate(withDuration:TimeInterval(duration), delay: 8, options: [] , animations: {
//                lblMessage.alpha = 0
//                bgView.alpha = 0
//            })
//            bgView.removeFromSuperview()
//        })
    }
}
extension CGFloat
{
    func getminimum(value2:CGFloat)->CGFloat
    {
        if self < value2
        {
            return self
        }
        else
        {
            return value2
        }
    }
}

//MARK: Extension on UILabel for adding insets - for adding padding in top, bottom, right, left.

extension UILabel
{
    private struct AssociatedKeys {
        static var padding = UIEdgeInsets()
    }
    
    var padding: UIEdgeInsets? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.padding) as? UIEdgeInsets
        }
        set {
            if let newValue = newValue {
                objc_setAssociatedObject(self, &AssociatedKeys.padding, newValue as UIEdgeInsets!, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            }
        }
    }
    
    override open func draw(_ rect: CGRect) {
        if let insets = padding {
            self.drawText(in: UIEdgeInsetsInsetRect(rect, insets))
        } else {
            self.drawText(in: rect)
        }
    }
    
    override open var intrinsicContentSize: CGSize {
        get {
            var contentSize = super.intrinsicContentSize
            if let insets = padding {
                contentSize.height += insets.top + insets.bottom
                contentSize.width += insets.left + insets.right
            }
            return contentSize
        }
    }
}

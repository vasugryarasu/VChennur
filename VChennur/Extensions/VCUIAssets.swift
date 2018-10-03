//
//  VCUIAssets.swift
//  VChennur
//
//  Created by Vasu Yarasu on 29/09/18.
//  Copyright © 2018 iGrand. All rights reserved.
//

import Foundation
import UIKit

//class VCButton: UIButton {
//    required init?(coder aDecoder: NSCoder) {
//        
//        super.init(coder: aDecoder)
//        self.layer.cornerRadius = self.frame.size.height/2
//    }
//}

class TextField: UITextField {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        let color = UIColor.white
        let placeholderColor = UIColor.white
        guard let placeholder = self.placeholder else {return}
        self.layer.cornerRadius = self.frame.size.height/2
        self.clipsToBounds = true
        self.layer.borderColor = color.cgColor
        self.layer.borderWidth = 1
        self.textColor = color
        self.tintColor = color
        self.minimumFontSize = 17
        self.attributedPlaceholder = NSAttributedString(string: placeholder , attributes: [NSAttributedStringKey.foregroundColor: placeholderColor])
    }
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
    }
}
//class VCTextView: UITextView {
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//        self.layer.borderWidth = 0.8
//        self.layer.borderColor = UIColor(red: 170/255, green: 170/255, blue: 170/255, alpha: 0.5).cgColor
//        self.layer.cornerRadius = 10
//    }
//    override func prepareForInterfaceBuilder() {
//        super.prepareForInterfaceBuilder()
//    }
//}
class VCView: UIView {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.layer.borderWidth = 0.8
        self.layer.borderColor = UIColor(red: 170/255, green: 170/255, blue: 170/255, alpha: 0.5).cgColor
        self.layer.cornerRadius = 10
    }
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
    }
}

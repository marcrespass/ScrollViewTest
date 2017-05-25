//
//  Controls.swift
//  ScrollViewTest
//
//  Created by Marc Respass on 5/25/17.
//  Copyright © 2017 ILIOS Inc. All rights reserved.
//

import UIKit

extension UILabel {
    convenience init(fontSize: CGFloat) {
        self.init(frame: .zero)
        
        self.textAlignment = .center
        self.lineBreakMode = .byWordWrapping
        self.numberOfLines = 0
        self.baselineAdjustment = .alignBaselines
        self.contentMode = .left
        self.isOpaque = false
        self.setContentHuggingPriority(251, for: .horizontal)
        self.setContentHuggingPriority(251, for: .vertical)
        self.textColor = nil
        self.font = UIFont.systemFont(ofSize: fontSize)
    }
}

extension UIButton {
    convenience init(title: String) {
        self.init(type: .custom)
        self.titleLabel?.lineBreakMode = .byTruncatingMiddle
        self.isOpaque = false
        self.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        self.setTitleColor(UIColor(white: 1, alpha: 1), for: .normal)
        self.setTitle(title, for: .normal)
    }
}


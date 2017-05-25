//
//  OnboardEmail.swift
//  CardioVisual
//
//  Created by Marc Respass on 3/20/17.
//  Copyright © 2017 ILIOS Inc. All rights reserved.
//

import UIKit

final class OnboardEmail: UIViewController {
    // MARK: - Function Properties
    var didFinishEmail: (_ emailAddress: String) -> Void = { _ in print("\(#function) not implemented") }
    var showPrivacy: () -> Void = { _ in print("\(#function) not implemented") }
    
    // MARK: - Views
    fileprivate lazy var mainView: UIView = {
        let mainView = UIView()
        mainView.clearsContextBeforeDrawing = false
        mainView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        mainView.backgroundColor = UIColor(white: 0.667, alpha: 1)
        
        return mainView
    }()
    
    fileprivate lazy var backgroundImageView: UIImageView = {
        let backgroundImageView = UIImageView()
        backgroundImageView.image = UIImage(named: "CardioVisual-Onboard.png")
        backgroundImageView.setContentHuggingPriority(251, for: .horizontal)
        backgroundImageView.setContentHuggingPriority(251, for: .vertical)
        
        return backgroundImageView
    }()
    
    fileprivate lazy var contentView: UIView = {
        let contentView = UIView()
        contentView.backgroundColor = UIColor(white: 0.667, alpha: 1)
        
        return contentView
    }()
    
    fileprivate lazy var headerView: UIView = {
        let headerView = UIView()
        headerView.backgroundColor = UIColor(red: 0.91, green: 0.373, blue: 0.31, alpha: 1)
        
        headerView.heightAnchor == 187
        
        return headerView
    }()
    
    lazy var infoView: UIView = {
        let infoView = UIView()
        infoView.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        infoView.translatesAutoresizingMaskIntoConstraints = false
        return infoView
    }()
    
    fileprivate lazy var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "CardioVisual-logo-name")
        imageView.setContentHuggingPriority(251, for: .horizontal)
        imageView.setContentHuggingPriority(251, for: .vertical)
        imageView.widthAnchor == 80
        imageView.widthAnchor == imageView.heightAnchor
        
        return imageView
    }()

    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.isScrollEnabled = false
        scrollView.bounces = false
        scrollView.bouncesZoom = false
        scrollView.delaysContentTouches = false
        scrollView.canCancelContentTouches = false
        scrollView.keyboardDismissMode = .interactive
        scrollView.clipsToBounds = true
        
        return scrollView
    }()
    
    fileprivate lazy var titleLabel: UILabel = {
        let label = UILabel(fontSize: UIFont.systemFontSize)
        label.textColor = UIColor(white: 1, alpha: 1)
        label.text = "Comprehensive Cardiovascular Information"
        
        return label
    }()

    fileprivate lazy var shadowImage: UIImageView = {
        let shadowImage = UIImageView()
        shadowImage.image = UIImage(named: "shadow")
        shadowImage.setContentHuggingPriority(251, for: .horizontal)
        shadowImage.setContentHuggingPriority(251, for: .vertical)
        
        shadowImage.heightAnchor == 10
        
        return shadowImage
    }()

    fileprivate lazy var noButton: UIButton = {
        let button = UIButton(title: "No Thanks ▶︎")
        button.backgroundColor = UIColor(red: 0.271, green: 0.651, blue: 0.62, alpha: 1)
        button.addTarget(self, action: #selector(send(_:)), for: .touchUpInside)
        
        return button
    }()
    
    fileprivate lazy var yesButton: UIButton = {
        let button = UIButton(title: "Submit ▶︎")
        button.backgroundColor = UIColor(red: 0, green: 0.22, blue: 0.267, alpha: 1)
        button.addTarget(self, action: #selector(sendEmail(_:)), for: .touchUpInside)
        
        button.heightAnchor == 40
        
        return button
    }()
    
    fileprivate lazy var infoText1: UILabel = {
        let label = UILabel(fontSize: 23.0)
        label.text = "We would love to occasionally update you!"
        
        label.setContentHuggingPriority(251, for: .horizontal)
        label.setContentHuggingPriority(249, for: .vertical)

        return label
    }()
    
    lazy var emailField: UITextField = {
        let field = UITextField()
        field.textAlignment = .center
        field.borderStyle = .roundedRect
        field.clearButtonMode = .whileEditing
        field.minimumFontSize = 17
        field.placeholder = "Enter Your Email Address"
        field.contentHorizontalAlignment = .left
        field.isOpaque = false
        field.clipsToBounds = true
        field.textColor = nil
        field.font = .systemFont(ofSize: 17)
        field.keyboardType = .emailAddress
        field.returnKeyType = .done
        
        field.setContentHuggingPriority(251, for: .vertical)
        field.setContentCompressionResistancePriority(751, for: .vertical)

        return field
    }()
    
    fileprivate lazy var privacyPolicyButton: UIButton = {
        let button = UIButton(type: .custom)
        button.titleLabel?.lineBreakMode = .byTruncatingMiddle
        button.isOpaque = false
        button.titleLabel?.font = .systemFont(ofSize: 11)
        button.setTitle("Privacy Policy", for: .normal)
        button.setTitleColor(self.mainView.tintColor, for: .normal)

        button.addTarget(self, action: #selector(showPrivacyPolicy(_:)), for: .touchUpInside)

        return button
    }()
    
    // MARK: - Constraint Sets
    fileprivate lazy var phoneConstraints: [NSLayoutConstraint] = {
        let constraints = batch(active: false, closure: {
            self.yesButton.centerXAnchor == self.infoView.centerXAnchor
            self.yesButton.widthAnchor == self.infoView.widthAnchor
            self.yesButton.bottomAnchor == self.noButton.topAnchor
            
            self.noButton.heightAnchor == self.yesButton.heightAnchor
            self.noButton.widthAnchor == self.infoView.widthAnchor
            self.noButton.centerXAnchor == self.infoView.centerXAnchor
            self.noButton.bottomAnchor == self.infoView.bottomAnchor
        })
        return constraints
    }()
    
    fileprivate lazy var padConstraints: [NSLayoutConstraint] = {
        let constraints = batch(active: false) {
            self.noButton.widthAnchor == self.infoView.widthAnchor * 0.5
            self.noButton.heightAnchor == self.yesButton.heightAnchor
            
            self.yesButton.widthAnchor == self.noButton.widthAnchor
            
            self.infoView.trailingAnchor == self.noButton.trailingAnchor
            
            self.noButton.leadingAnchor == self.yesButton.trailingAnchor
            self.infoView.bottomAnchor == self.noButton.bottomAnchor
            self.infoView.bottomAnchor == self.yesButton.bottomAnchor
            self.yesButton.leadingAnchor == self.infoView.leadingAnchor
            
        }
        return constraints
    }()
}

// MARK: - View Setup
extension OnboardEmail {
    override func loadView() {
        // Assemble View Hierarchy
        mainView.addSubview(backgroundImageView)
        mainView.addSubview(contentView)
        contentView.addSubview(headerView)

        headerView.addSubview(iconImageView)
        headerView.addSubview(shadowImage)
        headerView.addSubview(titleLabel)

        contentView.addSubview(scrollView)
        scrollView.addSubview(infoView)
        infoView.addSubview(noButton)
        infoView.addSubview(yesButton)
        infoView.addSubview(infoText1)
        infoView.addSubview(emailField)
        infoView.addSubview(privacyPolicyButton)
        
        self.view = mainView
        self.configureConstraints()
    }
    
    func configureConstraints() {
        backgroundImageView.centerXAnchor == mainView.centerXAnchor
        backgroundImageView.heightAnchor == mainView.heightAnchor
        backgroundImageView.widthAnchor == mainView.widthAnchor
        backgroundImageView.centerYAnchor == mainView.centerYAnchor
        
        let inset = UIDevice.current.userInterfaceIdiom == .pad ? 100.0 : 20.0
        contentView.topAnchor == mainView.topAnchor + inset
        contentView.bottomAnchor == mainView.bottomAnchor - inset
        contentView.leadingAnchor == mainView.leadingAnchor + inset
        contentView.trailingAnchor == mainView.trailingAnchor - inset
        
        headerView.topAnchor == contentView.topAnchor
        headerView.leadingAnchor == contentView.leadingAnchor
        headerView.trailingAnchor == contentView.trailingAnchor
        headerView.bottomAnchor == infoView.topAnchor
        
        infoView.leadingAnchor == contentView.leadingAnchor
        infoView.trailingAnchor == contentView.trailingAnchor
        infoView.bottomAnchor == contentView.bottomAnchor
        
        if UIDevice.current.userInterfaceIdiom == .phone {
            NSLayoutConstraint.activate(self.phoneConstraints)
        } else {
            NSLayoutConstraint.activate(self.padConstraints)
        }
        
        iconImageView.topAnchor == headerView.topAnchor + 20
        iconImageView.centerXAnchor == headerView.centerXAnchor
        
        shadowImage.topAnchor == iconImageView.bottomAnchor + 8
        shadowImage.widthAnchor == iconImageView.heightAnchor * 2/3
        shadowImage.centerXAnchor == iconImageView.centerXAnchor
        
        titleLabel.widthAnchor == headerView.widthAnchor - 16
        titleLabel.centerXAnchor == headerView.centerXAnchor
        titleLabel.topAnchor == shadowImage.bottomAnchor + 8
        
        infoText1.topAnchor == infoView.topAnchor + 20
        infoText1.centerXAnchor == infoView.centerXAnchor
        infoText1.widthAnchor == infoView.widthAnchor - 20

        emailField.widthAnchor == infoView.widthAnchor - 20
        emailField.topAnchor == infoText1.bottomAnchor + 8
        emailField.centerXAnchor == infoView.centerXAnchor

        privacyPolicyButton.topAnchor == emailField.bottomAnchor
        privacyPolicyButton.centerXAnchor == emailField.centerXAnchor
        privacyPolicyButton.centerXAnchor == emailField.centerXAnchor

        yesButton.topAnchor == privacyPolicyButton.bottomAnchor + 8

        self.configureScrollViewConstraints()
    }
    
    func configureScrollViewConstraints() {
        scrollView.trailingAnchor == infoView.trailingAnchor + 20
        infoView.topAnchor == scrollView.topAnchor
        infoView.centerYAnchor == scrollView.centerYAnchor
        scrollView.bottomAnchor == infoView.bottomAnchor
        infoView.centerXAnchor == scrollView.centerXAnchor
        infoView.leadingAnchor == scrollView.leadingAnchor

        scrollView.topAnchor == headerView.bottomAnchor
        contentView.bottomAnchor == scrollView.bottomAnchor
        scrollView.leadingAnchor == contentView.leadingAnchor
        scrollView.trailingAnchor == contentView.trailingAnchor
    }
    
}

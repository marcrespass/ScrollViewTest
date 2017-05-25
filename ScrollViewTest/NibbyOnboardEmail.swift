//
//  OnboardEmail.swift
//  CardioVisual
//
//  Created by Marc Respass on 3/20/17.
//  Copyright © 2017 ILIOS Inc. All rights reserved.
//

import UIKit

final class OnboardEmail: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var infoView: UIView!
    @IBOutlet weak var yesButton: UIButton!
    @IBOutlet weak var noButton: UIButton!
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var scrollView: UIScrollView!
    
    // MARK: - Function Properties
    var didFinishEmail: (_ emailAddress: String) -> Void = { _ in fatalError("failed to implement") }
    var showPrivacy: () -> Void = { _ in fatalError("failed to implement") }
    
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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let inset = UIDevice.current.userInterfaceIdiom == .pad ? 100.0 : 20.0
        contentView.topAnchor == self.view.topAnchor + inset
        contentView.bottomAnchor == self.view.bottomAnchor - inset
        contentView.leadingAnchor == self.view.leadingAnchor + inset
        contentView.trailingAnchor == self.view.trailingAnchor - inset
        
        if UIDevice.current.userInterfaceIdiom == .phone {
            NSLayoutConstraint.activate(self.phoneConstraints)
        } else {
            NSLayoutConstraint.activate(self.padConstraints)
        }
        
        self.emailField.delegate = self
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow(_:)),
                                               name: NSNotification.Name.UIKeyboardWillShow,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide(_:)),
                                               name: NSNotification.Name.UIKeyboardWillHide,
                                               object: nil)
    }

}

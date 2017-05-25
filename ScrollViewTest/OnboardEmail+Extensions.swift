//
//  OnboardEmail+Extensions.swift
//  CardioVisual
//
//  Created by Marc Respass on 5/25/17.
//  Copyright © 2017 ILIOS Inc. All rights reserved.
//

import UIKit

// MARK: - Rotation Handling
extension OnboardEmail {
    override var shouldAutorotate: Bool {
        return UIDevice.current.userInterfaceIdiom == .phone ? UIDevice.current.orientation.isPortrait : true
    }
    
    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation { // swiftlint:disable:this variable_name
        return UIDevice.current.userInterfaceIdiom == .phone ? .portrait :  UIApplication.shared.statusBarOrientation
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return UIDevice.current.userInterfaceIdiom == .pad ? .all : .allButUpsideDown
    }
}

// MARK: - Actions
extension OnboardEmail {
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
    
    @IBAction func showPrivacyPolicy(_ sender: Any) {
        self.showPrivacy()
    }
    
    @IBAction func sendEmail(_ sender: Any) {
        if let value = self.emailField.text, !value.isEmpty {
            self.didFinishEmail(value)
        } else {
            self.emailField.placeholder = "Enter email or tap No Thanks"
        }
    }
    
    @IBAction func send(_ sender: Any) {
        self.didFinishEmail("")
    }
}

extension OnboardEmail: UITextFieldDelegate {
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

// MARK: - Keyboard notifications
extension OnboardEmail {
    func keyboardWillShow(_ notification: Notification) {
        debugPrint("\(#function)")
        guard
            let info = notification.userInfo,
            let keyboardSize = info[UIKeyboardFrameBeginUserInfoKey] as? CGRect else { return }
        
        let contentInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
        
        self.scrollView.isScrollEnabled = true
        self.scrollView.contentInset = contentInsets
        self.scrollView.scrollIndicatorInsets = contentInsets
        self.scrollView.scrollRectToVisible(self.emailField.frame, animated: true)
    }
    
    func keyboardWillHide(_ notification: Notification) {
        debugPrint("\(#function)")
        guard
            let info = notification.userInfo,
            let keyboardSize = info[UIKeyboardFrameBeginUserInfoKey] as? CGRect else { return }
        
        let contentInsets = UIEdgeInsets(top: 0, left: 0, bottom: -keyboardSize.height, right: 0)
        
        self.scrollView.contentInset = contentInsets
        self.scrollView.scrollIndicatorInsets = contentInsets
        self.emailField.endEditing(true)
        self.scrollView.isScrollEnabled = false
    }
}

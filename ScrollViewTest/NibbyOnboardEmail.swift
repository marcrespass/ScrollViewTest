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
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var scrollView: UIScrollView!
    
    // MARK: - Function Properties
    var didFinishEmail: (_ emailAddress: String) -> Void = { _ in fatalError("failed to implement") }
    var showPrivacy: () -> Void = { _ in fatalError("failed to implement") }
}

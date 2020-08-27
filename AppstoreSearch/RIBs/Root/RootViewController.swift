//
//  RootViewController.swift
//  AppstoreSearch
//
//  Created by Eido Goya on 2020/08/27.
//  Copyright © 2020 Dymm. All rights reserved.
//

import RIBs
import RxSwift
import UIKit

protocol RootPresentableListener: class {
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
}

final class RootViewController: UIViewController, RootPresentable, RootViewControllable {

    weak var listener: RootPresentableListener?
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemTeal
    }
    
    // MARK: - RootViewControllable
    
    func replaceModal(viewController: ViewControllable?) {
        targetViewController = viewController
        
        guard !animationInProgress else {
            return
        }
        
        if presentedViewController != nil {
            animationInProgress = true
            dismiss(animated: true) { [weak self] in
                if self?.targetViewController != nil {
                    self?.presentTargetViewController()
                } else {
                    self?.animationInProgress = false
                }
            }
        } else {
            presentTargetViewController()
        }
    }
    
    // MARK: - Private
    
    private var targetViewController: ViewControllable?
    private var animationInProgress = false
    
    private func presentTargetViewController() {
        if let targetViewController = targetViewController {
            animationInProgress = true
            targetViewController.uiviewController.modalPresentationStyle = .fullScreen
            present(targetViewController.uiviewController, animated: true) { [weak self] in
                self?.animationInProgress = false
            }
        }
    }
}

// MARK: - SearchViewControllable

extension RootViewController: SearchViewControllable {
    
}

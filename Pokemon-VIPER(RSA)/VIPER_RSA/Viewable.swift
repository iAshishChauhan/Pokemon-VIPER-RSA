//
//  Viewable.swift
//  Pokemon-VIPER(RSA)
//
//  Created by Ashish Chauhan on 19/12/24.
//

import UIKit

protocol Viewable: AnyObject {
    func push(_ vc: UIViewController, animated: Bool)
    func present(_ vc: UIViewController, animated: Bool)
    func pop(animated: Bool)
    func dismiss(animated: Bool)
    func dismiss(animated: Bool, _ completion: @escaping (() -> Void))
}

protocol ViewControllable: Viewable {
    var uiViewController: UIViewController { get }
}

extension ViewControllable where Self: UIViewController {
    var uiViewController: UIViewController {
        return self
    }
}

extension Viewable where Self: UIViewController {
    func push(_ vc: UIViewController, animated: Bool) {
        self.navigationController?.pushViewController(vc, animated: animated)
    }
    
    func present(_ vc: UIViewController, animated: Bool) {
        self.present(vc, animated: animated)
    }
    
    func pop(animated: Bool) {
        self.pop(animated: animated)
    }
    
    func dismiss(animated: Bool) {
        self.dismiss(animated: animated)
    }
    
    func dismiss(animated: Bool, _ completion: @escaping (() -> Void)) {
        self.dismiss(animated: animated, completion)
    }
}

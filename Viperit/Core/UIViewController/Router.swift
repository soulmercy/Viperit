//
//  Router.swift
//  Viperit
//
//  Created by Ferran on 11/09/2016.
//  Copyright © 2016 Ferran Abelló. All rights reserved.
//

import UIKit

open class Router: RouterProtocol {
    public typealias P = Presenter
    public typealias V = UserInterface

    public weak var _presenter: P!
    public var _view: V! {
        return _presenter._view
    }
    required public init() {}
}


public extension RouterProtocol {
    func process(setupData: Any?) {
        if let data = setupData {
            _presenter.setupView(data: data)
        }
    }
}

public extension RouterProtocol where V == UserInterface {
    public func show(inWindow window: UIWindow?, embedInNavController: Bool = false, setupData: Any? = nil, makeKeyAndVisible: Bool = true) {
        process(setupData: setupData)
        let view = embedInNavController ? embedInNavigationController() : _view
        window?.rootViewController = view
        if makeKeyAndVisible {
            window?.makeKeyAndVisible()
        }
    }
    
    public func show(from: UIViewController, embedInNavController: Bool = false, setupData: Any? = nil) {
        process(setupData: setupData)
        let view = embedInNavController ? embedInNavigationController() : _view
        from.show(view, sender: nil)
    }
    
    public func show(from containerView: UIViewController, insideView targetView: UIView, setupData: Any? = nil) {
        process(setupData: setupData)
        addAsChildView(ofView: containerView, insideContainer: targetView)
    }
    private func getNavigationController() -> UINavigationController? {
        if let nav = _view.navigationController {
            return nav
        } else if let parent = _view.parent {
            if let parentNav = parent.navigationController {
                return parentNav
            }
        }
        return nil
    }
    
    func embedInNavigationController() -> UINavigationController {
        return getNavigationController() ?? UINavigationController(rootViewController: _view)
    }
    
    func addAsChildView(ofView parentView: UIViewController, insideContainer containerView: UIView) {
        parentView.addChildViewController(_view)
        containerView.addSubview(_view.view)
        stretchToBounds(containerView, view: _view.view)
        _view.didMove(toParentViewController: parentView)
    }
    
    private func stretchToBounds(_ holderView: UIView, view: UIView) {
        view.translatesAutoresizingMaskIntoConstraints = false
        let pinDirections: [NSLayoutAttribute] = [.top, .bottom, .left, .right]
        let pinConstraints = pinDirections.map { direction -> NSLayoutConstraint in
            return NSLayoutConstraint(item: view, attribute: direction, relatedBy: .equal,
                                      toItem: holderView, attribute: direction, multiplier: 1.0, constant: 0)
        }
        holderView.addConstraints(pinConstraints)
    }
}

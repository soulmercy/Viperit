//
//  ViperProtocol.swift
//  Viperit
//
//  Created by 王俊武 on 2018/9/6.
//  Copyright © 2018 Ferran Abelló. All rights reserved.
//
import UIKit
import Foundation

public protocol Initializeable {
    init()
}

public protocol UserInterfaceProtocol {
    associatedtype P: PresenterProtocol
    
    var _presenter: P! { get set }
    var _displayData: DisplayData! { get set }
}


public protocol RouterProtocol: Initializeable {
    associatedtype V: UserInterfaceProtocol
    associatedtype P: PresenterProtocol
    var _presenter: P! { get set }
    var _view: V! { get }
}

public protocol InteractorProtocol: Initializeable {
    associatedtype P: PresenterProtocol
    var _presenter: P! { get set }
}

public protocol PresenterProtocol: Initializeable {
    associatedtype V: UserInterfaceProtocol
    associatedtype I: InteractorProtocol
    associatedtype R: RouterProtocol
    
    var _interactor: I! { get set }
    var _view: V! { get set }
    var _router: R! { get set }
    func setupView(data: Any)
}

public protocol WireframeProtocol {
    associatedtype V: UserInterfaceProtocol
    associatedtype P: PresenterProtocol
    associatedtype I: InteractorProtocol
    associatedtype R: RouterProtocol
    
    var view: V { get }
    var interactor: I { get }
    var presenter: P { get }
    var router: R { get }
    var displayData: DisplayData { get }
    
    init(view: V, interactor: I, presenter: P, router: R, displayData: DisplayData)
}

private let kTabletSuffix = "Pad"

//MARK: - Private Extension for Application Module generic enum
internal extension RawRepresentable where RawValue == String {
    
    func classForViperComponent(_ component: ViperComponent, bundle: Bundle, deviceType: UIUserInterfaceIdiom? = nil) -> Swift.AnyClass? {
        let className = rawValue.uppercasedFirst + component.rawValue.uppercasedFirst
        let bundleName = safeString(bundle.infoDictionary?["CFBundleName"])
        let classInBundle = (bundleName + "." + className).replacingOccurrences(of: " ", with: "_")
        
        if component == .view {
            let deviceType = deviceType ?? UIScreen.main.traitCollection.userInterfaceIdiom
            let isPad = deviceType == .pad
            if isPad, let tabletView = NSClassFromString(classInBundle + kTabletSuffix) {
                return tabletView
            }
        }
        
        return NSClassFromString(classInBundle)
    }
}

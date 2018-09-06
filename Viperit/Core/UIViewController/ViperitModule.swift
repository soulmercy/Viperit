//
//  File.swift
//  Viperit
//
//  Created by 王俊武 on 2018/9/6.
//  Copyright © 2018 Ferran Abelló. All rights reserved.
//

import UIKit

//MARK: - Module View Types
public enum ViperitViewType {
    case storyboard
    case nib
    case code
}

//MARK: - Viperit Module Protocol
public protocol ViperitModule {
    var viewType: ViperitViewType { get }
    var viewName: String { get }
    func build(bundle: Bundle, deviceType: UIUserInterfaceIdiom?) -> Wireframe
}

public extension ViperitModule where Self: RawRepresentable, Self.RawValue == String {
    var viewType: ViperitViewType {
        return .code
    }
    
    var viewName: String {
        return rawValue
    }
    
    func build(bundle: Bundle = Bundle.main, deviceType: UIUserInterfaceIdiom? = nil) -> Wireframe {
        return Wireframe(self, bundle: bundle, deviceType: deviceType)
    }
}

public extension Wireframe {
    init<T: RawRepresentable & ViperitModule>(_ module: T, bundle: Bundle = .main, deviceType: UIUserInterfaceIdiom? = nil) where T.RawValue == String {
        let interactorClass = module.classForViperComponent(.interactor, bundle: bundle) as! I.Type
        let presenterClass = module.classForViperComponent(.presenter, bundle: bundle) as! P.Type
        let routerClass = module.classForViperComponent(.router, bundle: bundle) as! R.Type
        let displayDataClass = module.classForViperComponent(.displayData, bundle: bundle) as! DisplayData.Type
        
        //Allocate VIPER components
        let V = Wireframe.loadView(forModule: module, bundle: bundle, deviceType: deviceType)
        let I = interactorClass.init()
        let P = presenterClass.init()
        let R = routerClass.init()
        let D = displayDataClass.init()
        
        self.init(view: V, interactor: I, presenter: P, router: R, displayData: D)
    }
    
    static private func loadView<T: RawRepresentable & ViperitModule>(forModule module: T, bundle: Bundle, deviceType: UIUserInterfaceIdiom? = nil) -> V where T.RawValue == String {
        let viewClass = module.classForViperComponent(.view, bundle: bundle, deviceType: deviceType) as! UIViewController.Type
        let viewIdentifier = safeString(NSStringFromClass(viewClass).components(separatedBy: ".").last)
        let viewName = module.viewName.uppercasedFirst
        
        switch module.viewType {
        case .storyboard:
            let sb = UIStoryboard(name: viewName, bundle: bundle)
            return sb.instantiateViewController(withIdentifier: viewIdentifier) as! V
        case .nib:
            return viewClass.init(nibName: viewName, bundle: bundle) as! V
        case .code:
            return viewClass.init() as! V
        }
        
    }
}

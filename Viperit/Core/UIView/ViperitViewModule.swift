//
//  ViperitViewModule.swift
//  Viperit
//
//  Created by 王俊武 on 2018/9/6.
//  Copyright © 2018 Ferran Abelló. All rights reserved.
//

import UIKit

public protocol ViperitViewModule {
    func build(bundle: Bundle) -> ViewWireframe
}

public extension ViperitViewModule where Self: RawRepresentable, Self.RawValue == String {
    func build(bundle: Bundle = .main) -> ViewWireframe {
        return ViewWireframe(self, bundle: bundle)
    }
}

public extension ViewWireframe {
    init<T: RawRepresentable>(_ module: T, bundle: Bundle = .main) where T.RawValue == String {
        //Get class types
        let viewClass = module.classForViperComponent(.view, bundle: bundle) as! V.Type
        let interactorClass = module.classForViperComponent(.interactor, bundle: bundle) as! I.Type
        let presenterClass = module.classForViperComponent(.presenter, bundle: bundle) as! P.Type
        let routerClass = module.classForViperComponent(.router, bundle: bundle) as! R.Type
        let displayDataClass = module.classForViperComponent(.displayData, bundle: bundle) as! DisplayData.Type
        
        //Allocate VIPER components
        let V = viewClass.init()
        let I = interactorClass.init()
        let P = presenterClass.init()
        let R = routerClass.init()
        let D = displayDataClass.init()
        
        self.init(view: V, interactor: I, presenter: P, router: R, displayData: D)
    }
}

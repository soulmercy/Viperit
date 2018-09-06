//
//  Router.swift
//  Viperit
//
//  Created by Ferran on 11/09/2016.
//  Copyright © 2016 Ferran Abelló. All rights reserved.
//

import UIKit

open class ViewRouter: RouterProtocol {
    public typealias P = ViewPresenter
    public typealias V = ViewUserInterface

    public weak var _presenter: P!
    public var _view: V! {
        return _presenter._view
    }
    required public init() {}
}

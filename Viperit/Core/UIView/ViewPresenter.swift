//
//  Presenter.swift
//  Viperit
//
//  Created by Ferran on 11/09/2016.
//  Copyright © 2016 Ferran Abelló. All rights reserved.
//

open class ViewPresenter: PresenterProtocol {
    public typealias I = ViewInteractor
    public typealias V = ViewUserInterface
    public typealias R = ViewRouter

    public var _interactor: I!
    public weak var _view: V!
    public var _router: R!

    required public init() {}

    open func setupView(data: Any) {
        print(ViperitError.methodNotImplemented.description)
    }
}

//
//  Presenter.swift
//  Viperit
//
//  Created by Ferran on 11/09/2016.
//  Copyright © 2016 Ferran Abelló. All rights reserved.
//

public protocol ViewControllerPresenterProtocol {
    func viewHasLoaded()
    func viewIsAboutToAppear()
    func viewHasAppeared()
    func viewIsAboutToDisappear()
    func viewHasDisappeared()
}

open class Presenter: PresenterProtocol, ViewControllerPresenterProtocol {
    public typealias I = Interactor
    public typealias V = UserInterface
    public typealias R = Router

    public var _interactor: I!
    public weak var _view: V!
    public var _router: R!

    required public init() {}

    open func setupView(data: Any) {
        print(ViperitError.methodNotImplemented.description)
    }

    open func viewHasLoaded() {}
    open func viewIsAboutToAppear() {}
    open func viewHasAppeared() {}
    open func viewIsAboutToDisappear() {}
    open func viewHasDisappeared() {}
}

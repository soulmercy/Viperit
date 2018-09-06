//
//  Module.swift
//  Viperit
//
//  Created by Ferran on 11/09/2016.
//  Copyright © 2016 Ferran Abelló. All rights reserved.
//

import Foundation
import UIKit

public struct ViewWireframe: WireframeProtocol {
    public typealias V = ViewUserInterface
    public typealias I = ViewInteractor
    public typealias P = ViewPresenter
    public typealias R = ViewRouter

    public private(set) var view: V
    public private(set) var interactor: I
    public private(set) var presenter: P
    public private(set) var router: R
    public private(set) var displayData: DisplayData

    public init(view: V, interactor: I, presenter: P, router: R, displayData: DisplayData) {
        //View connections
        view._presenter = presenter
        view._displayData = displayData

        //Interactor connections
        interactor._presenter = presenter

        //Presenter connections
        presenter._router = router
        presenter._interactor = interactor
        presenter._view = view

        //Router connections
        router._presenter = presenter


        self.view = view
        self.interactor = interactor
        self.presenter = presenter
        self.router = router
        self.displayData = displayData

    }
}

//MARK: - Inject Mock Components for Testing
public extension ViewWireframe {
    
    public mutating func injectMock(view mockView: V) {
        view = mockView
        view._presenter = presenter
        view._displayData = displayData
        presenter._view = view
    }
    
    public mutating func injectMock(interactor mockInteractor: I) {
        interactor = mockInteractor
        interactor._presenter = presenter
        presenter._interactor = interactor
    }
    
    public mutating func injectMock(presenter mockPresenter: P) {
        presenter = mockPresenter
        presenter._view = view
        presenter._interactor = interactor
        presenter._router = router
        view._presenter = presenter
        interactor._presenter = presenter
        router._presenter = presenter
    }
    
    public mutating func injectMock(router mockRouter: R) {
        router = mockRouter
        router._presenter = presenter
        presenter._router = router
    }
}

//
//  Interactor.swift
//  Viperit
//
//  Created by Ferran on 11/09/2016.
//  Copyright © 2016 Ferran Abelló. All rights reserved.
//

open class Interactor: InteractorProtocol {
    public typealias P = Presenter
    public weak var _presenter: P!
    
    required public init() { }
}

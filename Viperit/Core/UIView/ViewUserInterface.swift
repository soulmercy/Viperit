//
//  UserInterface.swift
//  Viperit
//
//  Created by Ferran on 11/09/2016.
//  Copyright © 2016 Ferran Abelló. All rights reserved.
//

import UIKit

open class ViewUserInterface: UIView, UserInterfaceProtocol {
    public typealias P = ViewPresenter

    public var _presenter: P!
    public var _displayData: DisplayData!
}

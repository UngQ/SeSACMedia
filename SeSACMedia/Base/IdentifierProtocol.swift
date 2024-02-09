//
//  IdentifierProtocol.swift
//  SeSACMedia
//
//  Created by ungQ on 2/9/24.
//

import UIKit

protocol ReusableViewProtocol {
	static var identifier: String { get }
}

extension UIView: ReusableViewProtocol {
	static var identifier: String {
		return String(describing: self)
	}
}

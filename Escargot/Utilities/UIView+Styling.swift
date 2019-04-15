//
//  UIView+Styling.swift
//  Escargot
//
//  Created by Jonathan Long on 2/4/19.
//  Copyright © 2019 Heavenly Flower. All rights reserved.
//

import Foundation
import UIKit

public struct Style<View: UIView> {
	
	public let style: (View) -> Void
	
	public init(_ style: @escaping (View) -> Void) {
		self.style = style
	}
	
	public func apply(to view: View) {
		style(view)
	}
}

extension UIView {
	
	public convenience init<V>(style: Style<V>) {
		self.init(frame: .zero)
		apply(style)
	}
	
	public func apply<V>(_ style: Style<V>) {
		guard let view = self as? V else {
			print("💥 Could not apply style for \(V.self) to \(type(of: self))")
			return
		}
		style.apply(to: view)
	}
}

//
//  UIImage+Additions.swift
//  Escargot
//
//  Created by Jonathan Long on 1/30/19.
//  Copyright © 2019 Heavenly Flower. All rights reserved.
//

import UIKit

extension UIImage {
	var isLandscape: Bool {
		return self.size.width > self.size.height
	}
}

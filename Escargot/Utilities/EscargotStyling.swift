//
//  EscargotStyling.swift
//  Escargot
//
//  Created by Jonathan Long on 2/4/19.
//  Copyright © 2019 Heavenly Flower. All rights reserved.
//

import Foundation
import CoreGraphics
import UIKit

enum EscargotStyling {
	//MARK: - Padding and Spacing
	enum CollectionItemsInterSpacing {
		static let bottom: CGFloat = 10.0
		static let top: CGFloat = 10.0
		static let left: CGFloat = 10.0
		static let right: CGFloat = 10.0
	}
	
	enum VisualEffectViewPadding {
		static let bottom: CGFloat = 5.0
		static let top: CGFloat = 5.0
		static let left: CGFloat = 5.0
		static let right: CGFloat = 5.0
	}
	
	enum BubbleTabBarSpacingAndPadding {
		static let bubbleButtonStackViewHeight: CGFloat = 50.0
		static let additionalSafeAreaEdgeInsets: UIEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: EscargotStyling.BubbleTabBarSpacingAndPadding.bubbleButtonStackViewHeight, right: 0.0)
	}
	
	//MARK: - View Styling
	enum RecipeDetailStyling {
		static let headerTitle = Style<UILabel> {
			$0.font = UIFont.preferredFont(forTextStyle: .title1)
			$0.numberOfLines = 2
		}
		
		static let headerTitleVisualEffectView = Style<UIVisualEffectView> {
			$0.effect = UIBlurEffect(style: .light)
		}
	}
	
}

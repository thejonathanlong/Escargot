//
//  RecipeDetailHeaderView.swift
//  Escargot
//
//  Created by Jonathan Long on 2/4/19.
//  Copyright © 2019 Heavenly Flower. All rights reserved.
//

import UIKit

class RecipeDetailHeaderView: UIView {
	
	//MARK: - Properties
	var recipeTitle: String = "" {
		didSet(newRecipeTitle) {
			titleLabel.text = newRecipeTitle
			setNeedsLayout()
		}
	}
	
	var image: UIImage? {
		didSet(newImage) {
			imageView.image = newImage
			setNeedsLayout()
		}
	}
	
	private let imageView = UIImageView()
	private let titleLabel = UILabel()
	private let titleVisualEffectView = UIVisualEffectView(style: EscargotStyling.RecipeDetailStyling.headerTitleVisualEffectView)
	
	//MARK: - Initializers
	init(frame: CGRect, title: String, image: UIImage?) {
		titleLabel.text = title
		imageView.image = image
		super.init(frame: frame)
		
		setupView()
	}
	
	required init?(coder aDecoder: NSCoder) {
		titleLabel.text = ""
		imageView.image = nil
		super.init(coder: aDecoder)
		
		setupView()
	}
}

//MARK: - Utilities
extension RecipeDetailHeaderView {
	func setupView() {
		imageView.translatesAutoresizingMaskIntoConstraints = false
		titleLabel.translatesAutoresizingMaskIntoConstraints = false
		titleVisualEffectView.translatesAutoresizingMaskIntoConstraints = false
		
		addSubview(imageView)
		addSubview(titleVisualEffectView)
		addSubview(titleLabel)
		
		let constraints = [
			imageView.topAnchor.constraint(equalTo: topAnchor),
			imageView.bottomAnchor.constraint(equalTo: bottomAnchor),
			imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
			imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
			titleVisualEffectView.leadingAnchor.constraint(equalTo: leadingAnchor),
			titleVisualEffectView.trailingAnchor.constraint(equalTo: trailingAnchor),
			titleVisualEffectView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -EscargotStyling.CollectionItemsInterSpacing.bottom),
			titleVisualEffectView.heightAnchor.constraint(equalTo: titleLabel.heightAnchor, constant: (EscargotStyling.VisualEffectViewPadding.top + EscargotStyling.VisualEffectViewPadding.bottom)),
			titleLabel.centerYAnchor.constraint(equalTo: titleVisualEffectView.centerYAnchor),
			titleLabel.leadingAnchor.constraint(equalTo: titleVisualEffectView.leadingAnchor, constant: EscargotStyling.VisualEffectViewPadding.left),
			titleLabel.trailingAnchor.constraint(equalTo: titleVisualEffectView.trailingAnchor, constant: -EscargotStyling.VisualEffectViewPadding.right),
		]
		NSLayoutConstraint.activate(constraints)
	}
}

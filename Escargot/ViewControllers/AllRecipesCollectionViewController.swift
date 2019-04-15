//
//  AllRecipesCollectionViewController.swift
//  Escargot
//
//  Created by Jonathan Long on 3/22/19.
//  Copyright © 2019 Heavenly Flower. All rights reserved.
//

import UIKit

class AllRecipesCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

	private static let recipeCollectionViewCellIdentifier = "RecipeCollectionViewCell"
	//MARK: - Properties
	var recipes: [Recipe] = [] {
		didSet {
			self.recipesDidChange()
		}
	}
	
	let database = EscargotDatabase.shared
}

// MARK: - Utilities
extension AllRecipesCollectionViewController {
	private func recipesDidChange() {
		DispatchQueue.main.async {
			self.collectionView?.reloadData()
		}
	}
	
	private func databaseStatusDidChange() {
		fetchAllRecipes()
	}
	
	private func fetchAllRecipes() {
		if EscargotDatabase.shared.status == .loaded {
			database.recipes { [weak self] (recipes) in
				guard let strongSelf = self else { return }
				strongSelf.recipes = recipes
			}
		}
	}
}

// MARK: - UIViewController
extension AllRecipesCollectionViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView!.register(RecipeCollectionViewCell.self, forCellWithReuseIdentifier: AllRecipesCollectionViewController.recipeCollectionViewCellIdentifier)
		NotificationCenter.default.addObserver(forName: EscargotDatabase.statusDidChangeNotification, object: EscargotDatabase.shared, queue: OperationQueue.main) {[weak self] (note) in
			guard let strongSelf = self else { return }
			strongSelf.databaseStatusDidChange()
		}
    }
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		
		self.fetchAllRecipes()
	}
}

// MARK: - UICollectionViewDataSource
extension AllRecipesCollectionViewController {
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.recipes.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AllRecipesCollectionViewController.recipeCollectionViewCellIdentifier, for: indexPath) as! RecipeCollectionViewCell
		let recipe = recipes[indexPath.row]
        cell.recipeImageView.image = recipe.image
		cell.titleLabel.text = recipe.name
    
        return cell
    }
}

// MARK: - UICollectionViewFlowDelegate/UICollectionViewDelegate
extension AllRecipesCollectionViewController {
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		let width = collectionView.frame.width
		let fourThreeAspectRatio = CGFloat(4.0/3.0)
		let height: CGFloat = width * fourThreeAspectRatio
		
		return CGSize(width: width, height: height)
	}

}

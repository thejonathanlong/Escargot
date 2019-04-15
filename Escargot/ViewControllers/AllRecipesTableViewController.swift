//
//  AllRecipesTableViewController.swift
//  Escargot
//
//  Created by Jonathan Long on 1/14/19.
//  Copyright © 2019 Heavenly Flower. All rights reserved.
//

import UIKit

class AllRecipesTableViewController: UITableViewController {
	//MARK: - Class Variables
	static let didSelectRecipeSequeIdentifier = "DidSelectRecipeSequeIdentifier"
	
	//MARK: - Properties
	var recipes: [Recipe] = [] {
		didSet {
			self.recipesDidChange()
		}
	}
	
	let database = EscargotDatabase.shared
}

//MARK: - UIViewController
extension AllRecipesTableViewController {
	override func viewDidLoad() {
		super.viewDidLoad()
		
		NotificationCenter.default.addObserver(forName: EscargotDatabase.statusDidChangeNotification, object: EscargotDatabase.shared, queue: OperationQueue.main) {[weak self] (note) in
			guard let strongSelf = self else { return }
			strongSelf.databaseStatusDidChange()
		}
	}
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		fetchAllRecipes()
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		switch segue.identifier {
		case AllRecipesTableViewController.didSelectRecipeSequeIdentifier:
			let _ = segue.destination
			
		default:
			break
		}

	}
	
	
}

// MARK: - Table view data source
extension AllRecipesTableViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipes.count
    }
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: RecipeTableViewCell.reuseIdentifier) as! RecipeTableViewCell
		
		let recipe = recipes[indexPath.row]
		
		cell.titleLabel.text = recipe.name
		cell.recipeImageView.image = recipe.image
		cell.layoutIfNeeded()
		return cell
	}
}

// MARK: - Table view delegate
extension AllRecipesTableViewController {
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let recipe = recipes[indexPath.row]
		
		performSegue(withIdentifier: AllRecipesTableViewController.didSelectRecipeSequeIdentifier, sender: self)
	}
}

//MARK: - utilities
extension AllRecipesTableViewController {
	private func recipesDidChange() {
		DispatchQueue.main.async {
			self.tableView.reloadData()
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

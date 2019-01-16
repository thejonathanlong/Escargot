//
//  AllRecipesTableViewController.swift
//  Escargot
//
//  Created by Jonathan Long on 1/14/19.
//  Copyright © 2019 Heavenly Flower. All rights reserved.
//

import UIKit

class AllRecipesTableViewController: UITableViewController {
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
		
		let url = URL(string: "https://againstallgrain.com/2018/09/26/gluten-free-brazilian-cheese-bread-pao-de-queijo/")!
		let parser = RecipeParser(newURL: url)
		let recipe = parser.recipe()
		printDebug("\(parser.images)")
//		EscargotDatabase.shared.save(recipe: recipe) { (records, recordIDs, error) in
//			if error == nil {
//				if let records = records {
//					printDebug("Saved records: \(records)")
//				}
//			}
//			else if let error = error {
//				printDebug("There was an error \(error)")
//			}
//		}
	}
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		database.recipes { [weak self] (recipes) in
			guard let strongSelf = self else { return }
			strongSelf.recipes = recipes
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
		
		return cell
	}
}

//MARK: - Property Changes
extension AllRecipesTableViewController {
	func recipesDidChange() {
		DispatchQueue.main.async {
			self.tableView.reloadData()
		}
	}
}

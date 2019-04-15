//
//  IngredientListTableViewController.swift
//  Escargot
//
//  Created by Jonathan Long on 2/10/19.
//  Copyright © 2019 Heavenly Flower. All rights reserved.
//

import UIKit

protocol EscargotListInforming {
	func scrollViewDidScroll(_ scrollView: UIScrollView)
}

class IngredientListTableViewController: UITableViewController, EscargotListInforming {
	//MARK: - Public Properties
	var ingredients: [Ingredient] = []
	
	//MARK: - Private Properties
	private static let ingredientListTableViewCellReuseIdentifier = "ingredientListTableViewCellReuseIdentifier"
	
	// MARK: - Initialization
	func commonInit() {
		title = "Ingredients"
		tableView.register(UITableViewCell.self, forCellReuseIdentifier: IngredientListTableViewController.ingredientListTableViewCellReuseIdentifier)
	}
	
	override init(style: UITableView.Style) {
		super.init(style: style)
		commonInit()
	}
	
	override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
		super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
		commonInit()
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		commonInit()
	}
}

// MARK: - Table view data source
extension IngredientListTableViewController {
	
	
	override func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		
		return 20
	}
	
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: IngredientListTableViewController.ingredientListTableViewCellReuseIdentifier, for: indexPath)
		
		cell.textLabel?.text = "\(indexPath.row + 1)"
		return cell
	}
	
}

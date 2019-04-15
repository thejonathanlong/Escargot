//
//  InstructionsListTableViewController.swift
//  Escargot
//
//  Created by Jonathan Long on 2/13/19.
//  Copyright © 2019 Heavenly Flower. All rights reserved.
//

import UIKit

class InstructionsListTableViewController: UITableViewController {
	//MARK: - Public Properties
	var ingredients: [String] = []
	
	//MARK: - Private Properties
	private static let instructionListTableViewCellReuseIdentifier = "instructionListTableViewCellReuseIdentifier"
	
	// MARK: - Initialization
	func commonInit() {
		title = "Instructions"
		tableView.register(UITableViewCell.self, forCellReuseIdentifier: InstructionsListTableViewController.instructionListTableViewCellReuseIdentifier)
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
extension InstructionsListTableViewController {
	override func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 10
	}
	
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: InstructionsListTableViewController.instructionListTableViewCellReuseIdentifier, for: indexPath)
		
		cell.textLabel?.text = "\(indexPath.row * 10)"
		
		return cell
	}
}

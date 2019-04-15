//
//  RecipeDetailViewController.swift
//  Escargot
//
//  Created by Jonathan Long on 2/4/19.
//  Copyright © 2019 Heavenly Flower. All rights reserved.
//

import UIKit

class RecipeDetailViewController: UIViewController {
	//MARK: - Static Properites
	private static let tableViewCellReuseIdentifier = "tableViewCellReuseIdentifier"
	private static let minimumHeaderHeight: CGFloat = 100.0
	private static let maximumHeaderHeight: CGFloat = 300.0
	
	//MARK: - Public Properties
	var recipe = Recipe()
	
	//MARK: - Private Properties
	private let headerView = RecipeDetailHeaderView(frame: .zero, title: "", image: nil)
	private var headerHeightConstraint: NSLayoutConstraint?
	private var previousScrollOffset: CGFloat = 0.0
	private let bubbleTabBar = BubbleTabBarViewController(viewControllers: [])
}

//MARK: - UIViewController
extension RecipeDetailViewController {
	override func loadView() {
		super.loadView()
		guard let bubbleTabBarView = bubbleTabBar.view else {
			assertionFailure("Failed to get a view from \(BubbleTabBarViewController.self)")
			return
		}
		bubbleTabBarView.translatesAutoresizingMaskIntoConstraints = false
		let ingredientListViewController = IngredientListTableViewController(nibName: nil, bundle: nil)
		let instructionListViewController = InstructionsListTableViewController(nibName: nil, bundle: nil)
		bubbleTabBar.add(viewController: ingredientListViewController)
		bubbleTabBar.add(viewController: instructionListViewController)
		headerView.backgroundColor = .blue
		headerHeightConstraint = headerView.heightAnchor.constraint(equalToConstant: RecipeDetailViewController.maximumHeaderHeight)
		headerView.translatesAutoresizingMaskIntoConstraints = false
		
		view.addSubview(headerView)
		bubbleTabBar.willMove(toParentViewController: self)
		addChildViewController(bubbleTabBar)
		view.addSubview(bubbleTabBarView)
		bubbleTabBar.didMove(toParentViewController: self)
		var otherConstraints = [
			headerView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
			headerView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
			headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
			bubbleTabBarView.topAnchor.constraint(equalTo: headerView.bottomAnchor),
			bubbleTabBarView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
			bubbleTabBarView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
			bubbleTabBarView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
		]
		
		otherConstraints.append(headerHeightConstraint!)
		NSLayoutConstraint.activate(otherConstraints)
	}
}

////MARK: - UITableViewDataSource/Delegate
//extension RecipeDetailViewController {
//	func numberOfSections(in tableView: UITableView) -> Int {
//		return 1
//	}
//
//	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//		return 20
//	}
//
//	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//		guard let tableViewCell = tableView.dequeueReusableCell(withIdentifier: RecipeDetailViewController.tableViewCellReuseIdentifier) else {
//			print("Didn't get a cell...")
//			return UITableViewCell()
//		}
//		tableViewCell.textLabel?.text = "\(indexPath.row)"
//
//		return tableViewCell
//	}
//}
//
////MARK: - UIScrollViewDelegate
//extension RecipeDetailViewController {
//	func scrollViewDidScroll(_ scrollView: UIScrollView) {
//		guard let currentHeight = headerHeightConstraint?.constant else { return }
//		let scrollDiff = scrollView.contentOffset.y - previousScrollOffset
//		let absoluteTop: CGFloat = 0;
//		let absoluteBottom: CGFloat = scrollView.contentSize.height - scrollView.frame.size.height;
//
//		let isScrollingDown = scrollDiff > 0 && scrollView.contentOffset.y > absoluteTop
//		let isScrollingUp = scrollDiff < 0 && scrollView.contentOffset.y < absoluteBottom
//
//		var newHeight = currentHeight
//		if isScrollingDown {
//			newHeight = max(RecipeDetailViewController.minimumHeaderHeight, currentHeight - abs(scrollDiff))
//		} else if isScrollingUp {
//			newHeight = min(RecipeDetailViewController.maximumHeaderHeight, currentHeight + abs(scrollDiff))
//		}
//		if newHeight != self.headerHeightConstraint?.constant {
//			headerHeightConstraint?.constant = newHeight
//			tableView.contentOffset = CGPoint(x: tableView.contentOffset.x, y: previousScrollOffset)
//		}
//
//		previousScrollOffset = scrollView.contentOffset.y
//	}
//}

// MARK: - Private
extension RecipeDetailViewController {
	
}

//
//  BubbleTabBarViewController.swift
//  Escargot
//
//  Created by Jonathan Long on 2/10/19.
//  Copyright © 2019 Heavenly Flower. All rights reserved.
//

import UIKit

class BubbleTabBarViewController: UIViewController {

	//MARK: - Private Properties
	private var buttonStackView = UIStackView(arrangedSubviews: [])
	private var viewControllers: [UIViewController] = []
	private var currentViewController: UIViewController?
	
	//MARK: - Initializers
	convenience init(viewControllers: [UIViewController]) {
		self.init(nibName: nil, bundle: nil)
		add(viewControllers: viewControllers)
	}
}

//MARK: - UIViewController
extension BubbleTabBarViewController {
	override func loadView() {
		super.loadView()
		
		buttonStackView.translatesAutoresizingMaskIntoConstraints = false
		buttonStackView.alignment = .fill
		buttonStackView.axis = .horizontal
		buttonStackView.distribution = .fillEqually
		
		view.addSubview(buttonStackView)
		
		let constraints = [
			buttonStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
			buttonStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
			buttonStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
			buttonStackView.heightAnchor.constraint(equalToConstant: EscargotStyling.BubbleTabBarSpacingAndPadding.bubbleButtonStackViewHeight)
		]
		
		NSLayoutConstraint.activate(constraints)
	}
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		currentViewController = viewControllers.first
		currentViewController?.view.isHidden = false
		updateHighlightedButton(selectedButtonIndex: 0)
//		additionalSafeAreaInsets = EscargotStyling.BubbleTabBarSpacingAndPadding.additionalSafeAreaEdgeInsets
	}
}

//MARK: - Public Methods
extension BubbleTabBarViewController {
	func add(viewController: UIViewController) {
		viewControllers.append(viewController)
		viewController.willMove(toParentViewController: self)
		addChildViewController(viewController)
		view.insertSubview(viewController.view, belowSubview: buttonStackView)
		viewController.view.isHidden = true
		viewController.didMove(toParentViewController: self)
		viewController.view.frame = UIEdgeInsetsInsetRect(view.frame, EscargotStyling.BubbleTabBarSpacingAndPadding.additionalSafeAreaEdgeInsets)
		
		addBubbleButton(title: viewController.title)
		
		if viewControllers.count == 1 && currentViewController == nil {
			currentViewController = viewControllers.first
		}
	}
	
	func add(viewControllers: [UIViewController]) {
		for viewController in viewControllers {
			add(viewController: viewController)
		}
	}
	
	func remove(viewController: UIViewController) {
		guard let viewControllerIndex = viewControllers.firstIndex(of: viewController) else {
			assertionFailure("Trying to remove a viewController that was not added")
			return
		}
		viewController.removeFromParentViewController()
		viewController.view.removeFromSuperview()
		viewControllers.remove(at: viewControllerIndex)
	}
	
	func remove(viewControllers: [UIViewController]) {
		for vc in viewControllers {
			remove(viewController: vc)
		}
	}
}

//MARK: - Private Methods
extension BubbleTabBarViewController {
	private func addBubbleButton(title: String?) {
		let button = UIButton(type: .custom)
		button.addTarget(self, action: #selector(changeViewController(sender:)), for: .touchUpInside)
		button.setTitle(title, for: .normal)
		button.setTitleColor(.black, for: .normal)
		button.setTitleColor(UIColor.blue, for: .selected)
		buttonStackView.addArrangedSubview(button)
		
		updateButtonStackView()
	}
	
	private func updateButtonStackView() {
		buttonStackView.arrangedSubviews.forEach {
			$0.isHidden = buttonStackView.arrangedSubviews.count < 1
		}
	}
	
	private func updateCurrentViewController(for button: UIButton) {
		if let buttonIndex = buttonStackView.arrangedSubviews.firstIndex(of: button) {
			let newViewController = viewControllers[buttonIndex]
			newViewController.view.isHidden = false
			currentViewController?.view.isHidden = true
			currentViewController = newViewController
			
			updateHighlightedButton(selectedButtonIndex: buttonIndex)
		}
	}
	
	private func updateHighlightedButton(selectedButtonIndex: Int) {
		let button = buttonStackView.arrangedSubviews[selectedButtonIndex]
		for nextButton in buttonStackView.arrangedSubviews {
			let nextButton = nextButton as! UIButton
			nextButton.isSelected = nextButton == button
		}
	}
}

//MARK: - Actions
extension BubbleTabBarViewController {
	@objc func changeViewController(sender: UIButton) {
		updateCurrentViewController(for: sender)
	}
}

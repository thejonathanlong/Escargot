//
//  ViewController.swift
//  Escargot
//
//  Created by Heavenly Flower on 12/18/18.
//  Copyright © 2018 Heavenly Flower. All rights reserved.
//

import UIKit
import SwiftSoup

class ViewController: UIViewController {
	
	override func viewDidLoad() {
		super.viewDidLoad()
		if let url = URL(string: "https://againstallgrain.com/2018/07/18/instant-pot-paleo-spaghetti-meat-sauce-recipe/") {
			do {
				let html = try String(contentsOf: url, encoding: String.Encoding.utf8)
				
				let result = try SwiftSoup.parse(html)
				let ingredientsClear = try result.select("span.ingredient")
				ingredientsClear.forEach { print($0) }
			}
			catch  {
				print("There was an error parsing the HTML. \(error)")
			}
		}
	}
	
}


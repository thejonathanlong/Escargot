//
//  RecipeParser.swift
//  Escargot
//
//  Created by Heavenly Flower on 12/18/18.
//  Copyright © 2018 Heavenly Flower. All rights reserved.
//

import UIKit
import SwiftSoup

class RecipeParser: NSObject {
	
	//MARK: - RecipeContentType
	enum RecipeContentType: String {
		case ohSheGlows = "ohsheglows.com"
		case unsupported = "unsupported"
		case againstAllGrain = "againstallgrain.com"
		
		//MARK: - init
		init(host: String?) {
			switch host {
			case RecipeContentType.ohSheGlows.rawValue:
				self = .ohSheGlows
			case RecipeContentType.againstAllGrain.rawValue:
				self = .againstAllGrain
			default:
				self = .unsupported
			}
		}
		
		//MARK: - properties
		var ingredientsQuery: String {
			switch self {
			case .ohSheGlows, .againstAllGrain:
				return "span.ingredient"
			default:
				return ""
			}
		}
		
		var instructionQuery: String {
			switch self {
			case .ohSheGlows, .againstAllGrain:
				return "li.instruction"
			default:
				return ""
			}
		}
		
		var titleQuery: String {
			switch self {
			case .ohSheGlows, .againstAllGrain:
				return "title"
			default:
				return ""
			}
		}
		
		var imageQuery: String {
			switch self {
			default:
				return "img[src]"
			}
		}
		
	}
	
	//MARK: - properties
	let url: URL
	let contentType: RecipeContentType
	
	lazy var document: Document? = { [unowned self] in
		var doc: Document? = nil
		do {
			let html = try String(contentsOf: url, encoding: String.Encoding.utf8)
			doc = try SwiftSoup.parse(html)
		} catch let error {
			print("There was an error trying to pars the URL: \(url) error: \(error)")
		}
		
		return doc
	}()
	
	lazy var ingredientList: [String] = { [unowned self] in
		var ingredientList: [String] = []
		do {
			ingredientList = try executeQuery(query: contentType.ingredientsQuery).map({ try $0.text() })
		} catch let error {
			printDebug("There was an error trying to select the ingredient list query. \(error)")
		}
		return ingredientList
	}()
	
	lazy var instructionList: [String] = { [unowned self] in
		var instructionList: [String] = []
		do {
			instructionList = try executeQuery(query: contentType.instructionQuery).map({ try $0.text() })
		} catch let error {
			printDebug("There was an error trying to select the instruction list query. \(error)")
		}
		return instructionList
	}()
	
	lazy var titleList: [String] = { [unowned self] in
		var titleList: [String] = []
		do {
			titleList = try executeQuery(query: contentType.titleQuery).map({ try $0.text() })
		} catch let error {
			printDebug("There was an error trying to select the title list query. \(error)")
		}
		return titleList
	}()
	
	lazy var images: [URL?] = { [unowned self] in
		var imageList: [URL?] = []
		do {
			imageList = try executeQuery(query: contentType.imageQuery).map({ (element) -> URL? in
				let text = try element.attr("src")
				return URL(string: "https:\(text)")
			})
		} catch let error {
			printDebug("There was an error trying to select the title list query. \(error)")
		}
		
		return imageList
	}()
	
	//MARK: - Initializers
	init(newURL: URL) {
		url = newURL
		contentType = RecipeContentType(host: url.host)
		super.init()
	}
}

// MARK: - Recipe Object
extension RecipeParser {
	func recipe() -> Recipe {
		return Recipe(name: titleList.first ?? "", ingredients: ingredients(), instructions: instructionList, image: nil, tags: [], source: url.path)
	}
	
	func ingredients() -> [Ingredient] {
		var ingredients: [Ingredient] = []
		let ingredientTagger = IngredientLinguisticTagger(tagSchemes: NSLinguisticTagger.availableTagSchemes(forLanguage: "en"), options: 0)
		for ingredientString in ingredientList {
			ingredientTagger.string = ingredientString
			ingredients += ingredientTagger.ingredients()
		}
		return ingredients
	}
}

// MARK: - Utilities
extension RecipeParser {
	func executeQuery(query: String) throws  -> Elements {
		var e = Elements()
		guard let document = document else {
			print("No document returning empty element.")
			return e
		}
		e = try document.select(query)
		
		return e
	}
}

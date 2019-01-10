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
		
	}
	
	//MARK: - properties
	let url: URL
	let contentType: RecipeContentType
	
	lazy var documentOrNil: Document? = { [unowned self] in
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
		var ingredientsList: [String] = []
		guard let document = documentOrNil else {
			print("No document returning empty ingredient list.")
			return ingredientsList
		}
		
		let query = contentType.ingredientsQuery
		do {
			ingredientsList = try document.select(query).map({ try $0.text() })
		} catch let error {
			print("There was an error trying to select the ingredeint query \(query). Error - \(error)")
		}
		return ingredientsList
	}()
	
	lazy var instructionList: [String] = { [unowned self] in
		var instructionList: [String] = []
		guard let document = documentOrNil else {
			print("No document returning empty instruction list.")
			return instructionList
		}
		
		let query = contentType.instructionQuery
		do {
			instructionList = try document.select(query).map({ try $0.text() })
		} catch let error {
			print("There was an error trying to select the instruction query \(query). Error - \(error)")
		}
		return instructionList
	}()
	
	lazy var titleList: [String] = { [unowned self] in
		var titleList: [String] = []
		guard let document = documentOrNil else {
			print("No document returning empty instruction list.")
			return instructionList
		}
		
		let query = contentType.titleQuery
		do {
			titleList = try document.select(query).map({ try $0.text() })
		} catch let error {
			print("There was an error trying to select the instruction query \(query). Error - \(error)")
		}
		return titleList
	}()
	
	//MARK: - Initializers
	init(newURL: URL) {
		url = newURL
		contentType = RecipeContentType(host: url.host)
		super.init()
	}
}

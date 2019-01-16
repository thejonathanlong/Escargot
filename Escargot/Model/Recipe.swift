//
//  Recipe.swift
//  Escargot
//
//  Created by Jonathan Long on 1/11/19.
//  Copyright © 2019 Heavenly Flower. All rights reserved.
//

import UIKit
import CloudKit

class Recipe: NSObject {
	//MARK: - CloudKit Record Keys
	static let recordNameKey = "name"
	static let recordIngredientsKey = "ingredients"
	static let recordInstructionsKey = "instructions"
	static let recordImageKey = "image"
	static let recordTagsKey = "tags"
	static let recordSourceKey = "source"
	
	//MARK: - properties
	let name: String
	var ingredients: [Ingredient] = []
	let instructions: [String]
	let image: UIImage?
	let tags: [String]
	let source: String
	
	var backingRecord: CKRecord?
	
	internal let ingredientRecordIDs: [CKRecord.ID]
	
	//MARK: - initializers
	override init() {
		self.name = ""
		self.tags = []
		self.instructions = []
		self.image = nil
		self.ingredientRecordIDs = []
		self.source = ""
		super.init()
	}
	
	init(name: String, ingredients: [Ingredient], instructions: [String], image: UIImage?, tags: [String], source: String) {
		self.name = name
		self.instructions = instructions
		self.image = image
		self.tags = tags
		self.ingredients = ingredients
		ingredientRecordIDs = []
		self.source = source
		super.init()
	}
	
	init(record: CKRecord) {
		backingRecord = record
		name = record[Recipe.recordNameKey] as! String
		if let references = record[Recipe.recordIngredientsKey] as? [CKRecord.Reference] {
			let recordIDs = references.map{ $0.recordID}
			ingredientRecordIDs = recordIDs
		}
		else {
			ingredientRecordIDs = []
		}
		
		instructions = record[Recipe.recordInstructionsKey] as! [String]
		image = Recipe.recipeImage(record)
		
		tags = record[Recipe.recordTagsKey] != nil ? record[Recipe.recordTagsKey] as! [String] : []
		source = record[Recipe.recordSourceKey] != nil ?  record[Recipe.recordSourceKey] as! String : ""
		super.init()
	}
	
	//MARK: Helpers
	static func recipeImage(_ record: CKRecord) -> UIImage? {
		guard let asset = record[Recipe.recordImageKey] as? CKAsset else { return nil }
		
		return UIImage(contentsOfFile: asset.fileURL.path)
	}
	
	//MARK: Ingredient Interaction
	// This method might take a long time to finish...
	func loadAllIngredients() {
		loadIngredients(ingredientRecordIDs, shouldWaitForIngredientsToLoad: true)
	}
	
	func loadIngredients(_ recordIDs: [CKRecord.ID], shouldWaitForIngredientsToLoad: Bool) {
		let ingredientsFetchOperation = CKFetchRecordsOperation(recordIDs: recordIDs)
		let allIngredientsLoadedSemaphore = DispatchSemaphore(value: 0)
		
		if shouldWaitForIngredientsToLoad {
			ingredientsFetchOperation.fetchRecordsCompletionBlock = { [unowned self] recordsByRecordIDOrNil, errorOrNil in
				guard let recordsByRecordID = recordsByRecordIDOrNil else { print("There were no records for the ingredient record IDs."); return }
				
				self.ingredients.append(contentsOf: recordsByRecordID.values.map{ Ingredient(record: $0) })
				print("All ingredients loaded!")
				allIngredientsLoadedSemaphore.signal()
			}
			
			print("Waiting for all ingredients to load.")
			ingredientsFetchOperation.start()
			allIngredientsLoadedSemaphore.wait()
		}
		else {
			ingredientsFetchOperation.perRecordCompletionBlock = { [unowned self] recordOrNil, recordIDOrNil, errorOrNil in
				guard let ingredientRecord = recordOrNil else { print("record was nil for record ID \(String(describing: recordIDOrNil))"); return }
				
				let ingredient = Ingredient(record: ingredientRecord)
				self.ingredients.append(ingredient)
			}
			ingredientsFetchOperation.start()
		}
	}
}

// MARK: - Record from Recipe
extension Recipe {
	var record: CKRecord {
		if let record = backingRecord {
			return record
		}
		else {
			let recordID = CKRecord.ID(zoneID: EscargotDatabase.shared.recipeZone!.zoneID)
			let record = CKRecord(recordType: EscargotDatabase.recipeRecordType, recordID: recordID)
			record[Recipe.recordNameKey] = name as CKRecordValue
			if tags.count != 0 {
				record[Recipe.recordTagsKey] = tags as CKRecordValue
			}
			
			record[Recipe.recordInstructionsKey] = instructions as CKRecordValue
			record[Recipe.recordSourceKey] = source as CKRecordValue
			//		if let image = image {
			//			record[Recipe.recordImageKey] = image as? CKRecordValue
			//		}
			
			return record
		}
	}
}

//MARK: - Debug
extension Recipe {
	override var debugDescription: String {
		return "\(Unmanaged.passUnretained(self).toOpaque()):\n\t\(ingredients)\n\t\(tags)"
	}
	override var description: String {
		return debugDescription
	}
}

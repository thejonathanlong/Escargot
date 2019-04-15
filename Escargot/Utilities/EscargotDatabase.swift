//
//  EscargotDatabase.swift
//  Cooks
//
//  Created by Heavenly Flower on 11/15/17.
//  Copyright © 2018 Heavenly Flower. All rights reserved.
//

import UIKit
import CloudKit

// MARK: - SousChefDatabase Class
class EscargotDatabase: NSObject {
	static let recipeRecordType = "Recipe"
	static let ingredientRecordType = "Ingredient"
	static let measurementRecordType = "Measurement"
	
	static let recipeRecordZoneName = "EscargotRecipes"
	
	static let cloudKitContainerIdentifier = "iCloud.com.flower.heavenly.Escargot"
	let cloudKitContainer = CKContainer(identifier: EscargotDatabase.cloudKitContainerIdentifier)
	
	let publicDB: CKDatabase
	let privateDB: CKDatabase
	
	var recipeZone: CKRecordZone?
	
	static let shared = EscargotDatabase()
	
	var status = EscargotDatabaseStatus.unknown {
		didSet {
			NotificationCenter.default.post(name: EscargotDatabase.statusDidChangeNotification, object: self)
		}
	}
	override init() {
		publicDB = cloudKitContainer.publicCloudDatabase
		privateDB = cloudKitContainer.privateCloudDatabase
		super.init()
		let recipeRecordZoneID = CKRecordZone.ID(zoneName: EscargotDatabase.recipeRecordZoneName, ownerName: CKCurrentUserDefaultName)
		let recipeRecordZoneFetchOperation = CKFetchRecordZonesOperation(recordZoneIDs: [recipeRecordZoneID])
		recipeRecordZoneFetchOperation.fetchRecordZonesCompletionBlock = { [weak self] (recordZonesByZoneID, error) in
			guard let strongSelf = self else { return }
			if error == nil {
				guard let recordZonesByZoneID = recordZonesByZoneID else { strongSelf.status = .failed; print("No recordZonesByZoneID in Record Zones fetch"); return }
				strongSelf.recipeZone = recordZonesByZoneID[recipeRecordZoneID]
				strongSelf.status = .loaded
			}
			else if let error = error as? CKError {
				print("There was an error \(error)")
				let databseError = strongSelf.handle(error)
				
				if databseError == EscargotDatabseError.zoneNotFound {
					strongSelf.recipeZone = strongSelf.createAndSaveZoneNamed(name: EscargotDatabase.recipeRecordZoneName)
					strongSelf.status = .loaded
				} else {
					strongSelf.status = .failed
				}
			}
		}
		
		privateDB.add(recipeRecordZoneFetchOperation)
	}
}

// MARK: - Fetching Recipes
typealias RecipeFetchCompletion = ([Recipe]) -> Void

extension EscargotDatabase {
	func recipe(named: String, completion: @escaping RecipeFetchCompletion) {
		recipe(named: named, loadingIngredients: false, completion: completion)
	}
	
	func recipe(named: String, loadingIngredients: Bool, completion: @escaping RecipeFetchCompletion) {
		let predicate = NSPredicate(format: "name = %@", named)
		databaseRecipeQuery(predicate: predicate, loadingIngredients: loadingIngredients, completion: completion)
	}
	
	func recipes(completion: @escaping RecipeFetchCompletion) {
		databaseRecipeQuery(predicate: NSPredicate(value: true), loadingIngredients: true, completion: completion)
	}
	
	func recipe(tagged: String, completion: @escaping RecipeFetchCompletion) {
		let predicate = NSPredicate(format: "tags CONTAINS[cd] %@", tagged)
		databaseRecipeQuery(predicate: predicate, loadingIngredients: true, completion: completion)
	}
	
	func databaseRecipeQuery(predicate: NSPredicate, loadingIngredients: Bool, completion: @escaping RecipeFetchCompletion) {
		
		if let zoneID = recipeZone?.zoneID {
			let recipeQuery = CKQuery(recordType: EscargotDatabase.recipeRecordType, predicate: predicate)
			
			privateDB.perform(recipeQuery, inZoneWith: zoneID) { (records, error) in
				guard let records = records else {
					print("rcords were nil for query: \(recipeQuery)")
					completion([])
					return
				}
				
				let recipes = self.recipesfrom(records: records)
				if loadingIngredients {
					recipes.forEach{ $0.loadAllIngredients() }
				}
				completion(recipes)
			}
		}
		else {
			completion([])
		}
	}
	
	func recipesfrom(records: [CKRecord]) -> [Recipe] {
		let recipes = records.map{ Recipe(record: $0) }
		return recipes
	}
	
//	func recipeWith
}

// MARK: - Fetching Ingredients
typealias IngredientFetchCompletion = ([Ingredient]) -> Void

extension EscargotDatabase {
	
	func ingredients(for recipe: Recipe, completion: @escaping IngredientFetchCompletion) {
		let predicate = NSPredicate(format: "name = %@", recipe.name)
		let query = CKQuery(recordType: EscargotDatabase.recipeRecordType, predicate: predicate)
		if let zoneID = recipeZone?.zoneID {
			privateDB.perform(query, inZoneWith: zoneID) { (records, error) in
				guard let records = records, let firstRecord = records.first else {
					print("records were nil for query: \(query)")
					completion([])
					return
				}
				let recipe = Recipe(record: firstRecord)
				recipe.loadAllIngredients()
				
				completion(recipe.ingredients)
			}
		}
		else {
			completion([])
		}
	}
	
	func ingredient(from reference: CKRecord.Reference, completion: @escaping IngredientFetchCompletion) {
		let predicate = NSPredicate(format: "recordName = %@", reference.recordID.recordName)
		let query = CKQuery(recordType: EscargotDatabase.ingredientRecordType, predicate: predicate)
		if let zoneID = recipeZone?.zoneID {
			privateDB.perform(query, inZoneWith: zoneID) { (records, error) in
				guard let records = records, let firstRecord = records.first else {
					print("records were nil for query: \(query)")
					completion([])
					return
				}
				
				completion([Ingredient(record: firstRecord)])
			}
		}
		else {
			completion([])
		}
	}
}


// MARK: - Saving Recipes
extension EscargotDatabase {
	
	func save(recipe: Recipe, onCompletionBlock: @escaping ([CKRecord]?, [CKRecord.ID]?, Error?) -> Void) {
		var recordsToSave: [CKRecord] = []
		var ingredientReferences: [CKRecord.Reference] = []
		
		let recipeRecord = recipe.record
		if let recipeImage = recipe.image {
			recipeRecord[Recipe.recordImageKey] = imageAsset(recipeRecord: recipeRecord, image: recipeImage)
		}
		
		for ingredient in recipe.ingredients {
			let ingredientRecord = ingredient.record
//			ingredientRecord.parent = CKReference(record: recipeRecord, action: .none)
			recordsToSave.append(ingredientRecord)
			ingredientReferences.append(CKRecord.Reference(record: ingredientRecord, action: .deleteSelf))
		}
		recipeRecord[Recipe.recordIngredientsKey] = ingredientReferences as CKRecordValue
		recordsToSave.append(recipeRecord)
		
		let modifyRecordsOperation = CKModifyRecordsOperation(recordsToSave: recordsToSave, recordIDsToDelete: nil)
		modifyRecordsOperation.modifyRecordsCompletionBlock = { recordsOrNil, reocrdIDsOrNil, errorOrNil in
			recipe.backingRecord = recipeRecord
			onCompletionBlock(recordsOrNil, reocrdIDsOrNil, errorOrNil)
		}
		modifyRecordsOperation.savePolicy = .changedKeys
		modifyRecordsOperation.database = privateDB
		modifyRecordsOperation.start()
	}
	
	func imageAsset(recipeRecord: CKRecord, image: UIImage) -> CKAsset {
		let temporaryDirectoryPath = NSTemporaryDirectory() as NSString
		
		let imagePath = temporaryDirectoryPath.appendingPathComponent(recipeRecord.recordID.recordName)
		let imageURL = URL(fileURLWithPath: imagePath.appendingFormat(".%@.dat", UUID().uuidString))
		let data = image.pngData()
		do {
			try data?.write(to: imageURL)
		}
		catch {
			print("There was an error writing to \(imageURL)")
		}
		
		return CKAsset(fileURL: imageURL)
	}
}

// MARK: - Deleting Recipes
extension EscargotDatabase {
	func delete(recipe: Recipe, completion: @escaping (CKRecord.ID?, Error?) -> Void) {
		privateDB.delete(withRecordID: recipe.record.recordID, completionHandler: completion)
	}
}

// MARK: - Saving Ingredients
extension EscargotDatabase {
	func saveSynchronously(ingredient item: String, original: String, measurementAmount: Double, measurementType: String) -> CKRecord.ID {
		let ingredientRecord = CKRecord(recordType: EscargotDatabase.ingredientRecordType)
		ingredientRecord[Ingredient.recordItemKey] = item as CKRecordValue
		ingredientRecord[Ingredient.recordOriginalKey] = original as CKRecordValue
		ingredientRecord[Ingredient.recordMeasurementAmountKey] = measurementAmount as CKRecordValue
		ingredientRecord[Ingredient.recordMeasurementTypeKey] = measurementType as CKRecordValue
		
		let semaphore = DispatchSemaphore(value: 0)
		var recordID = CKRecord.ID(recordName: EscargotDatabase.ingredientRecordType)
		privateDB.save(ingredientRecord) { (recordOrNil, errorOrNil) in
			guard let ingredientRecord = recordOrNil else { print("There was a problem saving the record..."); return }
			if let error = errorOrNil {
				print("There was a problem saving the record...\(error)")
				return
			}
			recordID = ingredientRecord.recordID
		}
		semaphore.wait()
		
		return recordID
	}
	
	func saveSynchronously(ingredient: Ingredient) -> CKRecord.ID {
		return saveSynchronously(ingredient: ingredient.item, original: ingredient.original, measurementAmount: ingredient.measurement.amount, measurementType: ingredient.measurement.type.rawValue)
	}
}

// MARK: - Zone Creation
extension EscargotDatabase {
	
	func createAndSaveZoneNamed(name: String) -> CKRecordZone {
		let newZone = CKRecordZone(zoneName: name)
		let modifyZones = CKModifyRecordZonesOperation(recordZonesToSave: [newZone], recordZoneIDsToDelete: nil)
		privateDB.add(modifyZones)
		modifyZones.modifyRecordZonesCompletionBlock = { [weak self] (savedRecordZones, deletedRecordZoneIDs, error) in
			guard let strongSelf = self else { return }
			if error == nil {
				guard let savedRecordZones = savedRecordZones else { print("No record zones were saved..."); return }
				print("Saved Zones = \(savedRecordZones)")
			}
			else if let error = error as? CKError {
				let _ = strongSelf.handle(error)
			}
		}
		
		return newZone
	}
}

// MARK: - CloudKit Error handling
extension EscargotDatabase {
	enum EscargotDatabseError: Int {
		case unknown = 1
		case zoneNotFound = 26
		
	}
	
	func handle(_ error: CKError) -> EscargotDatabseError {
		print("\(#function) - \(error)")
		var databaseError = EscargotDatabseError.unknown
		
		switch error.code {
		case .partialFailure:
			if let partialErrorsByItemID = error.partialErrorsByItemID {
				for partialError in partialErrorsByItemID.values {
					if let partialCloudKitError = partialError as? CKError, partialCloudKitError.code == CKError.zoneNotFound {
						databaseError = EscargotDatabseError.zoneNotFound
						break
					}
				}
			}
			
		default:
			break
		}
		
		return databaseError
	}
}

//MARK: - Enum Status
extension EscargotDatabase {
	static let statusDidChangeNotification = NSNotification.Name("EscargotDatabse.statusDidChangeNotification")
	enum EscargotDatabaseStatus: Int {
		case unknown = 0
		case loaded = 1
		case failed = 2
	}
}


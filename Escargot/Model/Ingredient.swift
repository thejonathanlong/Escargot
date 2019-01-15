//
//  Ingredient.swift
//  Cooks
//
//  Created by Heavenly Flower on 11/14/17.
//  Copyright © 2017 jlo. All rights reserved.
//

import Foundation
import CloudKit

class Ingredient: NSObject {
	let measurement: Measurement
	let item: String
	let original: String
	//Had to add plurals because of a new bug in ios 12. I need to write it still.
	static let usMeasurementLemma = Set(["pound", "gallon", "ounce", "quart", "cup", "pint", "tablespoon", "teaspoon", "dash", "pinch", "can", "pounds", "gallons", "ounces", "quarts", "cups", "pints", "tablespoons", "teaspoons", "dashes", "pinches", "cans", "lb", "oz", "c", "tbsp", "tsp"])
	static let metricMeasurementLemma = Set(["liter", "gram", "milliliter", "kilogram", "liters", "grams", "milliliters", "kilograms", "g", "l", "ml", "kg"])
	
	var itemDescription: String {
		return debugDescription
	}
	
	var originalDescription: String {
		return description
	}
	
	override var description: String {
		return "\(original)"
	}
	
	override var debugDescription: String {
		return "\(measurement.amount) \(measurement.type) \(item)"
	}
	
	init(measurementType: MeasurementType, amount: Double, item: String, original: String) {
		
		switch measurementType {
		case .can:
			measurement = CanMeasurement(amount: amount)
			
		case .cup:
			measurement = CupMeasurement(amount: amount)
			
		case .teaspoon:
			measurement = TeaspoonMeasurement(amount: amount)
			
		case .tablespoon:
			measurement = TablespoonMeasurement(amount: amount)
			
		case .gallon:
			measurement = GallonMeasurement(amount: amount)
			
		case .ounce:
			measurement = OunceMeasurement(amount: amount)
			
		case .quart:
			measurement = QuartMeasurement(amount: amount)
			
		case .other:
			measurement = OtherMeasurement(amount: amount)
			
		case .pound:
			measurement = PoundMeasurement(amount: amount)
			
		}
		
		self.item = item
		self.original = original
	}
}

// MARK: - Records
extension Ingredient {
	static let recordItemKey = "item"
	static let recordOriginalKey = "original"
	static let recordMeasurementTypeKey = "measurementType"
	static let recordMeasurementAmountKey = "measurementAmount"
	
	convenience init(record: CKRecord) {
		let measurementType = record[Ingredient.recordMeasurementTypeKey] as! String
		let measurementAmount = record[Ingredient.recordMeasurementAmountKey] as! Double
		self.init(measurementType: MeasurementType(rawValue: measurementType.lowercased())!, amount: measurementAmount, item: record[Ingredient.recordItemKey] as! String, original: record[Ingredient.recordOriginalKey] as! String)
		
	}
	
	var record: CKRecord {
		let ingredientRecord = CKRecord(recordType: EscargotDatabase.ingredientRecordType, zoneID: EscargotDatabase.shared.recipeZone!.zoneID)
		ingredientRecord[Ingredient.recordItemKey] = item as CKRecordValue
		ingredientRecord[Ingredient.recordOriginalKey] = original as CKRecordValue
		ingredientRecord[Ingredient.recordMeasurementAmountKey] = measurement.amount as CKRecordValue
		ingredientRecord[Ingredient.recordMeasurementTypeKey] = measurement.type.rawValue as CKRecordValue
		
		return ingredientRecord
	}
}

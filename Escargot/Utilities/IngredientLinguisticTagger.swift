//
//  IngredientLinguisticTagger.swift
//  Cooks
//
//  Created by Heavenly Flower on 10/6/17.
//  Copyright © 2017 Heavenly Flower. All rights reserved.
//

import UIKit

let DEBUG = true
func printDebug(_ s: String) {
	if DEBUG {
		print(s)
	}
}

struct TaggedIngredient {
	
}

class IngredientLinguisticTagger: NSLinguisticTagger {
	
	static let exceptions = ["thyme", "cinnamon", "salt", "quinoa"]
	
	func ingredients() -> [Ingredient] {
		assert(string != nil)
		guard let inputString = self.string else { return [] }
		let ingredientTexts = inputString.split(separator: "\n")
		var ingredients: [Ingredient] = []
		
		for ingredientText in ingredientTexts {
			string = String(ingredientText).lowercased()
			enumerateTags(using: { (ingredient) in
				ingredients.append(ingredient)
			});
		}
		
		return ingredients
	}
	
	func enumerateTags(using block: (Ingredient) -> Void) {
		guard let inputString = self.string else { return }
//		var measurementRanges: Array<NSRange> = Array<NSRange>()
		var measurementTypes : [MeasurementType] = []
		
		var measurementType: MeasurementType = .other
		// gonna have to redo this. Probably search the string for the usmeasurements and the
		for usMeasurement in Ingredient.usMeasurementLemma {
			if inputString.contains(" \(usMeasurement) ") {
				measurementType = MeasurementType(rawValue: usMeasurement)!
				break;
			}
			
		}
		if measurementType == .other {
			for metricMeasurement in Ingredient.metricMeasurementLemma {
				if inputString.contains(" \(metricMeasurement) ") {
					measurementType = MeasurementType(rawValue: metricMeasurement)!
					break;
				}
			}
		}
		
		
//		self.enumerateTags(in: NSMakeRange(0, inputString.count), unit: .word, scheme: NSLinguisticTagScheme.lemma, options: .omitWhitespace) { (tag, range, stop) in
//			let token = inputString[range.location..<range.location + range.length]
////			guard let measurementTag = tag else { return }
//			if !Ingredient.usMeasurementLemma.contains(measurementTag.rawValue) && !Ingredient.metricMeasurementLemma.contains(measurementTag.rawValue) { return }
//			let type = MeasurementType(rawValue: measurementTag.rawValue)!
//			measurementTypes.append(type)
//			measurementRanges.append(range)
//		}
		
		
		var currentMeasurementTypeIndex = 0
		
		var nounsAndAdjectives: [String] = []
		var specifiedAmount: [String] = []
		var lastTag = ""
		var ingredientAmount = 0.0
		var isParenthetical = false
		
		var numNouns = 0
		self.enumerateTags(in: NSMakeRange(0, inputString.count), unit: .word, scheme: NSLinguisticTagScheme.lexicalClass, options: .omitWhitespace) { (optionalTag, range, stop) in
			guard let tag = optionalTag else { return }
			let start = inputString.index(inputString.startIndex, offsetBy: range.location)
			let end = inputString.index(inputString.startIndex, offsetBy: (range.location + range.length))
			let tokenInQuestion = String(inputString[start..<end])
			
			if Ingredient.usMeasurementLemma.contains(tokenInQuestion) || Ingredient.metricMeasurementLemma.contains(tokenInQuestion) {
				if !isParenthetical {
					for amount in specifiedAmount {
						ingredientAmount += amount.fraction
					}
//					measurementType = currentMeasurementTypeIndex < measurementTypes.count ? measurementTypes[currentMeasurementTypeIndex] : .other
				}
				currentMeasurementTypeIndex += 1
				return
			}
			
			let lowerCasedToken = tokenInQuestion.lowercased()
			let containsWhiteListedToken = Ingredient.usMeasurementLemma.contains(lowerCasedToken) || Ingredient.metricMeasurementLemma.contains(lowerCasedToken)
			if containsWhiteListedToken { return }
			
			//Debug log...
			printDebug("token: \(tokenInQuestion) tag:\(tag.rawValue)")
			
			switch tag {
				
			case .number, .otherWord:
				let isNumber = Int(tokenInQuestion) != nil
				if !isParenthetical && isNumber {
					if lastTag == NSLinguisticTag.punctuation.rawValue{
						specifiedAmount[specifiedAmount.count - 1].append(tokenInQuestion)
					} else if lastTag == NSLinguisticTag.number.rawValue || lastTag.isEmpty || lastTag == NSLinguisticTag.conjunction.rawValue {
						specifiedAmount.append(tokenInQuestion)
					}
				}
				if !isNumber {
					nounsAndAdjectives.append(tokenInQuestion)
				}
			
			case .openParenthesis:
				isParenthetical = true
			
			case .closeParenthesis:
				isParenthetical = false
				
			case .punctuation:
				if lastTag == NSLinguisticTag.number.rawValue {
					specifiedAmount[specifiedAmount.count - 1].append(tokenInQuestion)
				}
				
			case .noun:
				if !isParenthetical {
					numNouns += 1
					nounsAndAdjectives.append(tokenInQuestion)
				}
				
			case .adjective:
				if !isParenthetical {
					nounsAndAdjectives.append(tokenInQuestion)
				}
				
			default:
				break
			}
			
			if IngredientLinguisticTagger.exceptions.contains(tokenInQuestion) && !nounsAndAdjectives.contains(tokenInQuestion) && !isParenthetical {
				nounsAndAdjectives.append(tokenInQuestion)
			}
			
			lastTag = Int(tokenInQuestion) != nil ? NSLinguisticTag.number.rawValue : tag.rawValue
		}
		
		ingredientAmount = ingredientAmount == 0 && specifiedAmount.count > 0 ? specifiedAmount[0].fraction: ingredientAmount
		let item = nounsAndAdjectives.joined(separator: " ")
		let ingredient = Ingredient(measurementType: measurementType, amount: ingredientAmount, item: item, original: inputString)
		print(ingredient)
		print(numNouns)
		block(ingredient)
	}
}

extension String {
	var fraction: Double {
		get {
			if self.contains("/") {
				let numbers = self.split(separator: "/")
				if numbers.count < 2 { return -1 }
				guard var first = numbers.first else { return -1 }
				guard let last = numbers.last else { return -1 }
				var num = Double(0)
				if first.contains(" ") {
					let newFirst = first.split(separator: " ")
					num = Double(String(newFirst.first!))!
					first = newFirst.last!
				}
				
				guard let numerator = Double(String(first)) else { return -1 }
				guard let denominator = Double(String(last)) else { return -1 }
				
				return (numerator + num) / denominator
			} else {
				return Double(self)!
			}
		}
	}
}

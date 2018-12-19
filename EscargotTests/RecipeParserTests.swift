//
//  RecipeParserTests.swift
//  EscargotTests
//
//  Created by Jonathan Long on 12/18/18.
//  Copyright © 2018 Heavenly Flower. All rights reserved.
//

import XCTest

class RecipeParserTests: XCTestCase {
	let ohSheGlowsPath = "https://ohsheglows.com/2018/11/24/instant-pot-creamiest-steel-cut-oatmeal-with-stovetop-version/"
		
    //MARK: - Setup
    override func setUp() {
    }

    override func tearDown() {
    }
    
    //MARK: - Initializer Tests
    func testInit() {
		guard let parser = ohSheGlowsRecipeParser() else {
			XCTAssert(false, "Failed to create a Recipe Parser")
			return
		}
        XCTAssert(parser.url.path == ohSheGlowsPath)
    }
    
    func testContentType() {
        guard let parser = ohSheGlowsRecipeParser() else {
            XCTAssert(false, "Failed to create a Recipe Parser")
            return
        }
        XCTAssert(parser.contentType == .ohSheGlows)
    }
	
	func testIngredientsQuery() {
		guard let parser = ohSheGlowsRecipeParser() else {
			XCTAssert(false, "Failed to create a Recipe Parser")
			return
		}
		
		XCTAssert(parser.contentType.ingredientsQuery == "li.ingredients")
	}
	
	func testInstructionQuery() {
		guard let parser = ohSheGlowsRecipeParser() else {
			XCTAssert(false, "Failed to create a Recipe Parser")
			return
		}
		
		XCTAssert(parser.contentType.instructionQuery == "li.instruction")
	}
	
	//MARK: - Computed Property Tests
	
	func testIngredientSelection() {
		guard let parser = ohSheGlowsRecipeParser() else {
			XCTAssert(false, "Failed to create a Recipe Parser")
			return
		}
		
		let ingredients = parser.ingredientList
		
		XCTAssert(ingredients.count == 9)
		XCTAssert(ingredients == ["1 (14-ounce/398 mL) can light coconut milk", "1 cup (250 mL) water", "1 cup (172 g) uncooked steel-cut oats", "Seasonal fruit", "Pure maple syrup", "Toasted walnuts", "Dash fine sea salt, stirred in", "Cinnamon", "Raisins or chopped pitted Medjool dates"]);
	}
	
	func testInstructionSelection() {
		guard let parser = ohSheGlowsRecipeParser() else {
			XCTAssert(false, "Failed to create a Recipe Parser")
			return
		}
		
		let instructions = parser.instructionList
		
		XCTAssert(instructions.count == 3)
		XCTAssert(instructions == ["STOVETOP METHOD: Pour the can of coconut milk and 1 cup (250 mL) water into a medium pot and bring to a low boil over high heat.", "Add the steel-cut oats to the pot and stir to combine. Immediately reduce the heat to low (low heat is important or they’ll burn) and gently simmer, covered, for 30 to 40 minutes, stirring four to five times during cooking and reducing heat if necessary to prevent burning. This method produces a thick pot of oats. For a porridge-like consistency, stir more water in to your liking. I like to stir in about 1/2 cup (125 mL) water after cooking.", "Portion into bowls and top with your desired garnishes—I love the combo of pure maple syrup, toasted walnuts, seasonal fruit, fine sea salt, cinnamon, and raisins or chopped dates, but feel free to get creative and change it up depending on the season. Leftovers will keep in an airtight container in the fridge for 5 to 7 days or you can freeze them for up to 1 month. I store cooled single portions in freezer-safe bags and lie them flat in the freezer for easy stacking. Reheat refrigerated or thawed leftovers on the stovetop in a small pot along with a splash of water or milk over medium heat."])
	}
	
	func testTitleSelection() {
		guard let parser = ohSheGlowsRecipeParser() else {
			XCTAssert(false, "Failed to create a Recipe Parser")
			return
		}
		
		if let title = parser.titleList.first {
			XCTAssert(title == "Instant Pot Creamiest Steel-Cut Oatmeal (with stovetop version!) — Oh She Glows")
		}
		else {
			XCTAssert(false)
		}
		
	}
}

//MARK: - Recipe Parser Test Utilities
extension RecipeParserTests {
	func ohSheGlowsRecipeParser() -> RecipeParser? {
		guard let url = URL(string: ohSheGlowsPath) else {
			XCTAssert(false, "Failed to create a URL")
			return nil
			
		}
		return RecipeParser(newURL: url)
	}
	
	func bogusParser() -> RecipeParser? {
		guard let url = URL(string: "") else {
			XCTAssert(false, "Failed to create a URL")
			return nil
			
		}
		return RecipeParser(newURL: url)
	}
}

//
//  RecipeParserTests.swift
//  EscargotTests
//
//  Created by Heavenly Flower on 12/18/18.
//  Copyright © 2018 Heavenly Flower. All rights reserved.
//

import XCTest

class RecipeParserTests: XCTestCase {
	static let ohSheGlowsOatmealPath = "https://ohsheglows.com/2018/11/24/instant-pot-creamiest-steel-cut-oatmeal-with-stovetop-version/"
	static let ohSheGlowsCinnamonRollsPath = "https://ohsheglows.com/2017/05/09/vegan-cinnamon-rolls-with-make-ahead-option/"
	static let againstAllGrainsSpaghettiPath = "https://againstallgrain.com/2018/07/18/instant-pot-paleo-spaghetti-meat-sauce-recipe/"
		
    //MARK: - Setup
    override func setUp() {
    }

    override func tearDown() {
    }
}

//MARK: - Oh She Glows Tests
extension RecipeParserTests {
	//MARK: - Initializer Tests
	func testInit() {
		guard let parser = ohSheGlowsOatmealRecipeParser() else {
			XCTAssert(false, "Failed to create a Recipe Parser")
			return
		}
		XCTAssert(parser.url.absoluteString == RecipeParserTests.ohSheGlowsOatmealPath)
	}
	
	func testContentType() {
		guard let parser = ohSheGlowsOatmealRecipeParser() else {
			XCTAssert(false, "Failed to create a Recipe Parser")
			return
		}
		XCTAssert(parser.contentType == .ohSheGlows)
	}
	
	func testIngredientsQuery() {
		guard let parser = ohSheGlowsOatmealRecipeParser() else {
			XCTAssert(false, "Failed to create a Recipe Parser")
			return
		}
		
		XCTAssert(parser.contentType.ingredientsQuery == "span.ingredient")
	}
	
	func testInstructionQuery() {
		guard let parser = ohSheGlowsOatmealRecipeParser() else {
			XCTAssert(false, "Failed to create a Recipe Parser")
			return
		}
		
		XCTAssert(parser.contentType.instructionQuery == "li.instruction")
	}
	
	// Cinnamon Rolls URL
	func testInit2() {
		guard let parser = ohSheGlowsCinnamonRollsParser() else {
			XCTAssert(false, "Failed to create a Recipe Parser")
			return
		}
		XCTAssert(parser.url.absoluteString == RecipeParserTests.ohSheGlowsCinnamonRollsPath)
	}
	
	//MARK: - Computed Property Tests
	
	func testIngredientSelectionOatmealRecipe() {
		guard let parser = ohSheGlowsOatmealRecipeParser() else {
			XCTAssert(false, "Failed to create a Recipe Parser")
			return
		}
		
		let ingredients = parser.ingredientList
		
		XCTAssert(ingredients.count == 9)
		XCTAssert(ingredients == ["1 (14-ounce/398 mL) can light coconut milk", "1 cup (250 mL) water", "1 cup (172 g) uncooked steel-cut oats", "Seasonal fruit", "Pure maple syrup", "Toasted walnuts", "Dash fine sea salt, stirred in", "Cinnamon", "Raisins or chopped pitted Medjool dates"]);
	}
	
	func testInstructionSelectionOatmealRecipe() {
		guard let parser = ohSheGlowsOatmealRecipeParser() else {
			XCTAssert(false, "Failed to create a Recipe Parser")
			return
		}
		
		let instructions = parser.instructionList
		
		XCTAssert(instructions.count == 3)
		XCTAssert(instructions == ["STOVETOP METHOD: Pour the can of coconut milk and 1 cup (250 mL) water into a medium pot and bring to a low boil over high heat.", "Add the steel-cut oats to the pot and stir to combine. Immediately reduce the heat to low (low heat is important or they’ll burn) and gently simmer, covered, for 30 to 40 minutes, stirring four to five times during cooking and reducing heat if necessary to prevent burning. This method produces a thick pot of oats. For a porridge-like consistency, stir more water in to your liking. I like to stir in about 1/2 cup (125 mL) water after cooking.", "Portion into bowls and top with your desired garnishes—I love the combo of pure maple syrup, toasted walnuts, seasonal fruit, fine sea salt, cinnamon, and raisins or chopped dates, but feel free to get creative and change it up depending on the season. Leftovers will keep in an airtight container in the fridge for 5 to 7 days or you can freeze them for up to 1 month. I store cooled single portions in freezer-safe bags and lie them flat in the freezer for easy stacking. Reheat refrigerated or thawed leftovers on the stovetop in a small pot along with a splash of water or milk over medium heat."])
	}
	
	func testTitleSelectionOatmealRecipe() {
		guard let parser = ohSheGlowsOatmealRecipeParser() else {
			XCTAssert(false, "Failed to create a Recipe Parser")
			return
		}
		
		if let title = parser.titleList.first {
			XCTAssert(title == "Instant Pot Creamiest Steel-Cut Oatmeal (with stovetop version!) — Oh She Glows")
		}
		else {
			XCTAssert(false, "Failed to get title...")
		}
	}
	
	func testTitleSelectionCinnamonRollRecipe() {
		guard let parser = ohSheGlowsCinnamonRollsParser() else {
			XCTAssert(false, "Failed to create a Recipe Parser")
			return
		}
		
		if let title = parser.titleList.first {
			XCTAssert(title == "Vegan Cinnamon Rolls (with make-ahead option!) — Oh She Glows")
		}
		else {
			XCTAssert(false, "Failed to get title...")
		}
	}
	
	func testIngredientSelectionCinnamonRollRecipe() {
		guard let parser = ohSheGlowsCinnamonRollsParser() else {
			XCTAssert(false, "Failed to create a Recipe Parser")
			return
		}
		
		let ingredients = parser.ingredientList
		
		XCTAssert(ingredients.count == 14)
		XCTAssert(ingredients == ["1/2 cup (125 mL) warm water", "1 teaspoon (5 g) sugar", "1 packet (8 g) quick-rise instant dry yeast", "2 1/2 cups + 3 tablespoons (430 g) all-purpose white flour, plus more for kneading", "1/3 cup (67 g) vegan butter", "1/2 cup (125 mL) unsweetened almond milk", "1/3 cup (73 g) cane sugar", "1 teaspoon (6 g) fine sea salt", "1/2 cup (110 g) cane sugar", "1 1/2 tablespoons (10 g) cinnamon", "1/4 cup (50 g) vegan butter, melted", "1/4 cup (50 g) vegan butter, melted", "2 1/2 tablespoons (25 g) unpacked brown sugar or cane sugar", "Vegan Cream Cheese Frosting"]);
	}
	
	func testInstructionSelectionCinnamonRollRecipe() {
		guard let parser = ohSheGlowsCinnamonRollsParser() else {
			XCTAssert(false, "Failed to create a Recipe Parser")
			return
		}
		
		let instructions = parser.instructionList
		
		XCTAssert(instructions.count == 19)
		XCTAssert(instructions == ["Set aside a 9- by 13-inch casserole dish.", "For the yeast: In a small bowl, add the warm water. Make sure it’s not too hot; it should feel like warm bath water (approximately 110°F/45°C). Stir in the sugar until mostly dissolved. Now, stir in the yeast until dissolved. Set aside for about 6 to 7 minutes so the yeast can activate (it’ll look foamy when ready).", "For the dough: Flour a working surface for later. Add 2 cups of flour into a large mixing bowl.", "Melt 1/3 cup butter in a small saucepan over low heat. Remove the pot from the burner and stir in the almond milk, 1/3 cup sugar, and salt. The mixture should be lukewarm—if it’s any hotter let it cool off for a minute. Stir in all of the yeast mixture until just combined.", "Pour the wet yeast mixture over the flour and stir with a large wooden spoon. Stop mixing once all of the flour is incorporated and it looks a bit like muffin batter, about 15 seconds.", "Add in the remaining 1/2 cup and 3 tablespoons flour. Mix with a spoon for several seconds. Lightly oil your hands and roughly knead the mixture until it comes together into a shaggy, sticky dough. It’ll probably stick to your fingers (even with the oil), but that’s normal. Turn the dough out onto the floured surface.", "Knead the dough for about 3 to 4 minutes until it’s no longer sticky to the touch; it should be smooth and elastic. While kneading, sprinkle on a small handful of flour whenever the dough becomes sticky to the touch. Don’t be afraid to add some flour; I probably use between 1/2 and 3/4 cup while kneading. Shape the dough into a ball.", "Wash out the mixing bowl and dry it. Oil the bowl (I love to use a spray oil for ease) and place the ball of dough inside. Flip the dough around so it gets lightly coated in the oil. Tightly cover the bowl with plastic wrap and place it in the oven with the light on (or simply in a warm, draft-free area). Let the dough rise for 60 minutes.", "Meanwhile, make the cinnamon sugar filling. In a small bowl, mix 1/2 cup sugar and the cinnamon and set aside.", "Make the pan sauce: In a small pot, melt 1/2 cup butter (you can use the unwashed pot from before). Remove half of the melted butter (eyeballing it is fine) and put it in another small bowl (this will be spread onto the rolled-out dough before adding the cinnamon sugar). With the scant 1/4 cup melted butter remaining in the pot, stir in the 2 1/2 tablespoons of brown sugar until combined (this is the pan sauce). Pour the pan sauce into a 9- by 13-inch casserole dish and spread it out.", "After the first dough rise, re-flour your working surface and grab a rolling pin. Roll the dough into a large rectangle, approximately 20 by 14 inches.", "With a pastry brush, spread the remaining melted butter onto the dough, covering the entire surface. Sprinkle on all of the cinnamon sugar filling, leaving a 1/2 inch around the edges without any sugar.", "Grab the end of the dough (short side of rectangle) and roll it up, rolling as tightly as possible. Place it seam-side down once it’s rolled up. Use a serrated knife to slice 1 1/2 inch–thick rolls. You should have 10 to 12.", "Grab your cut rolls and place into the prepared pan, cut-side down, a few inches apart from one another. Cover the pan with plastic wrap, place into the oven with the light on, and allow them to rise for 45 minutes.", "Meanwhile, prepare the Vegan Cream Cheese Frosting.", "After the second rise, remove the rolls from the oven and preheat the oven to 350°F (180°C).", "Remove the plastic wrap. Bake the rolls for 23 to 26 minutes at 350°F (180°C), until lightly golden in a few spots. Remove from oven and allow the rolls to cool for about 10 minutes.", "Frost the rolls with the cream cheese frosting. Slide a butter knife around each cinnamon roll and lift it out. (Alternatively, you can pop them out first and frost each roll individually.) Serve immediately and enjoy!", "If you have leftovers, you can wrap them up and chill them in the fridge for up to 48 hours. I like to reheat unfrosted rolls in the oven on a baking sheet for 5 minutes at 350°F (180°C). The oven returns them to their amazing gooey-soft state! Alternatively, you can freeze the cooled unfrosted rolls (wrap them in a layer of plastic wrap, followed by tinfoil) for a week or two. To reheat, simply unwrap and pop them frozen onto a baking sheet and into the oven for 10 to 12 minutes at 350°F (180°C) until warmed throughout. The edges get a bit crispy, and it’s oh so good!"])
	}
}

//MARK: - Against All Grains
extension RecipeParserTests {
	//MARK: - Initializer Tests
	func testInitAgainstAllGrains() {
		guard let parser = againstAllGrainsSpaghettiRecipeParser() else {
			XCTAssert(false, "Failed to create a Recipe Parser")
			return
		}
		XCTAssert(parser.url.absoluteString == RecipeParserTests.againstAllGrainsSpaghettiPath)
	}
	
	func testContentTypeAgainstAllGrains() {
		guard let parser = againstAllGrainsSpaghettiRecipeParser() else {
			XCTAssert(false, "Failed to create a Recipe Parser")
			return
		}
		XCTAssert(parser.contentType == .againstAllGrain)
	}
	
	func testTitleQueryAgainstAllGrains() {
		guard let parser = againstAllGrainsSpaghettiRecipeParser() else {
			XCTAssert(false, "Failed to create a Recipe Parser")
			return
		}
		XCTAssert(parser.contentType.titleQuery == "title")
	}
	
	func testTitleSelectionAgainstAllGrainSpaghettiRecipe() {
		guard let parser = againstAllGrainsSpaghettiRecipeParser() else {
			XCTAssert(false, "Failed to create a Recipe Parser")
			return
		}
		
		if let title = parser.titleList.first {
			XCTAssert(title == "Instant Pot Paleo Spaghetti Meat Sauce and Spaghetti Squash Recipe | Against All Grain - Delectable paleo recipes to eat & feel great", "Actual title was - \(title)")
		}
		else {
			XCTAssert(false, "Failed to get title...")
		}
	}
	
	func testAgainstAllGrainsIngredientsQuery() {
		guard let parser = againstAllGrainsSpaghettiRecipeParser() else {
			XCTAssert(false, "Failed to create a Recipe Parser")
			return
		}
		
		XCTAssert(parser.contentType.ingredientsQuery == "span.ingredient")
	}
	
	func testAgainstAllGrainsInstructionQuery() {
		guard let parser = againstAllGrainsSpaghettiRecipeParser() else {
			XCTAssert(false, "Failed to create a Recipe Parser")
			return
		}
		
		XCTAssert(parser.contentType.instructionQuery == "li.instruction")
	}
	
	//MARK: - Computed Property Tests
	
	func testIngredientSelectionAgainstAllGrainsSpaghettiRecipe() {
		guard let parser = againstAllGrainsSpaghettiRecipeParser() else {
			XCTAssert(false, "Failed to create a Recipe Parser")
			return
		}
		
		let ingredients = parser.ingredientList
		
		XCTAssert(ingredients.count == 9)
		
		
		
		XCTAssert(ingredients == ["1 (14-ounce/398 mL) can light coconut milk", "1 cup (250 mL) water", "1 cup (172 g) uncooked steel-cut oats", "Seasonal fruit", "Pure maple syrup", "Toasted walnuts", "Dash fine sea salt, stirred in", "Cinnamon", "Raisins or chopped pitted Medjool dates"]);
	}
}

//MARK: - Recipe Parser Test Utilities
extension RecipeParserTests {
	func ohSheGlowsOatmealRecipeParser() -> RecipeParser? {
		guard let url = URL(string: RecipeParserTests.ohSheGlowsOatmealPath) else {
			XCTAssert(false, "Failed to create a URL")
			return nil
			
		}
		return RecipeParser(newURL: url)
	}
	
	func ohSheGlowsCinnamonRollsParser() -> RecipeParser? {
		guard let url = URL(string: RecipeParserTests.ohSheGlowsCinnamonRollsPath) else {
			XCTAssert(false, "Failed to create a URL")
			return nil
			
		}
		return RecipeParser(newURL: url)
	}
	
	func againstAllGrainsSpaghettiRecipeParser() -> RecipeParser? {
		guard let url = URL(string: RecipeParserTests.againstAllGrainsSpaghettiPath) else {
			XCTAssert(false, "Failed to create a URL")
			return nil
			
		}
		return RecipeParser(newURL: url)
	}
}

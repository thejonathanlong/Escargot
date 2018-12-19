//
//  RecipeParserTests.swift
//  EscargotTests
//
//  Created by Jonathan Long on 12/18/18.
//  Copyright © 2018 Heavenly Flower. All rights reserved.
//

import XCTest

class RecipeParserTests: XCTestCase {

    //MARK: - Setup
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    //MARK: - Initializer Tests
    func testInit() {
        guard let url = URL(string: "https://ohsheglows.com/2018/11/24/instant-pot-creamiest-steel-cut-oatmeal-with-stovetop-version/") else {
            XCTAssert(false, "Failed to create a URL")
            return
            
        }
        let parser = RecipeParser(newURL: url)
        XCTAssert(parser.url.path == url.path)
    }
    
    func testBaseURL() {
        guard let url = URL(string: "https://ohsheglows.com/2018/11/24/instant-pot-creamiest-steel-cut-oatmeal-with-stovetop-version/") else {
            XCTAssert(false, "Failed to create a URL")
            return
            
        }
        let parser = RecipeParser(newURL: url)
        let base = parser.baseURL()
        XCTAssert(base == "ohsheglows")
    }
}

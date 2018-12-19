//
//  RecipeParser.swift
//  Escargot
//
//  Created by Jonathan Long on 12/18/18.
//  Copyright © 2018 Heavenly Flower. All rights reserved.
//

import UIKit
import SwiftSoup

class RecipeParser: NSObject {

    //MARK: - properties
    public let url: URL
    
    //MARK: - Initializers
    init(newURL: URL) {
        url = newURL
        super.init()
    }
    
    //MARK: - utilities
    func hostURL() -> String? {
        return url.host
    }
    
    
//    func something() {
//        if let url = URL(string: "https://ohsheglows.com/2018/11/24/instant-pot-creamiest-steel-cut-oatmeal-with-stovetop-version/") {
//            let html = try String(contentsOf: url, encoding: String.Encoding.utf8)
//
//            let result = try SwiftSoup.parse(html)
//            let ingredientsClear = try result.select("ul.ingredients")
//            ingredientsClear.forEach { print($0) }
//        }
//
//
//    } catch  {
//    print("There was an error parsing the HTML. \(error)")
//    }
//    }
}

//
//  ShareViewController.swift
//  EscargotSharingExtension
//
//  Created by Jonathan Long on 1/9/19.
//  Copyright © 2019 Heavenly Flower. All rights reserved.
//

import UIKit
import Social
import CoreServices

class ShareViewController: SLComposeServiceViewController {
	
	var shareURL: URL?
	
	override func isContentValid() -> Bool {
		guard let extensionContext = extensionContext else {
			print("The ShareViewController did not have an extensionContext... this is going to be a problem.")
			return false
		}

		if let extensionItem = extensionContext.inputItems.first as? NSExtensionItem, let itemProvider = extensionItem.attachments?.first {
			itemProvider.loadItem(forTypeIdentifier: kUTTypeURL as String, options: nil) { [unowned self] (item, errorOrNil) in
				if let error = errorOrNil {
					print("There was an error loading the URL from the item provider. \(error)")
					return
				}
				
				if let itemURL = item as? URL {
					self.shareURL = itemURL
				}
				else {
					print("The resulting item was not of type URL")
				}
				
			}
			return itemProvider.hasItemConformingToTypeIdentifier(kUTTypeURL as String)
		}
		
		return false
	}
	
	override func didSelectPost() {
		
		if let shareURL = self.shareURL {
			let recipeParser = RecipeParser(newURL: shareURL)
			//1. Use the RecipeParser to create a Recipe
			//2. Upload the recipe to iCloud
		}
		
		
		
		// Inform the host that we're done, so it un-blocks its UI. Note: Alternatively you could call super's -didSelectPost, which will similarly complete the extension context.
		self.extensionContext!.completeRequest(returningItems: [], completionHandler: nil)
	}
	
	override func configurationItems() -> [Any]! {
		// To add configuration options via table cells at the bottom of the sheet, return an array of SLComposeSheetConfigurationItem here.
		return []
	}
	
}

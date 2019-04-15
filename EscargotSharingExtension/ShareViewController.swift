//
//  ShareViewController.swift
//  EscargotSharingExtension
//
//  Created by Heavenly Flower on 1/9/19.
//  Copyright © 2019 Heavenly Flower. All rights reserved.
//

import UIKit
import Social
import CoreServices

class ShareViewController: SLComposeServiceViewController {
	
	var shareURL: URL?
	var sharedDatabse = EscargotDatabase.shared
	
	override func isContentValid() -> Bool {
		guard let extensionContext = extensionContext else {
			print("The ShareViewController did not have an extensionContext... this is going to be a problem.")
			return false
		}

		if let extensionItem = extensionContext.inputItems.first as? NSExtensionItem, let itemProvider = extensionItem.attachments?.first {
			itemProvider.loadItem(forTypeIdentifier: kUTTypeURL as String, options: nil) { [weak self] (item, error) in
				guard let strongSelf = self else { return }
				if let error = error {
					print("There was an error loading the URL from the item provider. \(error)")
					return
				}
				
				if let itemURL = item as? URL {
					strongSelf.shareURL = itemURL
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
			let recipe = recipeParser.recipe()
			debugPrint("Sharing recipe: \(recipe)")
			
			sharedDatabse.save(recipe: recipe) { (records, recordIDs, error) in
				if error == nil {
					if let records = records {
						printDebug("Succesfully saved records \(records)")
					}
				} else if let error = error {
					printDebug("There was an error trying to save recipe: \(recipe). Error - \(error)")
				}
			}
			
		}
		
		
		
		// Inform the host that we're done, so it un-blocks its UI. Note: Alternatively you could call super's -didSelectPost, which will similarly complete the extension context.
		self.extensionContext!.completeRequest(returningItems: [], completionHandler: nil)
	}
	
	override func configurationItems() -> [Any]! {
		// To add configuration options via table cells at the bottom of the sheet, return an array of SLComposeSheetConfigurationItem here.
		return []
	}
	
}

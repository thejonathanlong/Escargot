//
//  RecipeTableViewCell.swift
//  Escargot
//
//  Created by Jonathan Long on 1/14/19.
//  Copyright © 2019 Heavenly Flower. All rights reserved.
//

import UIKit

class RecipeTableViewCell: UITableViewCell {
	
	static let reuseIdentifier = "RecipeTableViewCellReuseIdentifier"
	
	@IBOutlet weak var recipeImageView: UIImageView!
	@IBOutlet weak var titleLabel: UILabel!
	
	override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

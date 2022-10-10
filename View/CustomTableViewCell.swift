//
//  CustomTableViewCell.swift
//  EViOS4
//
//  Created by Cédric Debroux on 10/10/2022.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    
    static let identifier = "CustomTableViewCell"

    @IBOutlet var nameLabel: UILabel!
    
    @IBOutlet var priceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupCell(expense: Entity){
        nameLabel.text = expense.name
        priceLabel.text = expense.price.description
    }
    
}

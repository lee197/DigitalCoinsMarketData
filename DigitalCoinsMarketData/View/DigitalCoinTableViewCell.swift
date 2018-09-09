//
//  DigitalCoinTableViewCell.swift
//  DigitalCoinsMarketData
//
//  Created by 李祺 on 08/09/2018.
//  Copyright © 2018 Lee. All rights reserved.
//

import UIKit

class DigitalCoinTableViewCell: UITableViewCell {

    @IBOutlet weak var assetNameLabel: UILabel!
    
    @IBOutlet weak var assetCompareNameLabel: UILabel!
    
    
    @IBOutlet weak var volumLabel: UILabel!
    @IBOutlet weak var realPriceLabel: UILabel!
    
    @IBOutlet weak var assetComparePriceLabel: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

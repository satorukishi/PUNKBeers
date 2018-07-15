//
//  BeerTableViewCell.swift
//  RM43057
//
//  Created by Satoru Kishi on 12/07/2018.
//  Copyright © 2018 Satoru Kishi. All rights reserved.
//

import UIKit

class BeerTableViewCell : UITableViewCell {
    
    @IBOutlet weak var lbNome: UILabel!
    @IBOutlet weak var lbTeorAlcoolico: UILabel!
    @IBOutlet weak var ivBeer: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}

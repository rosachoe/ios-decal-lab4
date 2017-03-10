//
//  tableviewcell.swift
//  PokedexLab
//
//  Created by Rosa Choe on 3/9/17.
//  Copyright © 2017 iOS Decal. All rights reserved.
//

import UIKit

class tableviewcell: UITableViewCell {
    @IBOutlet weak var pokemon: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var number: UILabel!
    @IBOutlet weak var stats: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}

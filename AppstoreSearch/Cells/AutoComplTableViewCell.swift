//
//  AutoComplTableViewCell.swift
//  AppstoreSearch
//
//  Created by Eido Goya on 2020/08/29.
//  Copyright © 2020 Dymm. All rights reserved.
//

import UIKit

let autoComplTableCellId = "AutoComplTableViewCell"

class AutoComplTableViewCell: UITableViewCell {

    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var underLineView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

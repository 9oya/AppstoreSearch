//
//  InfoTableViewCell.swift
//  AppstoreSearch
//
//  Created by Eido Goya on 2020/09/01.
//  Copyright © 2020 Dymm. All rights reserved.
//

import UIKit

let infoTableCellId = "InfoTableViewCell"

class InfoTableViewCell: UITableViewCell {

    @IBOutlet weak var guideLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var underLineView: UIView!
    @IBOutlet weak var iconImgView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension InfoTableViewCell {
    private func setupLayout() {
        
    }
}

//
//  PrevCollectionViewCell.swift
//  AppstoreSearch
//
//  Created by Eido Goya on 2020/09/01.
//  Copyright © 2020 Dymm. All rights reserved.
//

import UIKit

let prevCollectionCellId = "PrevCollectionViewCell"

class PrevCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var screenShotImgView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupLayout()
    }
}

extension PrevCollectionViewCell {
    private func setupLayout() {
        layer.cornerRadius = 15.0
        screenShotImgView.layer.cornerRadius = 15.0
    }
}

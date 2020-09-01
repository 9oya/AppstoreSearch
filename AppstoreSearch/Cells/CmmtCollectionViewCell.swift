//
//  CmmtCollectionViewCell.swift
//  AppstoreSearch
//
//  Created by Eido Goya on 2020/09/01.
//  Copyright © 2020 Dymm. All rights reserved.
//

import UIKit

let cmmtCollectionCellId = "CmmtCollectionViewCell"

class CmmtCollectionViewCell: UICollectionViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        setupLayout()
    }

}

extension CmmtCollectionViewCell {
    private func setupLayout() {
        layer.cornerRadius = 10.0
    }
}

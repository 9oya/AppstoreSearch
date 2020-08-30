//
//  SearchResultTableViewCell.swift
//  AppstoreSearch
//
//  Created by Eido Goya on 2020/08/29.
//  Copyright © 2020 Dymm. All rights reserved.
//

import UIKit

let searchResultTableCellId = "SearchResultTableViewCell"

class SearchResultTableViewCell: UITableViewCell {

    @IBOutlet weak var iconImgView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    @IBOutlet weak var downCntLabel: UILabel!
    
    @IBOutlet weak var openButton: UIButton!
    
    @IBOutlet weak var star1ImgView: UIImageView!
    @IBOutlet weak var star2ImgView: UIImageView!
    @IBOutlet weak var star3ImgView: UIImageView!
    @IBOutlet weak var star4ImgView: UIImageView!
    @IBOutlet weak var star5ImgView: UIImageView!
    @IBOutlet weak var screen1ImgView: UIImageView!
    @IBOutlet weak var screen2ImgView: UIImageView!
    @IBOutlet weak var screen3ImgView: UIImageView!
    
    @IBOutlet weak var screen1HeightConst: NSLayoutConstraint!
    @IBOutlet weak var screen1WidthConst: NSLayoutConstraint!
    @IBOutlet weak var screen2HeightConst: NSLayoutConstraint!
    @IBOutlet weak var screen2WidthConst: NSLayoutConstraint!
    @IBOutlet weak var screen3HeightConst: NSLayoutConstraint!
    @IBOutlet weak var screen3WidthConst: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupLayout()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension SearchResultTableViewCell {
    private func setupLayout() {
        openButton.layer.cornerRadius = 30 / 2
        
        iconImgView.layer.cornerRadius = 10.0
        
        screen1ImgView.layer.cornerRadius = 10.0
        screen2ImgView.layer.cornerRadius = 10.0
        screen3ImgView.layer.cornerRadius = 10.0
    }
}

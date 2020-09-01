//
//  SearchDetailViewController.swift
//  AppstoreSearch
//
//  Created by Eido Goya on 2020/08/27.
//  Copyright © 2020 Dymm. All rights reserved.
//

import RIBs
import RxSwift
import UIKit

protocol SearchDetailPresentableListener: class {
    func configureView(view: SearchDetailViewController)
}

final class SearchDetailViewController: UIViewController, SearchDetailPresentable, SearchDetailViewControllable {
    
    // MARK: - Properties
    @IBOutlet weak var prevCollectionView: UICollectionView!
    @IBOutlet weak var commtCollectionView: UICollectionView!
    @IBOutlet weak var infoTableView: UITableView!
    
    @IBOutlet weak var iconImgView: UIImageView!
    @IBOutlet weak var star1ImgView: UIImageView!
    @IBOutlet weak var star2ImgView: UIImageView!
    @IBOutlet weak var star3ImgView: UIImageView!
    @IBOutlet weak var star4ImgView: UIImageView!
    @IBOutlet weak var star5ImgView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var sellerLabel: UILabel!
    @IBOutlet weak var userRatingLabel: UILabel!
    @IBOutlet weak var rankLabel: UILabel!
    @IBOutlet weak var contentRatingLabel: UILabel!
    @IBOutlet weak var userRatingCntLabel: UILabel!
    @IBOutlet weak var genresLabel: UILabel!
    @IBOutlet weak var contentRatingGuideLabel: UILabel!
    @IBOutlet weak var userRatingLargeLabel: UILabel!
    
    @IBOutlet weak var openButton: UIButton!
    @IBOutlet weak var moreButton: UIButton!
    @IBOutlet weak var versionHistoryButton: UIButton!
    @IBOutlet weak var moreFeatureTxtButton: UIButton!
    @IBOutlet weak var moreDescTxtButton: UIButton!
    @IBOutlet weak var sellerButton: UIButton!
    @IBOutlet weak var star1Button: UIButton!
    @IBOutlet weak var star2Button: UIButton!
    @IBOutlet weak var star3Button: UIButton!
    @IBOutlet weak var star4Button: UIButton!
    @IBOutlet weak var star5Button: UIButton!
    @IBOutlet weak var reviewButton: UIButton!
    
    @IBOutlet weak var featureTextView: UITextView!
    @IBOutlet weak var descTextView: UITextView!
    
    @IBOutlet weak var featureTxtViewHeightConstaint: NSLayoutConstraint!
    
    weak var listener: SearchDetailPresentableListener?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        listener?.configureView(view: self)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    // MARK: - Actions
    @IBAction func openButtonTapped(_ sender: UIButton) {
        print("openButtonTapped")
    }
    
    @IBAction func moreButtonTapped(_ sender: UIButton) {
    }
    
    @IBAction func versionHistoryButtonTapped(_ sender: UIButton) {
    }
    
    @IBAction func moreTxtViewButtonTapped(_ sender: UIButton) {
    }
    
    @IBAction func moreDescTxtButtonTapped(_ sender: UIButton) {
    }
    
    @IBAction func sellerButtonTapped(_ sender: UIButton) {
    }
    
    @IBAction func allCommentButtonTapped(_ sender: UIButton) {
    }
    
    @IBAction func star1ButtonTapped(_ sender: UIButton) {
    }
    
    @IBAction func star2ButtonTapped(_ sender: UIButton) {
    }
    
    @IBAction func star3ButtonTapped(_ sender: UIButton) {
    }
    
    @IBAction func star4ButtonTapped(_ sender: UIButton) {
    }
    
    @IBAction func star5ButtonTapped(_ sender: UIButton) {
    }
    
    @IBAction func reviewButtonTapped(_ sender: UIButton) {
    }
    
    @IBAction func appSupportButtonTapped(_ sender: UIButton) {
    }
}

extension SearchDetailViewController {
    // MARK: - Private
    private func setupLayout() {
        navigationController?.navigationBar.prefersLargeTitles = false
        
        iconImgView.layer.cornerRadius = 20
        
        openButton.layer.cornerRadius = 30 / 2
        
        let config = UIImage.SymbolConfiguration(pointSize: UIFont.systemFontSize, weight: .bold, scale: .large)
        moreButton.setImage(UIImage(systemName: "ellipsis", withConfiguration: config)?.withTintColor(.white, renderingMode: .alwaysOriginal), for: .normal)
        moreButton.layer.cornerRadius = 30 / 2
        
        moreFeatureTxtButton.addShadowView(offset: CGSize(width: -10, height: 0), opacity: 1, radius: 10, color: UIColor.white.cgColor, maskToBounds: false)
        moreDescTxtButton.addShadowView(offset: CGSize(width: -10, height: 0), opacity: 1, radius: 10, color: UIColor.white.cgColor, maskToBounds: false)
        
        reviewButton.titleLabel?.lineBreakMode = .byClipping
    }
}

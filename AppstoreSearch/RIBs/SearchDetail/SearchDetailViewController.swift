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
    
    func numberOfScreenShots() -> Int
    
    func screenShotUrlAt(indexPath: IndexPath) -> String?
    
    func configurePrevCollectionCell(indexPath: IndexPath, cell: PrevCollectionViewCell)
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
    @IBOutlet weak var versionLabel: UILabel!
    @IBOutlet weak var versionDateLabel: UILabel!
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
    @IBOutlet weak var descTxtViewHeightConstaint: NSLayoutConstraint!
    
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
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "취소", style: .cancel, handler: { (action) in
            return
        }))
        
        let shareAction = UIAlertAction(title: "앱 공유하기...", style: .default, handler: { (action) in
            return
        })
        shareAction.setValue(UIImage(systemName: "square.and.arrow.up"), forKey: "image")
        actionSheet.addAction(shareAction)
        
        let otherAppsAction = UIAlertAction(title: "이 개발자의 다른 앱 보기", style: .default, handler: { (action) in
            return
        })
        otherAppsAction.setValue(UIImage(systemName: "person.crop.circle"), forKey: "image")
        actionSheet.addAction(otherAppsAction)
        
        present(actionSheet, animated: true, completion: nil)
    }
    
    @IBAction func versionHistoryButtonTapped(_ sender: UIButton) {
    }
    
    @IBAction func moreFeatureTxtButtonTapped(_ sender: UIButton) {
        featureTextView.text = featureTextView.text.replacingOccurrences(of: "\n\0", with: "\n\n")
        
        let size = CGSize(width: (view.frame.width - 40), height: .infinity)
        let estimatedSize = featureTextView.sizeThatFits(size)
        UIView.animate(withDuration: 0.5) {
            self.featureTxtViewHeightConstaint.constant = estimatedSize.height
        }
        moreFeatureTxtButton.isHidden = true
    }
    
    @IBAction func moreDescTxtButtonTapped(_ sender: UIButton) {
        descTextView.text = descTextView.text.replacingOccurrences(of: "\n\0", with: "\n\n")
        
        let size = CGSize(width: (view.frame.width - 40), height: .infinity)
        let estimatedSize = descTextView.sizeThatFits(size)
        UIView.animate(withDuration: 0.5) {
            self.descTxtViewHeightConstaint.constant = estimatedSize.height
        }
        moreDescTxtButton.isHidden = true
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

extension SearchDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    // MARK: - UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listener?.numberOfScreenShots() ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: prevCollectionCellId, for: indexPath) as? PrevCollectionViewCell else {
            fatalError()
        }
        listener?.configurePrevCollectionCell(indexPath: indexPath, cell: cell)
        return cell
    }
    
    // MARK: - UICollectionViewDelegate
    
    // MARK: - UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 210, height: 455)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
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
        
        prevCollectionView.register(UINib(nibName: prevCollectionCellId, bundle: nil), forCellWithReuseIdentifier: prevCollectionCellId)
        
        prevCollectionView.dataSource = self
        prevCollectionView.delegate = self
    }
}

//
//  SearchDetailInteractor.swift
//  AppstoreSearch
//
//  Created by Eido Goya on 2020/08/27.
//  Copyright © 2020 Dymm. All rights reserved.
//

import RIBs
import RxSwift

protocol SearchDetailRouting: ViewableRouting {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

protocol SearchDetailPresentable: Presentable {
    var listener: SearchDetailPresentableListener? { get set }
    // TODO: Declare methods the interactor can invoke the presenter to present data.
}

protocol SearchDetailListener: class {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
}

final class SearchDetailInteractor: PresentableInteractor<SearchDetailPresentable>, SearchDetailInteractable, SearchDetailPresentableListener {
    
    weak var router: SearchDetailRouting?
    weak var listener: SearchDetailListener?
    
    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    init(presenter: SearchDetailPresentable,
         itunseModel: ItunseModel) {
        self.itunseModel = itunseModel
        super.init(presenter: presenter)
        presenter.listener = self
    }
    
    override func didBecomeActive() {
        super.didBecomeActive()
        // TODO: Implement business logic here.
    }
    
    override func willResignActive() {
        super.willResignActive()
        // TODO: Pause any business logic.
    }
    
    // MARK: - Private
    private var itunseModel: ItunseModel
    
    // MARK: - SearchDetailPresentableListener
    func configureView(view: SearchDetailViewController) {
        view.iconImgView.image = {
            let url = URL(string: itunseModel.artworkUrl512!)
            if url != nil {
                let data = try? Data(contentsOf: url!)
                return UIImage(data: data!)!
            } else {
                return nil
            }
        }()
        
        view.titleLabel.text = itunseModel.trackName
        view.sellerLabel.text = itunseModel.sellerName
        view.userRatingLabel.text = String(format: "%.1f", itunseModel.averageUserRating!)
        view.contentRatingLabel.text = itunseModel.contentAdvisoryRating
        view.contentRatingGuideLabel.text = "연령"
        view.rankLabel.text = "#0"
        view.genresLabel.text = itunseModel.genres?.joined()
        
        let userRate: Int = {
            return Int(round(itunseModel.averageUserRating ?? 0))
        }()
        let config = UIImage.SymbolConfiguration(pointSize: UIFont.systemFontSize, weight: .regular, scale: .medium)
        view.star1ImgView.image = UIImage(systemName: userRate < 1 ? "star" : "star.fill", withConfiguration: config)?.withTintColor(.systemGray, renderingMode: .alwaysOriginal)
        view.star2ImgView.image = UIImage(systemName: userRate < 2 ? "star" : "star.fill", withConfiguration: config)?.withTintColor(.systemGray, renderingMode: .alwaysOriginal)
        view.star3ImgView.image = UIImage(systemName: userRate < 3 ? "star" : "star.fill", withConfiguration: config)?.withTintColor(.systemGray, renderingMode: .alwaysOriginal)
        view.star4ImgView.image = UIImage(systemName: userRate < 4 ? "star" : "star.fill", withConfiguration: config)?.withTintColor(.systemGray, renderingMode: .alwaysOriginal)
        view.star5ImgView.image = UIImage(systemName: userRate < 5 ? "star" : "star.fill", withConfiguration: config)?.withTintColor(.systemGray, renderingMode: .alwaysOriginal)
    }
}

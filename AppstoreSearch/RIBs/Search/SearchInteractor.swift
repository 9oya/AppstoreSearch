//
//  SearchInteractor.swift
//  AppstoreSearch
//
//  Created by Eido Goya on 2020/08/27.
//  Copyright © 2020 Dymm. All rights reserved.
//

import RIBs
import RxSwift

protocol SearchRouting: ViewableRouting {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

protocol SearchPresentable: Presentable {
    var listener: SearchPresentableListener? { get set }
    
    func reloadTableView()
    
    func beginUpdateTableView()
    
    func endUpdateTableView()
}

protocol SearchListener: class {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
}

final class SearchInteractor: PresentableInteractor<SearchPresentable>, SearchInteractable, SearchPresentableListener {

    weak var router: SearchRouting?
    weak var listener: SearchListener?

    override init(presenter: SearchPresentable) {
        super.init(presenter: presenter)
        presenter.listener = self
    }

    // MARK: - Life cycle
    override func didBecomeActive() {
        super.didBecomeActive()
        // TODO: Implement business logic here.
    }

    override func willResignActive() {
        super.willResignActive()
        // TODO: Pause any business logic.
    }
    
    // MARK: - Private
    private var ituneseWrapperModel: ItunseWrapperModel?
    private var recentKeywords: [Keyword]?
    private var autoComplKeywords: [Keyword]?
    private var currTableCellType: SearchTableCellType = .recentKey
    
    private func recentKeywordAt(indexPath: IndexPath) -> Keyword? {
        if let _recentKeywords = recentKeywords {
            return _recentKeywords[indexPath.row]
        } else {
            return nil
        }
    }
    
    private func autoComplKeywordAt(indexPath: IndexPath) -> Keyword? {
        if let _autoComplKeywords = autoComplKeywords {
            return _autoComplKeywords[indexPath.row]
        } else {
            return nil
        }
    }
    
    private func itunseModelAt(indexPath: IndexPath) -> ItunseModel? {
        if let wrapperModel = ituneseWrapperModel, let itunseModels = wrapperModel.results {
            return itunseModels[indexPath.row]
        } else {
            return nil
        }
    }
    
    // MARK: - SearchPresentableListener
    func getCurrTableCellType() -> SearchTableCellType {
        return currTableCellType
    }
    
    func getRecentKeywords() {
        currTableCellType = .recentKey
        recentKeywords = KeywordService.shared.getRecentKeywors()
        DispatchQueue.main.async {
            self.presenter.reloadTableView()
        }
    }
    
    func getAutoComplKeywords(title: String) {
        currTableCellType = .autoCompl
        autoComplKeywords = KeywordService.shared.getKeywordsByContainTitle(title: title)
        DispatchQueue.main.async {
            self.presenter.reloadTableView()
        }
    }
    
    func searchAppsWithTerm(title: String?) {
        currTableCellType = .searchResult
        SearchService.shared.getAppsByTitle(title: title!) { (result) in
            
            _ = KeywordService.shared.createKeyword(title: title!, timeStamp: Date())
            
            self.ituneseWrapperModel = result
            DispatchQueue.main.async {
                self.presenter.reloadTableView()
            }
        }
    }
    
    func numberOfSections() -> Int {
        return 1
    }
    
    func numberOfRecentKeywords() -> Int {
        if let _recentKeywords = recentKeywords {
            return _recentKeywords.count
        } else {
            return 0
        }
    }
    
    func numberOfAutoComplKeywords() -> Int {
        if let _autoComplKeywords = autoComplKeywords {
            return _autoComplKeywords.count
        } else {
            return 0
        }
    }
    
    func numberOfSearchResult() -> Int {
        if let wrapperModel = ituneseWrapperModel {
            return wrapperModel.resultCount
        } else {
            return 0
        }
    }
    
    func configureRecentKeyTableCell(cell: RecentKeyTableViewCell, indexPath: IndexPath) {
        let keyword = recentKeywordAt(indexPath: indexPath)
        cell.titleLabel.text = keyword?.title
    }
    
    func configureAutoComplTableCell(cell: AutoComplTableViewCell, indexPath: IndexPath) {
        let keyword = autoComplKeywordAt(indexPath: indexPath)
        let config = UIImage.SymbolConfiguration(pointSize: UIFont.systemFontSize, weight: .regular, scale: .small)
        cell.imgView.image = UIImage(systemName: "magnifyingglass", withConfiguration: config)?.withTintColor(.systemGray, renderingMode: .alwaysOriginal)
        cell.titleLabel.text = keyword?.title
    }
    
    func configureSearchTableCell(cell: SearchResultTableViewCell, indexPath: IndexPath) {
        if let itunseModel = itunseModelAt(indexPath: indexPath) {
            let image: UIImage? = {
                let url = URL(string: itunseModel.artworkUrl60!)
                if url != nil {
                    let data = try? Data(contentsOf: url!)
                    return UIImage(data: data!)!
                } else {
                    return nil
                }
            }()
            
            let userRate: Int = {
                return Int(round(itunseModel.averageUserRating ?? 0))
            }()
            
            cell.iconImgView.image = image
            
            cell.titleLabel.text = itunseModel.trackName
            cell.subTitleLabel.text = itunseModel.description
            
            let config = UIImage.SymbolConfiguration(pointSize: UIFont.systemFontSize, weight: .regular, scale: .medium)
            cell.star1ImgView.image = UIImage(systemName: userRate < 1 ? "star" : "star.fill", withConfiguration: config)?.withTintColor(.systemGray, renderingMode: .alwaysOriginal)
            cell.star2ImgView.image = UIImage(systemName: userRate < 2 ? "star" : "star.fill", withConfiguration: config)?.withTintColor(.systemGray, renderingMode: .alwaysOriginal)
            cell.star3ImgView.image = UIImage(systemName: userRate < 3 ? "star" : "star.fill", withConfiguration: config)?.withTintColor(.systemGray, renderingMode: .alwaysOriginal)
            cell.star4ImgView.image = UIImage(systemName: userRate < 4 ? "star" : "star.fill", withConfiguration: config)?.withTintColor(.systemGray, renderingMode: .alwaysOriginal)
            cell.star5ImgView.image = UIImage(systemName: userRate < 5 ? "star" : "star.fill", withConfiguration: config)?.withTintColor(.systemGray, renderingMode: .alwaysOriginal)
            
            cell.downCntLabel.text = "\(itunseModel.userRatingCount)"
            
            let screenShot1Img: UIImage? = {
                let url = URL(string: itunseModel.screenshotUrls![0])
                if url != nil {
                    let data = try? Data(contentsOf: url!)
                    return UIImage(data: data!)!
                } else {
                    return nil
                }
            }()
            let screenShot2Img: UIImage? = {
                let url = URL(string: itunseModel.screenshotUrls![1])
                if url != nil {
                    let data = try? Data(contentsOf: url!)
                    return UIImage(data: data!)!
                } else {
                    return nil
                }
            }()
            let screenShot3Img: UIImage? = {
                let url = URL(string: itunseModel.screenshotUrls![2])
                if url != nil {
                    let data = try? Data(contentsOf: url!)
                    return UIImage(data: data!)!
                } else {
                    return nil
                }
            }()
            
            cell.screen1ImgView.image = screenShot1Img
            cell.screen2ImgView.image = screenShot2Img
            cell.screen3ImgView.image = screenShot3Img
        }
    }
}

enum SearchTableCellType {
    case recentKey, autoCompl, searchResult
}

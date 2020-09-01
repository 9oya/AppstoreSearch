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
    func openUrl(url: URL, from view: UIViewController)
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
    
    init(presenter: SearchDetailPresentable,
         itunseModel: ItunseModel) {
        self.itunseModel = itunseModel
        self.infoDictArr = [
            ["guide": "제공자", "content": itunseModel.sellerName],
            ["guide": "크기", "content": ByteCountFormatter.string(fromByteCount: Int64(itunseModel.fileSizeBytes)!, countStyle: .file)],
            ["guide": "카테고리", "content": itunseModel.genres!.joined(separator: ", ")],
            ["guide": "호환성", "content": "iPhone"],
            ["guide": "언어", "content": itunseModel.languageCodesISO2A.joined(separator: ", ")],
            ["guide": "연령", "content": itunseModel.contentAdvisoryRating],
            ["guide": "저작권", "content": "\u{000A9} \(itunseModel.sellerName)"],
            ["guide": "개발자 웹 사이트", "content": itunseModel.sellerUrl ?? ""]
        ]
        
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
    private var infoDictArr: [[String: String]]
    
    // MARK: - SearchDetailPresentableListener
    func configureView(view: SearchDetailViewController) {
        view.iconImgView.image = {
            let url = URL(string: itunseModel.artworkUrl512!)
            if url != nil {
                if let data = try? Data(contentsOf: url!) {
                    return UIImage(data: data)!
                } else {
                    return nil
                }
            } else {
                return nil
            }
        }()
        
        view.titleLabel.text = itunseModel.trackName
        view.sellerLabel.text = itunseModel.sellerName
        view.sellerBtnLabel.text = itunseModel.sellerName
        view.sellerBtnGuideLabel.text = "개발자"
        view.userRatingLabel.text = String(format: "%.1f", itunseModel.averageUserRating!)
        view.userRatingLargeLabel.text = String(format: "%.1f", itunseModel.averageUserRating!)
        view.userRatingCntLabel.text = "\(itunseModel.userRatingCount.formatUsingAbbrevation())개의 평가"
        view.contentRatingLabel.text = itunseModel.contentAdvisoryRating
        view.contentRatingGuideLabel.text = "연령"
        view.rankLabel.text = "0"
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
        
        view.versionLabel.text = "버전 \(itunseModel.version)"
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let releaseDate = dateFormatter.date(from: itunseModel.currentVersionReleaseDate)
        let components = Calendar.current.dateComponents([.year, .month, .weekOfYear, .day, .hour], from: releaseDate!, to: Date())
        view.versionDateLabel.text = components.year! > 0 ? "\(components.year!)년 전" : (components.month! > 0 ? "\(components.month!)개월 전" : (components.weekOfYear! > 0 ? "\(components.weekOfYear!)주 전" : (components.day! > 0 ? "\(components.day!)일 전" : "\(components.hour!)시간 전")))
        
        let releaseNotes = itunseModel.releaseNotes?.replacingOccurrences(of: "\n\n", with: "\n\0")
        view.featureTextView.text = releaseNotes
        
        let description = itunseModel.releaseNotes?.replacingOccurrences(of: "\n\n", with: "\n\0")
        view.descTextView.text = description
    }
    
    func numberOfScreenShots() -> Int {
        if let screenShotUrls = itunseModel.screenshotUrls {
            return screenShotUrls.count
        } else {
            return 0
        }
    }
    
    func screenShotUrlAt(indexPath: IndexPath) -> String? {
        if let screenShotUrls = itunseModel.screenshotUrls {
            return screenShotUrls[indexPath.row]
        } else {
            return nil
        }
    }
    
    func configurePrevCollectionCell(indexPath: IndexPath, cell: PrevCollectionViewCell) {
        if let urlString = screenShotUrlAt(indexPath: indexPath) {
            let url = URL(string: urlString)
            if url != nil {
                if let data = try? Data(contentsOf: url!) {
                    cell.screenShotImgView.image = UIImage(data: data) ?? nil
                } else {
                    cell.screenShotImgView.image = nil
                }
            } else {
                cell.screenShotImgView.image = nil
            }
        }
    }
    
    func numberOfInfos() -> Int {
        let numberOfInfos = 7
        if itunseModel.sellerUrl != nil  {
            return numberOfInfos + 1
        } else {
            return numberOfInfos
        }
    }
    
    func infoDictAt(indexPath: IndexPath) -> [String: String] {
        return infoDictArr[indexPath.row]
    }
    
    func configureInfoTableCell(indexPath: IndexPath, cell: InfoTableViewCell) {
        let infoDict = infoDictAt(indexPath: indexPath)
        cell.guideLabel.text = infoDict["guide"]
        cell.contentLabel.text = infoDict["content"]
        
        if indexPath.row == numberOfInfos() - 1 {
            cell.underLineView.isHidden = true
            if itunseModel.sellerUrl != nil {
                cell.guideLabel.textColor = .systemBlue
                cell.contentLabel.isHidden = true
                cell.iconImgView.isHidden = false
            }
        } else {
            cell.underLineView.isHidden = false
            cell.guideLabel.textColor = .systemGray
            cell.contentLabel.isHidden = false
            cell.iconImgView.isHidden = true
        }
    }
    
    func openUrl(url: String, from view: UIViewController) {
        if let url = URL(string: url) {
            router?.openUrl(url: url, from: view)
        }
    }
}

//
//  ItunseModels.swift
//  AppstoreSearch
//
//  Created by Eido Goya on 2020/08/29.
//  Copyright © 2020 Dymm. All rights reserved.
//

import Foundation

struct ItunseWrapperModel: Codable {
    let resultCount: Int
    let results: [ItunseModel]?
    
    enum CodingKeys: String, CodingKey {
        case resultCount
        case results
    }
    
    init(from decoder: Decoder) throws {
        let valueContainer = try decoder.container(keyedBy: CodingKeys.self)
        self.resultCount = try valueContainer.decode(Int.self, forKey: CodingKeys.resultCount)
        self.results = try? valueContainer.decode([ItunseModel].self, forKey: CodingKeys.results)
    }
}

struct ItunseModel: Codable {
    let features: [String]?
    let supportedDevices: [String]?
    let advisories: [String]?
    let isGameCenterEnabled: Bool
    let ipadScreenshotUrls: [String]?
    let appletvScreenshotUrls: [String]?
    let artworkUrl60: String?
    let artworkUrl512: String?
    let artworkUrl100: String?
    let artistViewUrl: String?
    let screenshotUrls: [String]?
    let kind: String?
    let minimumOsVersion: String?
    let formattedPrice: String?
    let primaryGenreName: String?
    let trackId: Int
    let trackName: String
    let genreIds: [String]?
    let sellerName: String
    let currentVersionReleaseDate: String
    let releaseNotes: String?
    let releaseDate: String?
    let isVppDeviceBasedLicensingEnabled: Bool
    let trackCensoredName: String?
    let languageCodesISO2A: [String]
    let fileSizeBytes: String
    let contentAdvisoryRating: String
    let averageUserRatingForCurrentVersion: Float
    let userRatingCountForCurrentVersion: Int
    let averageUserRating: Float?
    let trackViewUrl: String?
    let trackContentRating: String
    let artistId: Int
    let artistName: String
    let genres: [String]?
    let price: Int
    let primaryGenreId: Int
    let bundleId: String
    let description: String
    let currency: String
    let version: String
    let wrapperType: String
    let userRatingCount: Int
    
    enum CodingKeys: String, CodingKey {
        case features
        case supportedDevices
        case advisories
        case isGameCenterEnabled
        case ipadScreenshotUrls
        case appletvScreenshotUrls
        case artworkUrl60
        case artworkUrl512
        case artworkUrl100
        case artistViewUrl
        case screenshotUrls
        case kind
        case minimumOsVersion
        case formattedPrice
        case primaryGenreName
        case trackId
        case trackName
        case genreIds
        case sellerName
        case currentVersionReleaseDate
        case releaseNotes
        case releaseDate
        case isVppDeviceBasedLicensingEnabled
        case trackCensoredName
        case languageCodesISO2A
        case fileSizeBytes
        case contentAdvisoryRating
        case averageUserRatingForCurrentVersion
        case userRatingCountForCurrentVersion
        case averageUserRating
        case trackViewUrl
        case trackContentRating
        case artistId
        case artistName
        case genres
        case price
        case primaryGenreId
        case bundleId
        case description
        case currency
        case version
        case wrapperType
        case userRatingCount
    }
    
    init(from decoder: Decoder) throws {
        let valueContainer = try decoder.container(keyedBy: CodingKeys.self)
        self.features = try? valueContainer.decode([String].self, forKey: CodingKeys.features)
        self.supportedDevices = try? valueContainer.decode([String].self, forKey: CodingKeys.supportedDevices)
        self.advisories = try? valueContainer.decode([String].self, forKey: CodingKeys.advisories)
        self.isGameCenterEnabled = try valueContainer.decode(Bool.self, forKey: CodingKeys.isGameCenterEnabled)
        self.ipadScreenshotUrls = try? valueContainer.decode([String].self, forKey: CodingKeys.ipadScreenshotUrls)
        self.appletvScreenshotUrls = try? valueContainer.decode([String].self, forKey: CodingKeys.appletvScreenshotUrls)
        self.artworkUrl60 = try? valueContainer.decode(String.self, forKey: CodingKeys.artworkUrl60)
        self.artworkUrl512 = try? valueContainer.decode(String.self, forKey: CodingKeys.artworkUrl512)
        self.artworkUrl100 = try? valueContainer.decode(String.self, forKey: CodingKeys.artworkUrl100)
        self.artistViewUrl = try? valueContainer.decode(String.self, forKey: CodingKeys.artistViewUrl)
        self.screenshotUrls = try? valueContainer.decode([String].self, forKey: CodingKeys.screenshotUrls)
        self.kind = try? valueContainer.decode(String.self, forKey: CodingKeys.kind)
        self.minimumOsVersion = try? valueContainer.decode(String.self, forKey: CodingKeys.minimumOsVersion)
        self.formattedPrice = try? valueContainer.decode(String.self, forKey: CodingKeys.formattedPrice)
        self.primaryGenreName = try? valueContainer.decode(String.self, forKey: CodingKeys.primaryGenreName)
        self.trackId = try valueContainer.decode(Int.self, forKey: CodingKeys.trackId)
        self.trackName = try valueContainer.decode(String.self, forKey: CodingKeys.trackName)
        self.genreIds = try? valueContainer.decode([String].self, forKey: CodingKeys.genreIds)
        self.sellerName = try valueContainer.decode(String.self, forKey: CodingKeys.sellerName)
        self.currentVersionReleaseDate = try valueContainer.decode(String.self, forKey: CodingKeys.currentVersionReleaseDate)
        self.releaseNotes = try? valueContainer.decode(String.self, forKey: CodingKeys.releaseNotes)
        self.releaseDate = try? valueContainer.decode(String.self, forKey: CodingKeys.releaseDate)
        self.isVppDeviceBasedLicensingEnabled = try valueContainer.decode(Bool.self, forKey: CodingKeys.isVppDeviceBasedLicensingEnabled)
        self.trackCensoredName = try? valueContainer.decode(String.self, forKey: CodingKeys.trackCensoredName)
        self.languageCodesISO2A = try valueContainer.decode([String].self, forKey: CodingKeys.languageCodesISO2A)
        self.fileSizeBytes = try valueContainer.decode(String.self, forKey: CodingKeys.fileSizeBytes)
        self.contentAdvisoryRating = try valueContainer.decode(String.self, forKey: CodingKeys.contentAdvisoryRating)
        self.averageUserRatingForCurrentVersion = try valueContainer.decode(Float.self, forKey: CodingKeys.averageUserRatingForCurrentVersion)
        self.userRatingCountForCurrentVersion = try valueContainer.decode(Int.self, forKey: CodingKeys.userRatingCountForCurrentVersion)
        self.averageUserRating = try? valueContainer.decode(Float.self, forKey: CodingKeys.averageUserRating)
        self.trackViewUrl = try? valueContainer.decode(String.self, forKey: CodingKeys.trackViewUrl)
        self.trackContentRating = try valueContainer.decode(String.self, forKey: CodingKeys.trackContentRating)
        self.artistId = try valueContainer.decode(Int.self, forKey: CodingKeys.artistId)
        self.artistName = try valueContainer.decode(String.self, forKey: CodingKeys.artistName)
        self.genres = try? valueContainer.decode([String].self, forKey: CodingKeys.genres)
        self.price = try valueContainer.decode(Int.self, forKey: CodingKeys.price)
        self.primaryGenreId = try valueContainer.decode(Int.self, forKey: CodingKeys.primaryGenreId)
        self.bundleId = try valueContainer.decode(String.self, forKey: CodingKeys.bundleId)
        self.description = try valueContainer.decode(String.self, forKey: CodingKeys.description)
        self.currency = try valueContainer.decode(String.self, forKey: CodingKeys.currency)
        self.version = try valueContainer.decode(String.self, forKey: CodingKeys.version)
        self.wrapperType = try valueContainer.decode(String.self, forKey: CodingKeys.wrapperType)
        self.userRatingCount = try valueContainer.decode(Int.self, forKey: CodingKeys.userRatingCount)
    }
}

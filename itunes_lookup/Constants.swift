//
//  Constants.swift
//  itunes_lookup
//
//  Created by Michael Nienaber on 8/17/16.
//  Copyright © 2016 Michael Nienaber. All rights reserved.
//

import Foundation
import UIKit

extension Client {

    struct Constants {

        struct Scheme {

            static let SearchMethod = "https://itunes.apple.com/search?term="
            static let LookUpMethod = "https://itunes.apple.com/lookup?id="
            static let limitAndApp = "&limit=25&entity=software"
        }

        struct SearchResults {

            static let ArtistName = "artistName"
            static let BundleId = "bundleId"
            static let TrackId = "trackId"
            static let ReleaseDate = "releaseDate"
            static let country = "country"
            static let currency = "currency"
            static let languageCodesISO2A = "languageCodesISO2A"
            static let FormattedPrice = "formattedPrice"
            static let CurrentVersionReleaseDate = "currentVersionReleaseDate"
            static let ArtworkUrl60 = "artworkUrl60"
//            static let AverageUserRating = "averageUserRating"
//            static let UserRatingCount = "userRatingCount"
            static let Version = "version"
        }
    }
}
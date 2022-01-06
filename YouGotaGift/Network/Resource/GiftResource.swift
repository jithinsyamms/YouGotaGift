//
//  GiftResource.swift
//  YouGotaGift
//
//  Created by Jithin on 06/01/22.
//

import Foundation

struct GiftResource: APIResource {

    typealias Model = Gift

    var scheme: String {
        "https"
    }
    var baseURL: String {
        Constants.BaseURL
    }
    var path: String {
        "/uae/api/v3/brands/featured/"
    }
    var method: String {
        "GET"
    }

    var parameters: [URLQueryItem] {
        var params: [URLQueryItem] = []
        params.append(URLQueryItem(name: "api_key", value: "2vq1M9ye4eV6H1Mr"))
        params.append(URLQueryItem(name: "api_secret", value: "wnRY14QoA99B4Ae6wn2CU2y8"))
        return params
    }

}

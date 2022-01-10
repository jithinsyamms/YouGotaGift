//
//  GiftResource.swift
//  YouGotaGift
//
//  Created by Jithin on 06/01/22.
//

import Foundation

struct GiftResource: APIResource {

    typealias Model = GiftData

    var categoryId: Int
    var page: Int
    var url: String

    init(category: Int, page: Int, url: String) {
        self.categoryId = category
        self.page = page
        self.url = url
    }

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
        if categoryId > -1 {
            params.append(URLQueryItem(name: "category", value: String(categoryId)))
            params.append(URLQueryItem(name: "page", value: String(page)))
        }
        return params
    }

    var headers: [URLQueryItem] {
        var params: [URLQueryItem] = []
        params.append(URLQueryItem(name: "app-version", value: "4.3.1"))
        params.append(URLQueryItem(name: "app-platform", value: "ios"))
        return params
    }

    var URL: URL? {
        if !url.isEmpty {
            if let components = URLComponents(string: url) {
                return components.url
            }
        } else {
            var components = URLComponents()
            components.scheme = scheme
            components.host = baseURL
            components.path = path
            components.queryItems = parameters
            return components.url
        }
        return nil
    }

}

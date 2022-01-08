//
//  GiftData.swift
//  YouGotaGift
//
//  Created by Jithin on 08/01/22.
//

import Foundation


struct GiftData: Codable {
    let label: String?
    let paginatedData: PaginatedData?
    let brands: [GiftBrand]?
    let categories: [GiftCategory]?
    let selectedCategory: SelectedCategory?
    let tagsCount: Int?

    enum CodingKeys: String, CodingKey {
        case label
        case paginatedData = "paginated_data"
        case brands, categories
        case selectedCategory = "selected_category"
        case tagsCount = "tags_count"
    }
}

struct GiftBrand: Codable {
    let id: Int
    let name: String?
    let logo: String?
    let productImage: String?
    let shortTagline:String?
    let brandCode: String?
    let isGeneric: Bool?
    let seoName: String?
    let currency: Currency?
    let detailURL: String?
    let redemptionTag: String?
    let detailURLV5: String?

    enum CodingKeys: String, CodingKey {
        case id, name, logo
        case productImage = "product_image"
        case shortTagline = "short_tagline"
        case brandCode = "brand_code"
        case isGeneric = "is_generic"
        case seoName = "seo_name"
        case currency
        case detailURL = "detail_url"
        case redemptionTag = "redemption_tag"
        case detailURLV5 = "detail_url_v5"
    }
}

enum Currency: String, Codable {
    case aed = "AED"
}


struct GiftCategory: Codable {
    let id: Int
    let name:String?
    let seoName: String?
    let imageLarge:String?
    let imageSmall: String?
    let title: String?
    let caption: String?
    let defaultDisplay: Bool?
    let bgColorCode: String?
    let tagType: String?
    let iconImage: String?

    enum CodingKeys: String, CodingKey {
        case id, name
        case seoName = "seo_name"
        case imageLarge = "image_large"
        case imageSmall = "image_small"
        case title, caption
        case defaultDisplay = "default_display"
        case bgColorCode = "bg_color_code"
        case tagType = "tag_type"
        case iconImage = "icon_image"
    }
}


struct PaginatedData: Codable {
    let count: Int?
    let previous: String?
    let next: String?
}


struct SelectedCategory: Codable {
    let id: Int
    let bgColorCode: String?
    let imageSmall: String?
    let name: String?

    enum CodingKeys: String, CodingKey {
        case id
        case bgColorCode = "bg_color_code"
        case imageSmall = "image_small"
        case name
    }
}

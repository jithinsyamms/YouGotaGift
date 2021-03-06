//
//  GiftDataModel.swift
//  YouGotaGift
//
//  Created by Jithin on 08/01/22.
//

import Foundation
import Network

protocol GiftDataDelegate: AnyObject {
    func loadingStarted(showIndicator: Bool)
    func errorLoadingData()
    func dataChanged()
    func networkStatusChanged()
}

class GiftDataModel {

    var giftData: GiftData?
    weak var delegate: GiftDataDelegate?
    var isLoading: Bool = false
    var loadedDataOnce = false

    var giftCategories: [GiftCategory] = []
    var brandDict: [Int: [GiftBrand]] = [:]
    var paginatedData: [Int: PaginatedData] = [:]
    var selectedCategoryId: Int  = -1
    var isNetworkAvailable = false

    let monitor = NWPathMonitor()
    init() {
        monitor.pathUpdateHandler = { path in
            if path.status == .satisfied {
                self.isNetworkAvailable = true
                if !self.loadedDataOnce {
                    DispatchQueue.main.async {
                        self.fetchGifts()
                    }
                } else {
                    DispatchQueue.main.async {
                        self.delegate?.networkStatusChanged()
                    }
                }

            } else {
                self.isNetworkAvailable = false
                DispatchQueue.main.async {
                    self.delegate?.networkStatusChanged()
                }
            }
        }
        monitor.start(queue: .global())
    }

    func loadTestData() {
        let bundle = Bundle(for: type(of: self))
        guard let json = bundle.url(forResource: "gifts", withExtension: "json") else {
            return
        }
        do {
            let jsonData = try Data(contentsOf: json)
            let giftData = try JSONDecoder().decode(GiftData.self, from: jsonData)
            self.loadedDataOnce = true
            self.giftData = giftData
            self.setUpData()
            DispatchQueue.main.async {
                self.delegate?.dataChanged()
            }

        } catch _ {
            DispatchQueue.main.async {
                self.delegate?.errorLoadingData()
            }
        }

    }

    func fetchGifts(categoryId: Int = -1, page: Int = 1, url: String = "") {

        if AppDelegate.isRunningUITest {
          loadTestData()
          return
        }
        guard !isLoading else {
            return
        }
        isLoading = true
        let giftResoucrce = GiftResource(category: categoryId, page: page, url: url)
        let giftRequest = GiftRequest(resource: giftResoucrce)
        self.delegate?.loadingStarted(showIndicator: url.isEmpty ? true : false)

        giftRequest.execute { result in
            self.isLoading = false
            switch result {
            case .success(let giftData):
                self.loadedDataOnce = true
                self.giftData = giftData
                self.setUpData()
                DispatchQueue.main.async {
                    self.delegate?.dataChanged()
                }
            case .failure:
                DispatchQueue.main.async {
                    self.delegate?.errorLoadingData()
                }
            }
        }
    }

    func setUpData() {
        guard let giftData = giftData else {
            return
        }
        if let selectedCategory = giftData.selectedCategory {
            selectedCategoryId = selectedCategory.id
        }
        if let categories = giftData.categories {
            giftCategories = categories
        }
        if let brands = giftData.brands {
            addBrandsToCategories(brands: brands, categoryID: selectedCategoryId)
        }
        if let pageData = giftData.paginatedData {
            paginatedData[selectedCategoryId] = pageData
        }
    }

    func addBrandsToCategories(brands: [GiftBrand], categoryID: Int) {
        if var brandArray = brandDict[categoryID] {
            brandArray.append(contentsOf: brands)
            brandDict[categoryID] = brandArray
        } else {
            brandDict[categoryID] = brands
        }
    }

    func getCategotyCount() -> Int {
        giftCategories.count
    }

    func getGiftBrandsCount() -> Int {
        if let giftBrands = brandDict[selectedCategoryId] {
            return giftBrands.count
        }
        return 0
    }

    func getCategories() -> [GiftCategory] {
        return giftCategories
    }

    func getGiftBrands() -> [GiftBrand] {
        if let giftBrands = brandDict[selectedCategoryId] {
            return giftBrands
        }
        return []
    }

    func getSelectedCategory() -> GiftCategory? {
        return giftCategories.first { category in
            category.id == selectedCategoryId
        }
    }
    func hasNextUrl() -> Bool {
        if let pageData = paginatedData[selectedCategoryId], let nextUrl = pageData.next, nextUrl.count > 0 {
          return true
        }
        return false
    }

    func fetchMore() {
        guard isNetworkAvailable else {
            return
        }
        if let data = paginatedData[selectedCategoryId],
           let nextUrl = data.next, nextUrl.count > 0 {
            fetchGifts(categoryId: -1, page: 0, url: nextUrl)
        }
    }

    func categorySelected(categoryId: Int) {
        selectedCategoryId = categoryId
        if brandDict[categoryId] != nil {
            self.delegate?.dataChanged()
        } else {
            fetchGifts(categoryId: categoryId, page: 1)
        }
    }
}

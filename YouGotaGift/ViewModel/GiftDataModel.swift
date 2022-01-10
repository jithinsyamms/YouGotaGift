//
//  GiftDataModel.swift
//  YouGotaGift
//
//  Created by Jithin on 08/01/22.
//

import Foundation

protocol GiftDataDelegate: AnyObject {
    func loadingStarted()
    func loadingFinished()
    func errorLoadingData()
    func dataChanged()
}

class GiftDataModel {

    var giftData: GiftData?
    weak var delegate: GiftDataDelegate?
    var isLoading: Bool = false

    var giftCategories: [GiftCategory] = []
    var brandDict: [Int: [GiftBrand]] = [:]
    var paginatedData: [Int: PaginatedData] = [:]
    var selectedCategoryId: Int  = -1

    func fetchGifts(categoryId: Int = 0, page: Int = 1) {
        guard !isLoading else {
            return
        }
        let giftResoucrce = GiftResource(category: categoryId, page: page)
        let giftRequest = GiftRequest(resource: giftResoucrce)
        self.delegate?.loadingStarted()
        giftRequest.execute { result in
            switch result {
            case .success(let giftData):
                self.giftData = giftData
                self.setUpData()
                self.delegate?.dataChanged()
            case .failure:
                DispatchQueue.main.async {
                    self.delegate?.errorLoadingData()
                }
            }
            DispatchQueue.main.async {
                self.delegate?.loadingFinished()
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


    func categorySelected(categoryId: Int) {
        selectedCategoryId = categoryId

        if brandDict[categoryId] != nil {
            self.delegate?.dataChanged()
        } else {
            fetchGifts(categoryId: categoryId, page: 1)
        }
    }



}

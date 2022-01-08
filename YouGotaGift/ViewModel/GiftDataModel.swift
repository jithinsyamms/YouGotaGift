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
}

class GiftDataModel {

    var giftData: GiftData?
    weak var delegate: GiftDataDelegate?
    var isLoading: Bool = false

    var giftCategories: [GiftCategory] = []
    var brandDict: [Int: [GiftBrand]] = [:]
    var paginatedData: [Int: PaginatedData] = [:]
    var selectedCategoryId: Int  = -1

    func fetchGifts() {
        guard !isLoading else {
            return
        }

        let giftResoucrce = GiftResource()
        let giftRequest = GiftRequest(resource: giftResoucrce)
        self.delegate?.loadingStarted()
        giftRequest.execute { result in
            switch result {
            case .success(let giftData):
                self.giftData = giftData
                print("success")
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

    func categorySelected(categoryId: Int) {
       
    }

    func getCategotyCount() -> Int {
        if let giftData = giftData {
            return giftData.categories?.count ?? 0
        }
        return 0

    }

    func getGiftBrandsCount() -> Int {
        if let giftData = giftData {
            return giftData.brands?.count ?? 0
        }
        return 0
    }

    func getCategories() -> [GiftCategory] {
        if let giftData = giftData, let categories = giftData.categories {
            return categories
        }
        return []
    }

    func getGiftBrands() -> [GiftBrand] {
        if let giftData = giftData, let giftBrands = giftData.brands {
            return giftBrands
        }
        return []
    }

}

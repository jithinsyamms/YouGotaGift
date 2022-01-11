//
//  GiftViewModelFetchTest.swift
//  YouGotaGiftTests
//
//  Created by Jithin on 11/01/22.
//

import XCTest
@testable import YouGotaGift

class GiftViewModelFetchTest: XCTestCase, GiftDataDelegate {

    var expectation: XCTestExpectation!
    var giftViewModel: GiftDataModel!

    override func setUp() {
        expectation = self.expectation(description: "GiftDataModelTest")
        giftViewModel = GiftDataModel()
        giftViewModel.delegate = self
    }

    override func tearDown() {
      expectation = nil
      giftViewModel.delegate = nil
      giftViewModel = nil
    }

    func loadingStarted(showIndicator: Bool) {

    }

    func errorLoadingData() {

    }

    func dataChanged() {
        XCTAssertNotNil(giftViewModel.giftData)
        XCTAssertGreaterThan(giftViewModel.giftCategories.count, 0)
        XCTAssertGreaterThan(giftViewModel.brandDict.count, 0)
        XCTAssertGreaterThan(giftViewModel.paginatedData.count, 0)
        expectation.fulfill()
    }

    func networkStatusChanged() {

    }

    func testViewModelFetchData() throws {
            giftViewModel = GiftDataModel()
            giftViewModel.fetchGifts(categoryId: 32, page: 1, url: "")
            waitForExpectations(timeout: 20, handler: nil)
    }

}

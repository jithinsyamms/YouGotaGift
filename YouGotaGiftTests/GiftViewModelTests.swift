//
//  GiftViewModelTests.swift
//  YouGotaGiftTests
//
//  Created by Jithin on 11/01/22.
//

import XCTest
@testable import YouGotaGift

class GiftViewModelTests: XCTestCase {

    func testViewModelDataSetUp() throws {

            let bundle = Bundle(for: type(of: self))
            guard let json = bundle.url(forResource: "gifts", withExtension: "json") else {
                    XCTFail("Missing file: gifts.json")
                        return
            }
            let giftViewModel = GiftDataModel()
            let jsonData = try Data(contentsOf: json)
            let giftData = try JSONDecoder().decode(GiftData.self, from: jsonData)
            XCTAssertNotNil(giftData)
            giftViewModel.giftData = giftData
            giftViewModel.setUpData()

            XCTAssertGreaterThan(giftViewModel.giftCategories.count, 0)
            XCTAssertGreaterThan(giftViewModel.brandDict.count, 0)
            XCTAssertGreaterThan(giftViewModel.paginatedData.count, 0)
        }

}

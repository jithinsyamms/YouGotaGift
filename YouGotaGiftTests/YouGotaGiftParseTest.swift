//
//  YouGotaGiftParseTest.swift
//  YouGotaGiftTests
//
//  Created by Jithin on 11/01/22.
//

import XCTest
@testable import YouGotaGift

class YouGotaGiftParseTest: XCTestCase {

    func testCanParseGifts() throws {
            let bundle = Bundle(for: type(of: self))
            guard let json = bundle.url(forResource: "gifts", withExtension: "json") else {
                XCTFail("Missing file: gifts.json")
                return
            }
            let jsonData = try Data(contentsOf: json)
            let giftData = try JSONDecoder().decode(GiftData.self, from: jsonData)

            XCTAssertNotNil(giftData)
            XCTAssertNotNil(giftData.label)
            XCTAssertNotNil(giftData.categories)
            XCTAssertNotNil(giftData.brands)
            XCTAssertNotNil(giftData.paginatedData)
            XCTAssertNotNil(giftData.selectedCategory)

            XCTAssertGreaterThan(giftData.categories?.count ?? 0, 0)
            XCTAssertGreaterThan(giftData.brands?.count ?? 0, 0)

        }

}

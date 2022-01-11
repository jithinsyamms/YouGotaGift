//
//  YouGotaGiftNetworkTest.swift
//  YouGotaGiftTests
//
//  Created by Jithin on 11/01/22.
//

import XCTest
@testable import YouGotaGift

class YouGotaGiftNetworkTest: XCTestCase {

    var giftResource: GiftResource!
    var giftRequest: GiftRequest<GiftResource>!

    override func setUpWithError() throws {
        giftResource = GiftResource(category: 32, page: 1, url: "")
        giftRequest = GiftRequest(resource: giftResource)
    }

    override func tearDownWithError() throws {
      giftResource = nil
    }

    func testNetworkRequestForGiftResponse() {

        let expectation = self.expectation(description: "RequestReturnsGiftsResponse")
        giftRequest.execute { response in
                    XCTAssertNotNil(response)
                    switch response {
                    case .failure(let error):
                        XCTFail("Expected to be a success but got a failure with \(error)")
                    case .success(let value):
                        XCTAssertNotNil(value)
                    }

                    expectation.fulfill()
                }
                waitForExpectations(timeout: 5, handler: nil)
    }

}

//
//  YouGotaGiftURLTests.swift
//  YouGotaGiftTests
//
//  Created by Jithin on 11/01/22.
//

import XCTest
@testable import YouGotaGift

class YouGotaGiftURLTests: XCTestCase {

        var giftResource: GiftResource!
        let expectedScheme = "https"
        let expectedBaseUrl = "emapi-sandbox.yougotagift.com"
        let expectedPath =  "/uae/api/v3/brands/featured/"
        let expectedMethod = "GET"
        var expectedParams: [URLQueryItem] = []

        override func setUp() {
            super.setUp()
            giftResource = GiftResource(category: 32, page: 1, url: "")
            expectedParams.append(URLQueryItem(name: "api_key", value: "2vq1M9ye4eV6H1Mr"))
            expectedParams.append(URLQueryItem(name: "api_secret", value: "wnRY14QoA99B4Ae6wn2CU2y8"))
            expectedParams.append(URLQueryItem(name: "category", value: "32"))
            expectedParams.append(URLQueryItem(name: "page", value: "1"))
        }
        override func tearDown() {
            super.tearDown()
            giftResource = nil
        }

        func testURLSchemeIsCorrect() {
            let scheme = giftResource.scheme
            XCTAssertEqual(scheme, expectedScheme, "scheme does not match with expected scheme")
        }

        func testBaseUrlIsCorrect() {
            let baseUrl = giftResource.baseURL
            XCTAssertEqual(baseUrl, expectedBaseUrl, "Base URL does not match with expected base URL")
        }

        func testURLPathIsCorrect() {
            let path = giftResource.path
            XCTAssertEqual(path, expectedPath, "path does not match with expected path")
        }

        func testURLMethodIsCorrect() {
            let method = giftResource.method
            XCTAssertEqual(method, expectedMethod, "URL method does not match with expected method")
        }

        func testURLparametersAreCorrect() {
            let expectedCount = expectedParams.count
            let count = giftResource.parameters.count
            XCTAssertEqual(count, expectedCount, "Url Parameters  does not match with expected parameters")
        }

        func testURLIsCorrect() {
            var components = URLComponents()
            components.scheme = expectedScheme
            components.host = expectedBaseUrl
            components.path = expectedPath
            components.queryItems = expectedParams
            let expectedURL = components.url
            let url = giftResource.URL
            XCTAssertEqual(url, expectedURL, "URL does not match with expected URL")
        }

}

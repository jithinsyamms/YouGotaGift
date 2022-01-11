//
//  YouGotaGiftUITests.swift
//  YouGotaGiftUITests
//
//  Created by Jithin on 06/01/22.
//

import XCTest
@testable import YouGotaGift

class YouGotaGiftUITests: XCTestCase {

    var app: XCUIApplication!

    override func setUpWithError() throws {
        try super.setUpWithError()
        continueAfterFailure = false
    }

    func testCategoryTitleWithCells() throws {
        app = XCUIApplication()
        app.launch()
        let categoryCollectionView = app.collectionViews["category_collection_view"]
        XCTAssertTrue(categoryCollectionView.exists)
        let cellCount = NSPredicate(format: "cells.count > 0")
        expectation(for: cellCount, evaluatedWith: categoryCollectionView, handler: nil)
        waitForExpectations(timeout: 15, handler: nil)
        let secondChild = categoryCollectionView.cells.element(boundBy: 1)
        XCTAssertTrue(secondChild.exists)
        secondChild.tap()
        let categoryTitle = app.staticTexts["category_title_view"]
        let exists = NSPredicate(format: "exists == 1")
        expectation(for: exists, evaluatedWith: categoryTitle, handler: nil)
        waitForExpectations(timeout: 15, handler: nil)
        let categoryName = secondChild.staticTexts.element
        XCTAssertTrue(categoryName.exists)
        XCTAssertTrue(categoryTitle.exists)
        Thread.sleep(forTimeInterval: 2)
        XCTAssertEqual(categoryName.label, categoryTitle.label)

    }

    func testBrandCellLoaded() throws {
        app = XCUIApplication()
        app.launch()

        let brandsCollectionView = app.collectionViews["brands_collection_view"]
        XCTAssertTrue(brandsCollectionView.exists)
        let exists = NSPredicate(format: "cells.count > 0")
        expectation(for: exists, evaluatedWith: brandsCollectionView, handler: nil)
        waitForExpectations(timeout: 15, handler: nil)
        let firstChild = brandsCollectionView.cells.element(boundBy: 0)
        XCTAssertTrue(firstChild.exists)

        let brandTitleView  = firstChild.staticTexts["brand_name_view"]
        let brandTaglineView  = firstChild.staticTexts["brand_tagline_view"]

        XCTAssertTrue(brandTitleView.exists)
        XCTAssertTrue(brandTaglineView.exists)
    }

    func testWithMockData() throws {
        app = XCUIApplication()
        app.launchArguments.append("YouGotaGift-UITest")
        app.launch()

        let brandsCollectionView = app.collectionViews["brands_collection_view"]
        XCTAssertTrue(brandsCollectionView.exists)
        let exists = NSPredicate(format: "cells.count > 0")
        expectation(for: exists, evaluatedWith: brandsCollectionView, handler: nil)
        waitForExpectations(timeout: 15, handler: nil)
        let firstChild = brandsCollectionView.cells.element(boundBy: 0)
        XCTAssertTrue(firstChild.exists)

        Thread.sleep(forTimeInterval: 2)

        let brandTitleView  = firstChild.staticTexts["brand_name_view"]
        let brandTaglineView  = firstChild.staticTexts["brand_tagline_view"]
        let currencyLabel = firstChild.staticTexts["currency_label_view"]

        XCTAssertTrue(brandTitleView.exists)
        XCTAssertTrue(brandTaglineView.exists)
        XCTAssertTrue(currencyLabel.exists)
        XCTAssertEqual(brandTitleView.label, "Malabar Gold & Diamonds")
        XCTAssertEqual(brandTaglineView.label, "Jewelry")
    }

}

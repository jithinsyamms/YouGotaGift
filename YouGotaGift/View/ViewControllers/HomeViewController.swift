//
//  HomeViewController.swift
//  YouGotaGift
//
//  Created by Jithin on 06/01/22.
//

import UIKit

class HomeViewController: UIViewController {

    let cellIdentifier = "GiftItemCell"
    let headerIdentifier = "GiftHeaderView"
    let footerIdentifier = "GiftFooterView"

    var activityIndicator = UIActivityIndicatorView()
    private let itemsPerRow: CGFloat = 2
    private let sectionInsets = UIEdgeInsets(
        top: 20.0,
        left: 10.0,
        bottom: 10.0,
        right: 10.0)

    var collectionHeaderView: GiftHeaderView!
    var collectionFooterView: GiftFooterView!

    @IBOutlet weak var collectionView: UICollectionView!

    private let giftDataModel = GiftDataModel()

    private var giftBrands: [GiftBrand]?
    private var giftCategories: [GiftCategory]?
    private var selectedCategory: GiftCategory?

    override func viewDidLoad() {
        super.viewDidLoad()
        setActivityIndicator()
        setNavigationBar()
        collectionView.register(UINib(nibName: "GiftItemCell", bundle: nil), forCellWithReuseIdentifier: cellIdentifier)
        collectionView.register(UINib(nibName: "GiftHeaderView", bundle: nil),
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: headerIdentifier)
        collectionView.register(UINib(nibName: "GiftFooterView", bundle: nil),
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: footerIdentifier)

        giftDataModel.delegate = self
        giftDataModel.fetchGifts()
    }

    func setActivityIndicator() {
        activityIndicator.center = view.center
        activityIndicator.style = .large
        activityIndicator.color = UIColor.systemPink
        view.addSubview(activityIndicator)
    }

    func setNavigationBar() {
        let logo = UIImage(named: "Icon-29")
        let imageView = UIImageView(image: logo)
        self.navigationItem.titleView = imageView
        activityIndicator.hidesWhenStopped = true
    }
}

extension HomeViewController: GiftDataDelegate {
    func loadingStarted() {
        activityIndicator.startAnimating()
        view.isUserInteractionEnabled = false
    }

    func loadingFinished() {
    }

    func errorLoadingData() {
    }

    func dataChanged() {
        giftBrands = giftDataModel.getGiftBrands()
        giftCategories = giftDataModel.getCategories()
        selectedCategory = giftDataModel.getSelectedCategory()
        self.collectionView.reloadData()
        activityIndicator.stopAnimating()
        view.isUserInteractionEnabled = true
    }
}

extension HomeViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return giftBrands?.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        if let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: cellIdentifier, for: indexPath) as? GiftItemCell {
            cell.setData(brand: giftBrands?[indexPath.row])
            return cell
        }
        return UICollectionViewCell()
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {

        var reusableView = UICollectionReusableView()

        if kind == UICollectionView.elementKindSectionHeader {
            if let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                withReuseIdentifier: headerIdentifier,
                                for: indexPath) as? GiftHeaderView {
                reusableView = headerView
                collectionHeaderView = headerView
                collectionHeaderView.delegate = self
                collectionHeaderView.setData(categories: giftCategories, selectedCategory: selectedCategory)

            }
        } else if kind == UICollectionView.elementKindSectionFooter {
            if let footerView = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind, withReuseIdentifier: footerIdentifier, for: indexPath) as? GiftFooterView {
                reusableView = footerView
                collectionFooterView = footerView
            }
        }
        return reusableView
    }

}

extension HomeViewController: UICollectionViewDelegateFlowLayout {

    public func collectionView(_ collectionView: UICollectionView,
                               layout collectionViewLayout: UICollectionViewLayout,
                               sizeForItemAt indexPath: IndexPath) -> CGSize {
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        return CGSize(width: widthPerItem, height: widthPerItem)
    }

    func collectionView( _ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                         insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }

    public func collectionView(_ collectionView: UICollectionView, layout
                               collectionViewLayout: UICollectionViewLayout,
                               referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height * 0.55)
    }

    func collectionView(_ collectionView: UICollectionView,
                        layoutcollectionViewLayout: UICollectionViewLayout,
                        referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 30)
    }
}

extension HomeViewController: CategoryProtocol {
    func categorySelected(categoryId: Int) {
        giftDataModel.categorySelected(categoryId: categoryId)
    }
}

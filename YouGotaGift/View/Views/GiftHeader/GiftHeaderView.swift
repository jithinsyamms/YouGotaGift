//
//  GiftHeaderView.swift
//  YouGotaGift
//
//  Created by Jithin on 06/01/22.
//

import UIKit

class GiftHeaderView: UICollectionReusableView {

    @IBOutlet weak var headerImage: UIImageView!
    @IBOutlet weak var headerTitle: UILabel!
    @IBOutlet weak var headerSubtitle: UILabel!
    @IBOutlet weak var categoryCollection: UICollectionView!
    @IBOutlet weak var categoryTitle: UILabel!

    private let itemsPerRow: CGFloat = 2.5
    private let sectionInsets = UIEdgeInsets(
        top: 0.0,
        left: 8.0,
        bottom: 0.0,
        right: 8.0)

    private var giftCategories: [GiftCategory]?
    private var selectedCategory: GiftCategory?

    override func awakeFromNib() {
        super.awakeFromNib()
        categoryCollection.register(UINib(nibName: "GiftCategoryCell",
                                    bundle: nil), forCellWithReuseIdentifier: "GiftCategoryCell")
    }

    func setData(categories: [GiftCategory]?, selectedCategory: GiftCategory?) {

        guard let categories = categories, let selectedCategory = selectedCategory else {
            return
        }
        self.selectedCategory = selectedCategory
        self.giftCategories = categories
        headerImage.alpha = 0.9
        if let categoryImageUrl = selectedCategory.imageLarge {
            headerImage.loadImageFromURL(urlString: categoryImageUrl)
        }
        headerTitle.text = selectedCategory.title ?? ""
        headerSubtitle.text = selectedCategory.caption ?? ""
        categoryCollection.reloadData()
    }
}

extension GiftHeaderView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return giftCategories?.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = categoryCollection.dequeueReusableCell(
            withReuseIdentifier: "GiftCategoryCell", for: indexPath) as? GiftCategoryCell {
            cell.setData(category: giftCategories?[indexPath.row])
            return cell
        }
        return UICollectionViewCell()
    }

}

extension GiftHeaderView: UICollectionViewDelegateFlowLayout {

    public func collectionView(_ collectionView: UICollectionView,
                               layout collectionViewLayout: UICollectionViewLayout,
                               sizeForItemAt indexPath: IndexPath) -> CGSize {
        let widthPerItem = categoryCollection.bounds.size.width/2.5
        let heightPerItem = categoryCollection.bounds.size.height
        return CGSize(width: widthPerItem, height: heightPerItem)
    }

    func collectionView( _ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                         insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
}

//
//  GiftHeaderView.swift
//  YouGotaGift
//
//  Created by Jithin on 06/01/22.
//

import UIKit

protocol CategoryProtocol: AnyObject {
    func categorySelected(categoryId: Int)
}

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
    weak var delegate: CategoryProtocol?

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
        if let categoryImageUrl = selectedCategory.imageLarge {
            headerImage.loadImageFromURL(urlString: categoryImageUrl)
        }
        headerTitle.text = selectedCategory.title ?? ""
        headerSubtitle.text = selectedCategory.caption ?? ""
        categoryTitle.text = selectedCategory.name
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
            cell.setData(category: giftCategories?[indexPath.row], selectedId: selectedCategory?.id ?? -1)
            return cell
        }
        return UICollectionViewCell()
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(delegate)
        delegate?.categorySelected(categoryId: giftCategories?[indexPath.row].id ?? 0 )
    }
}

extension GiftHeaderView: UICollectionViewDelegateFlowLayout {

    public func collectionView(_ collectionView: UICollectionView,
                               layout collectionViewLayout: UICollectionViewLayout,
                               sizeForItemAt indexPath: IndexPath) -> CGSize {
        let widthPerItem = categoryCollection.bounds.size.width/2.6
        let heightPerItem = categoryCollection.bounds.size.height
        return CGSize(width: widthPerItem, height: heightPerItem)
    }

    func collectionView( _ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                         insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
}

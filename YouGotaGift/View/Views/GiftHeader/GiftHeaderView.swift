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

    override func awakeFromNib() {
        super.awakeFromNib()
        categoryCollection.register(UINib(nibName: "GiftCategoryCell",
                                    bundle: nil), forCellWithReuseIdentifier: "GiftCategoryCell")
    }

    func setData() {
        headerImage.loadImageFromURL(urlString: "https://source.unsplash.com/user/c_v_r/100x100")
    }

}

extension GiftHeaderView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = categoryCollection.dequeueReusableCell(
            withReuseIdentifier: "GiftCategoryCell", for: indexPath) as? GiftCategoryCell {
            cell.setData()
            return cell
        }
        return UICollectionViewCell()
    }

}

extension GiftHeaderView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (categoryCollection.bounds.size.width/2.5)
        let height = categoryCollection.bounds.size.height
        return CGSize(width: width, height: height)
    }
}

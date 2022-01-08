//
//  GiftCategoryCell.swift
//  YouGotaGift
//
//  Created by Jithin on 07/01/22.
//

import UIKit

class GiftCategoryCell: UICollectionViewCell {
    @IBOutlet weak var rootView: UIView!
    @IBOutlet weak var selectedImage: UIImageView!
    @IBOutlet weak var categoryImage: UIImageView!
    @IBOutlet weak var categotyTitle: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func setData(category: GiftCategory?, selectedId:Int) {

        guard let giftCategory = category else {
            return
        }
        selectedImage.alpha = giftCategory.id == selectedId ? 1.0 : 0
        rootView.layer.cornerRadius = 8
        rootView.layer.borderWidth = 0.2
        rootView.layer.borderColor = UIColor.lightGray.cgColor
        categoryImage.layer.cornerRadius = 8
        categoryImage.clipsToBounds = true
        categotyTitle.text = giftCategory.name
        if let image = giftCategory.imageSmall {
            categoryImage.loadImageFromURL(urlString: image)
        }
    }
}

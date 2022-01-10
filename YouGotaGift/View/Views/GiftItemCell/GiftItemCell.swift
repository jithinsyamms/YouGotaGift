//
//  GiftItemCell.swift
//  YouGotaGift
//
//  Created by Jithin on 06/01/22.
//

import UIKit

class GiftItemCell: UICollectionViewCell {

    @IBOutlet weak var root: UIView!
    @IBOutlet weak var topLeftView: UIView!

    @IBOutlet weak var redemptionTag: UILabel!
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var giftImage: UIImageView!

    @IBOutlet weak var nameLabel: UILabel!

    @IBOutlet weak var taglineLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()

    }

    func setData(brand: GiftBrand?) {

        guard let giftBrand = brand else {
            return
        }
        root.layer.cornerRadius = 10
        root.layer.borderColor = UIColor.lightGray.cgColor
        root.layer.borderWidth = 0.3
        topLeftView.layer.cornerRadius = 6
        if let tag = giftBrand.redemptionTag, tag.count > 0 {
            topLeftView.alpha = 1
        } else {
            topLeftView.alpha = 0
        }
        redemptionTag.text = giftBrand.redemptionTag
        giftImage.layer.cornerRadius = 10

        nameLabel.text = giftBrand.name
        taglineLabel.text = giftBrand.shortTagline
        if let productImageUrl = giftBrand.productImage {
            giftImage.loadImageFromURL(urlString: productImageUrl)
        }

    }

}

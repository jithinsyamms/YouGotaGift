//
//  GiftCategoryCell.swift
//  YouGotaGift
//
//  Created by Jithin on 07/01/22.
//

import UIKit

class GiftCategoryCell: UICollectionViewCell {
    @IBOutlet weak var overlayView: UIView!
    @IBOutlet weak var rootView: UIView!
    @IBOutlet weak var selectedImage: UIImageView!
    @IBOutlet weak var categoryImage: UIImageView!
    @IBOutlet weak var categotyTitle: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func setData(category: GiftCategory?, selectedId: Int) {

        guard let giftCategory = category else {
            return
        }
        selectedImage.alpha = giftCategory.id == selectedId ? 1.0 : 0
        rootView.layer.cornerRadius = 8
        categoryImage.layer.cornerRadius = 8
        categoryImage.clipsToBounds = true
        overlayView.layer.cornerRadius = 8
        categotyTitle.text = giftCategory.name

        if giftCategory.id == selectedId {
            overlayView.backgroundColor = hexStringToUIColor(hex: giftCategory.bgColorCode ?? "#FFFFFF")
            categoryImage.alpha = 0
            overlayView.alpha = 1
        } else {
            overlayView.backgroundColor = UIColor.black
            categoryImage.alpha = 1
            overlayView.alpha = 0.2
            if let image = giftCategory.imageSmall {
              categoryImage.loadImageFromURL(urlString: image)
            }
        }
    }
}

func hexStringToUIColor (hex: String) -> UIColor {
    var cString: String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
    if cString.hasPrefix("#") {
        cString.remove(at: cString.startIndex)
    }
    if cString.count != 6 {
        return UIColor.gray
    }
    var rgbValue: UInt64 = 0
    Scanner(string: cString).scanHexInt64(&rgbValue)
    return UIColor(
        red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
        green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
        blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
        alpha: CGFloat(1.0)
    )
}

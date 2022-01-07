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

    func setData() {

        rootView.layer.cornerRadius = 8
        rootView.layer.borderWidth = 0.2
        rootView.layer.borderColor = UIColor.lightGray.cgColor
        selectedImage.layer.cornerRadius = 8
        rootView.backgroundColor = UIColor.purple
    }
}

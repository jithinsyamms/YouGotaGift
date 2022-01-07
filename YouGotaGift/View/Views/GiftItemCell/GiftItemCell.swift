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
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var giftImage: UIImageView!

    @IBOutlet weak var nameLabel: UILabel!

    @IBOutlet weak var taglineLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setData() {
        root.layer.cornerRadius = 10
        root.layer.borderColor = UIColor.lightGray.cgColor
        root.layer.borderWidth = 0.3
        topLeftView.layer.cornerRadius = 10
        giftImage.layer.cornerRadius = 10
        giftImage.loadImageFromURL(urlString: "https://source.unsplash.com/user/c_v_r/1900x800")
    }

}

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

    }

    func setData() {
        headerImage.loadImageFromURL(urlString: "https://source.unsplash.com/user/c_v_r/100x100")
    }

}

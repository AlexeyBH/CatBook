//
//  RatingTableViewCell.swift
//  CatBook
//
//  Created by Михаил Зиновьев on 14.11.2021.
//

import UIKit

class RatingTableViewCell: UITableViewCell {

    @IBOutlet weak var catImegeView: UIImageView!
    @IBOutlet weak var catNameLabel: UILabel!
    @IBOutlet weak var catRatingLabel: UILabel!
    
    func configure(image: UIImage?, name: String?, rating: String?) {
        self.catImegeView.image = image ?? UIImage()
        self.catNameLabel.text = name ?? ""
        self.catRatingLabel.text = rating ?? ""
    }
}

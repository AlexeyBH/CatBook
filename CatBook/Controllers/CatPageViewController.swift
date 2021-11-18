//
//  CatPageViewController.swift
//  CatBook
//
//  Created by Anna Ivanova on 13.11.2021.
//

import UIKit

class CatPageViewController: UIViewController {

    @IBOutlet var imageCat: UIImageView!
    @IBOutlet var nameCatLable: UILabel!
    @IBOutlet var descriptionСatLable: UILabel!
    
    var cat: CatInfo?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let strongCat = cat {
            imageCat.image = UIImage(named: strongCat.imagePath)
            nameCatLable.text = strongCat.name
            descriptionСatLable.text = strongCat.description
        }
    }
}

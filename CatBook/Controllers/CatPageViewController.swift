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
        
        imageCat.image = UIImage(named: cat?.imagePath ?? "")
        nameCatLable.text = cat?.name
        descriptionСatLable.text = cat?.description
    }

}

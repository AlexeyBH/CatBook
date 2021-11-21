//
//  CatPageViewController.swift
//  CatBook
//
//  Created by Anna Ivanova on 13.11.2021.
//

import UIKit

class CatPageViewController: UITableViewController {
    

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
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        CatDatabase.shared.catsByRating.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "phoneRecord", for: indexPath)
        var content = cell.defaultContentConfiguration()
        let cat = CatDatabase.shared.randomCatToVote
        content.text = cat?.name
        cell.contentConfiguration = content
     
        return cell
    }
    
    
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        guard let destination = segue.destination as? UserDetailsViewController,
//              let indexPath = tableView.indexPathForSelectedRow else { return }
//        destination.userInfo = userList.asArray[indexPath.section]
//    }
 

}

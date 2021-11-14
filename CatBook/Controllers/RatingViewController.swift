//
//  RatingViewController.swift
//  CatBook
//
//  Created by Михаил Зиновьев on 14.11.2021.
//

import UIKit

class RatingViewController: UIViewController, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(UINib(nibName: "RatingTableViewCell", bundle: nil), forCellReuseIdentifier: "RatingTableViewCell")
    }
    
}

//MARK: - UITableViewDataSource
extension RatingViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RatingTableViewCell", for: indexPath) as? RatingTableViewCell else { return UITableViewCell() }
        
        cell.configure(image: UIImage(named: "CatImage_1"), name: "Kitty", rating: "5")
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
}

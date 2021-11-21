//
//  RatingViewController.swift
//  CatBook
//
//  Created by Михаил Зиновьев on 14.11.2021.
//

import UIKit

class RatingViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(RatingTableViewCell.nib, forCellReuseIdentifier: RatingTableViewCell.identifier)
    }
}

//MARK: - @IBAction
extension RatingViewController {
    @IBAction func aboutUsButtonPressed(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "showAboutScreen", sender: nil)
    }
}

//MARK: - UITableViewDataSource
extension RatingViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CatDatabase.shared.catsByRating.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView
                .dequeueReusableCell(
                    withIdentifier: RatingTableViewCell.identifier,
                    for: indexPath) as? RatingTableViewCell
        else { return UITableViewCell() }
        
        let cat = CatDatabase.shared.catsByRating[indexPath.row]
        cell.configure(image: UIImage(named: cat.imagePath), name: cat.name, rating: String(cat.rating))

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
}

//MARK: - UITableViewDelegate
extension RatingViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showCatDetailScreen", sender: nil)
    }
}

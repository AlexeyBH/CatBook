//
//  RatingViewController.swift
//  CatBook
//
//  Created by Михаил Зиновьев on 14.11.2021.
//

import UIKit

class RatingViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    let cats = CatDatabase.shared.catsByRating
    
    override func viewDidLoad() {
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(RatingTableViewCell.nib, forCellReuseIdentifier: RatingTableViewCell.identifier)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showCatDetailScreen" {
            guard let catPage = segue.destination as? CatPageViewController,
                  let cat = sender as? CatInfo else { return }

            catPage.cat = cat
        }
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
        return cats.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView
                .dequeueReusableCell(
                    withIdentifier: RatingTableViewCell.identifier,
                    for: indexPath) as? RatingTableViewCell
        else { return UITableViewCell() }
        let cat = cats[indexPath.row]
        
//        cell.configure(image: UIImage(named: "CatImage_1"), name: "Kitty", rating: "5")
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

        performSegue(withIdentifier: "showCatDetailScreen", sender: cats[indexPath.row])

    }
}


//
//  CatInfo.swift
//  CatBook
//
//  Created by Alexey Khestanov on 15.11.2021.
//

import Foundation

class CatInfo {
    
    let name: String
    let description: String
    let imagePath: String
    
    private var alreadyVotedFor: Bool = false
    private var votesTotal: Int
    private var votesCount: Int
    
    // Не является вычисляемым свойством с целью оптимизации
    private var ratingPrivate: Double = 0
    
    var rating: Double {
        ratingPrivate
    }
    
    var canBeVotedFor: Bool {
        !alreadyVotedFor
    }
    
    func voteFor(rating: Int) -> Double {
        guard rating >= 1 && rating <= 5, !alreadyVotedFor else { return ratingPrivate }
        alreadyVotedFor = true
        votesTotal += rating
        votesCount += 1
        ratingPrivate = Double(100 * votesTotal / votesCount) / 100.0
        return ratingPrivate
    }
    
    init?(name: String, description: String, imagePath: String, initialVotesTotal: Int, initialVotesCount: Int) {
        guard
            imagePath != "",
            name.count > 1,
            description.count > 10,
            initialVotesCount >= 0,
            // Проверка на начальный рейтинг от 1 до 5 включительно
            initialVotesTotal >= initialVotesCount,
            initialVotesTotal <= initialVotesCount * 5
        else { return nil }
        self.name = name
        self.description = description
        self.imagePath = imagePath
        self.votesCount = initialVotesCount
        self.votesTotal = initialVotesTotal
    }
}

class CatDatabase {
    
    let shared = CatDatabase()
    
    private let cats: [CatInfo]
    
    var catsByRating: [CatInfo] {
        cats.sorted { $1.rating < $0.rating }
    }
    
    var randomCatToVote: CatInfo? {
        let canBeVoted = cats.filter {$0.canBeVotedFor}
        return canBeVoted.randomElement()
    }
  
    private init() {
        cats = catInit()
        
        for cat in cats {
            print("name: \(cat.name), hobbies: \(cat.description), image: \(cat.imagePath)")
        }
    }
    
}



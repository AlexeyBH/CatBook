//
//  catInit.swift
//  CatBook
//
//  Created by Alexey Khestanov on 18.11.2021.
//

import Foundation

// Цвета котиков
enum CatColor {
    case red
    case black
    case gray
    case brown
    case any
}

// Пол котиков
enum CatGender {
    case male
    case female
    case any
}

// Жирнота котиков
enum CatFatness {
    case lean
    case normal
    case fat
    case any
}


// Набор параметров кота
struct CatOptions: Equatable {
    let gender: CatGender
    let fatness: CatFatness
    let color: CatColor
    
    static func ==(lhs: CatOptions, rhs: CatOptions) -> Bool {
        return (lhs.gender == rhs.gender || lhs.gender == .any || rhs.gender == .any) &&
               (lhs.fatness == rhs.fatness || lhs.fatness == .any || rhs.fatness == .any) &&
               (lhs.color == rhs.color || lhs.color == .any || rhs.color == .any)
    }
    
    init(_ gender: CatGender, _ fatness: CatFatness, _ color: CatColor) {
        self.gender = gender
        self.fatness = fatness
        self.color = color
    }
    
}

func catInit() -> [CatInfo] {
    
    // Картинка котика определяет некоторые его параметры
    // База - то есть картинка с конкретным котиком
    var catBase: [String: CatOptions] = [
        "CatImage_1":   CatOptions(.any,    .fat,    .black),
        "CatImage_2":   CatOptions(.any,    .fat,    .gray),
        "CatImage_3":   CatOptions(.any,    .lean,   .black),
        "CatImage_4":   CatOptions(.any,    .fat,    .gray),
        "CatImage_5":   CatOptions(.any,    .fat,    .red),
        "CatImage_6":   CatOptions(.any,    .fat,    .red),
        "CatImage_7":   CatOptions(.any,    .normal, .brown),
        "CatImage_8":   CatOptions(.any,    .normal, .gray),
        "CatImage_9":   CatOptions(.any,    .normal, .brown),
        "CatImage_10":   CatOptions(.any,    .normal, .gray),
        "CatImage_11":   CatOptions(.any,    .lean,   .gray),
        "CatImage_12":   CatOptions(.any,    .lean,   .black),
    ]
    
    // Имена котиков в зависимости от пола и, иногда, цвета
    var catNames: [String: CatOptions] = [
        "Маруся":       CatOptions(.female, .any,    .any),
        "Алиса":        CatOptions(.female, .any,    .any),
        "Муся":         CatOptions(.female, .any,    .any),
        "Соня":         CatOptions(.female, .any,    .any),
        "Пушок":        CatOptions(.male,   .any,    .any),
        "Барсик":       CatOptions(.male,   .any,    .any),
        "Кузя":         CatOptions(.male,   .any,    .any),
        "Вася":         CatOptions(.male,   .any,    .any),
        "Сема":         CatOptions(.male,   .any,    .any),
        "Рыжик":        CatOptions(.male,   .any,    .red),
        "Китти":        CatOptions(.female, .any,    .any),
        "Зюзя":         CatOptions(.female, .any,    .any),
        "Тракторина":   CatOptions(.female, .any,    .any),
        "Спартак":      CatOptions(.male,   .any,    .any)
    ]
                                                
                                                
    // Хобби котиков в зависимости от их параметров
    let catHobbies: [String: CatOptions] = [
        "кушать все подряд":        CatOptions(.any,    .fat,    .any),
        "спать на батарее":         CatOptions(.male,   .fat,    .any),
        "спать на коленках":        CatOptions(.female, .fat,    .any),
        "лежать на кровати":        CatOptions(.any,    .fat,    .any),
        "воровать еду со стола":    CatOptions(.male,   .fat,    .any),
        "притворяться ковриком":    CatOptions(.female, .fat,    .any),
        "прыгать гостям на спину":  CatOptions(.male,   .lean,   .any),
        "наблюдать за птичками":    CatOptions(.female, .lean,   .any),
        "когда его гладят":         CatOptions(.male,   .any,    .any),
        "когда ее гладят":          CatOptions(.female, .any,    .any),
        "смотреть телевизор":       CatOptions(.any,    .any,    .any),
        "играть с мячиком":         CatOptions(.any,    .normal, .any),
        "точить когти об диван":    CatOptions(.any,    .any,    .any),
        "ловить мух":               CatOptions(.any,    .lean,   .any)
    ]
    

    var newCats: [CatInfo] = []
    let allowedCount = min(catBase.count, catNames.count)
    let catsCount = Int.random(in: (allowedCount / 2)...allowedCount)
    

    for _ in 0..<catsCount {
        if let catTemplate = catBase.randomElement() {
            let catOptions: CatOptions
            // Если пол указан .any, делаем его рандомным
            if catTemplate.value.gender == .any {
                catOptions = CatOptions(
                    Bool.random() ? CatGender.male : CatGender.female,
                    catTemplate.value.fatness,
                    catTemplate.value.color
                )
            } else {
                catOptions = catTemplate.value
            }
            // Выбираем произвольного кота, подходящего по фильтру параметров
            if let catData = catNames.filter({ $0.value == catOptions }).randomElement() {
                let catName = catData.key
                // Создаем список хобби, отфильтровывая их по параметрам кота.
                let catHobbies = " Нравится: " +
                    catHobbies.compactMap(
                        { $0.value == catOptions ? $0.key : nil }
                    ).filter({ String -> Bool in Bool.random() }).shuffled().joined(separator: ", ")
                let rating = Double.random(in: 1...5)
                let votes = Int.random(in: 3...5)
                if let catInfo = CatInfo(
                    name: catName,
                    description: catHobbies,
                    imagePath: catTemplate.key,
                    initialVotesTotal: Int(rating * Double(votes)),
                    initialVotesCount: votes
                ) {
                    catBase[catTemplate.key] = nil
                    catNames[catName] = nil
                    newCats.append(catInfo)
                } else {
                    continue
                }
            }
        } else {
            break
        }
    }
    return newCats
}

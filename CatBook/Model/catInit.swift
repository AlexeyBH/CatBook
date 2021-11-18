//
//  catInit.swift
//  CatBook
//
//  Created by Alexey Khestanov on 18.11.2021.
//

import Foundation

// База - то есть картинка с конкретным котиком
enum CatBase: String {
    case Cat_01 = "Cat_1"
    case Cat_02 = "Cat_2"
    case Cat_03 = "Cat_3"
    case Cat_04 = "Cat_4"
    case Cat_05 = "Cat_5"
    case Cat_06 = "Cat_6"
    case Cat_07 = "Cat_7"
    case Cat_08 = "Cat_8"
    case Cat_09 = "Cat_9"
    case Cat_10 = "Cat_10"
    case Cat_11 = "Cat_11"
    case Cat_12 = "Cat_12"

}

// Цвета котиков
enum CatColor: String {
    case red = "рыжий"
    case black = "черный"
    case gray = "серый"
    case brown = "коричневый"
}

// Пол котиков
enum CatGender: String {
    case male = "кот"
    case female = "кошка"
}

// Жирнота котиков
enum CatFatness: String {
    case lean = "худоба"
    case normal = "нормально"
    case fat = "жирнота"
}

// Комбинации базы, пола, цвета и жирноты являются ключом для словарей, из которых происходит выборка по соответствию ключу.
// Если одно из свойств ключа равно nil, оно игнорируется в сравнении ключей (будет true по этому свойству).
// Так же данный ключ позволяет иметь в словаре множество одних и тех же комбинаций параметров.
struct CatHash: Hashable {

    var base: CatBase!
    var gender: CatGender!
    var fatness: CatFatness!
    var color: CatColor!
    // Необходимо для допуска дубликатов в словаре, salt игнорируется в сравнении двух ключей
    private let salt = Int.random(in: Int.min...Int.max)

    // Вычисление хэша кота для ключа словаря при том что часть свойств может быть nil
    func hash(into hasher: inout Hasher) {
        if let safeBase = base { hasher.combine(safeBase.rawValue) }
        if let safeGender = gender { hasher.combine(safeGender.rawValue) }
        if let safeFatness = fatness { hasher.combine(safeFatness.rawValue) }
        if let safeColor = color { hasher.combine(safeColor.rawValue) }
        hasher.combine(salt)
    }

    // В сравнении игнорируем salt, тем самым позволяя сравнивать "дубликаты" в словаре
    // nil в любом из свойств всегда как true - тем самым свойства с nil не участвуют в сравнении.
    static func ==(lhs: CatHash, rhs: CatHash) -> Bool {
        let baseCompared: Bool
        let genderCompared: Bool
        let fatnessCompared: Bool
        let colorCompared: Bool
        
        if let lhsBase = lhs.base, let rhsBase = rhs.base {
            baseCompared = lhsBase == rhsBase
        } else {
            baseCompared = true
        }
        
        if let lhsGender = lhs.gender, let rhsGender = rhs.gender {
            genderCompared = lhsGender == rhsGender
        } else {
            genderCompared = true
        }
        
        if let lhsFatness = lhs.fatness, let rhsFatness = rhs.fatness {
            fatnessCompared = lhsFatness == rhsFatness
        } else {
            fatnessCompared = true
        }
        
        if let lhsColor = lhs.color, let rhsColor = rhs.color {
            colorCompared = lhsColor == rhsColor
        } else {
            colorCompared = true
        }
        
        return baseCompared && genderCompared && fatnessCompared && colorCompared
    }

    init(gender: CatGender?, fatness: CatFatness?, color: CatColor?) {
        self.gender = gender
        self.fatness = fatness
        self.color = color
    }
    
    init(_ gender: CatGender?) {
        self.gender = gender
    }
    
    init(_ fatness: CatFatness?) {
        self.fatness = fatness
    }
    
    init(_ gender: CatGender?, _ color: CatColor?) {
        self.gender = gender
        self.color = color
    }
    
    init(_ gender: CatGender?, _ fatness: CatFatness?) {
        self.gender = gender
        self.fatness = fatness
    }
    
    init(_ fatness: CatFatness?, _ color: CatColor?) {
        self.fatness = fatness
        self.color = color
    }
    
    init(_ base: CatBase?) {
        self.base = base
    }
    
    init() {
    }
    
    // Можно добавлять свои инициализаторы в зависимости от комбинации параметров кота.
}

func catInit() -> [CatInfo] {
    
    // Картинка котика определяет некоторые его параметры,
    // а именно цвет и жирность.
    var catDefs: [CatHash: CatHash] = [
        CatHash(.Cat_01):   CatHash(.fat, .black),
        CatHash(.Cat_02):   CatHash(.fat, .gray),
        CatHash(.Cat_03):   CatHash(.lean, .black),
        CatHash(.Cat_04):   CatHash(.fat, .gray),
        CatHash(.Cat_05):   CatHash(.fat, .red),
        CatHash(.Cat_06):   CatHash(.fat, .red),
        CatHash(.Cat_07):   CatHash(.normal, .brown),
        CatHash(.Cat_08):   CatHash(.normal, .gray),
        CatHash(.Cat_09):   CatHash(.normal, .brown),
        CatHash(.Cat_10):   CatHash(.normal, .gray),
        CatHash(.Cat_11):   CatHash(.lean, .gray),
        CatHash(.Cat_12):   CatHash(.lean, .black),
    ]
    
    // Имена котиков в зависимости от пола и, иногда, цвета
    let catNames: [CatHash: String] = [
        CatHash(.female):           "Маруся",
        CatHash(.female):           "Алиса",
        CatHash(.female):           "Муся",
        CatHash(.female):           "Соня",
        CatHash(.male):             "Пушок",
        CatHash(.male):             "Барсик",
        CatHash(.male):             "Кузя",
        CatHash(.male):             "Вася",
        CatHash(.male):             "Сема",
        CatHash(.male, .red):       "Рыжик",
        CatHash(.female):           "Китти",
        CatHash(.female):           "Зюзя",
        CatHash(.female):           "Тракторина",
        CatHash(.male):             "Спартак"
    ]
    
    
    // Хобби котиков в зависимости от их параметров
    let catHobbies: [CatHash: String] = [
        CatHash(.fat):              "кушать все подряд",
        CatHash(.male, .fat):       "спать на батарее",
        CatHash(.female, .fat):     "спать на коленках",
        CatHash(.fat):               "лежать на кровати",
        CatHash(.male, .fat):       "воровать еду со стола",
        CatHash(.female, .fat):     "притворяться ковриком",
        CatHash(.male, .lean):      "разгоняться и прыгать гостям на спину",
        CatHash(.female, .lean):    "смотреть за птичками в окно",
        CatHash(.male):             "когда его гладят",
        CatHash(.female):           "когда ее гладят",
        CatHash():                  "смотреть телевизор",
        CatHash(.normal):           "играть с мячиком",
        CatHash():                  "точить когти об диван",
        CatHash(.lean):             "ловить мух"
    ]
    

    // Количество котиков
    let initialCatsCount = min(Int.random(in: 8...12), catDefs.count)
    
    var newCats: [CatInfo] = []
    
    for _ in 0..<initialCatsCount {
        guard
            let catTemplate = catDefs.randomElement()
        else {
            return []
        }
        catDefs.removeValue(forKey: catTemplate.key)
        let catPicture = catTemplate.key.base.rawValue
        let catHash = CatHash(
            gender: Bool.random() ? CatGender.male : CatGender.female,
            fatness: catTemplate.value.fatness,
            color: catTemplate.value.color
        )
        // Фильтруем список имен по хэшу и выбираем рандом
        guard
            let catData = catNames.filter({ $0.key == catHash }).randomElement()
        else {
            return []
        }
        
        let catName = catData.value
        let catHobbies = " Нравится: " + catHobbies.compactMap(
            { $0.key == catHash ? $0.value : nil }
        ).joined(separator: ", ")
        let rating = Double.random(in: 1...5)
        let votes = Int.random(in: 3...5)
        if let catInfo = CatInfo(
            name: catName,
            description: catHobbies,
            imagePath: catPicture,
            initialVotesTotal: Int(rating * Double(votes)),
            initialVotesCount: votes) {
            newCats.append(catInfo)
            
        } else {
            continue
        }
    }
    return newCats
    
}

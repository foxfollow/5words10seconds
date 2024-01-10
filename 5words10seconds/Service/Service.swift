//
//  Service.swift
//  5words10seconds
//
//  Created by Heorhii Savoiskyi on 30.10.2023.
//

import Foundation

struct Service {
    static let shared = Service()

    private var level: Int?

    private init() {}

    func chooseLevel(integet _: Int) { // todo level of categories
    }

    func getLevel() -> Int? { // very much to do
        return level
    }

    func fetchTeams(_ completion: @escaping (Result<Set<TeamModel>, Error>) -> Void) {
        switch MenuViewModel().currentLanguage.value {
        case "uk":
            completion(.success(allTeamsUa))
        default:
            completion(.success(allTeamsEng))
        }
    }

    func fetchCategories(_ completion: @escaping (Result<[CategoryModel], Error>) -> Void) {
        switch MenuViewModel().currentLanguage.value {
        case "uk":
            completion(.success(categoriesTMPUa))
        default:
            completion(.success(categoriesTMPEng))
        }
    }

//     useless things from exmaple:
//    static func fetchGameLevels(_ completion: @escaping (Result<[GameLevelModel], Error>) -> ()) {
//        completion(.success(gameLevels))
//    }
}

// let gameLevels: [GameLevelModel] = []

let allTeamsEng: Set = [
    // TeamModel(name: "Tomatoes", score: 0),
    // TeamModel(name: "Sleepwalkers", score: 0),
    // TeamModel(name: "Penguins", score: 0),
    // TeamModel(name: "Pineapples", score: 0),
    // TeamModel(name: "Pirates", score: 0),
    // TeamModel(name: "Angels", score: 0),
    TeamModel(name: "Incredible Impalas", score: 0),
    TeamModel(name: "Optimistic Ocelots", score: 0),
    TeamModel(name: "Flaming Flamingos", score: 0),
    TeamModel(name: "Joyful Jaguars", score: 0),
    TeamModel(name: "Shining Sharks", score: 0),
    TeamModel(name: "Talented Tarantulas", score: 0),
    TeamModel(name: "Unique Unicorns", score: 0),
    TeamModel(name: "Fantastic Foxes", score: 0),
    TeamModel(name: "Brave Butterflies", score: 0),
    TeamModel(name: "Curious Cheetahs", score: 0),
    TeamModel(name: "Magical Moths", score: 0),
    TeamModel(name: "Crazy Coyotes", score: 0),
    TeamModel(name: "Happy Hyenas", score: 0),
    TeamModel(name: "Young Yetis", score: 0),
    TeamModel(name: "Bright Beavers", score: 0),
    TeamModel(name: "Golden Geckos", score: 0),
    TeamModel(name: "Intellectual Iguanas", score: 0),
    TeamModel(name: "Creative Crabs", score: 0),
    TeamModel(name: "Legendary Lemurs", score: 0),
    TeamModel(name: "Wise Walruses", score: 0),
    TeamModel(name: "Adventurous Antelopes", score: 0),
    TeamModel(name: "Bubbly Bees", score: 0),
    TeamModel(name: "Clever Chameleons", score: 0),
    TeamModel(name: "Daring Dolphins", score: 0),
    TeamModel(name: "Energetic Elephants", score: 0),
    TeamModel(name: "Funny Frogs", score: 0),
    TeamModel(name: "Glowing Giraffes", score: 0),
    TeamModel(name: "Happy Hippos", score: 0),
    TeamModel(name: "Inventive Ibises", score: 0),
    TeamModel(name: "Joyful Jackals", score: 0),
    TeamModel(name: "Kind Kangaroos", score: 0),
    TeamModel(name: "Lively Lions", score: 0),
    TeamModel(name: "Merry Meerkats", score: 0),
    TeamModel(name: "Nimble Newts", score: 0),
    TeamModel(name: "Optimistic Otters", score: 0),
    TeamModel(name: "Playful Penguins", score: 0),
    TeamModel(name: "Quick Quails", score: 0),
    TeamModel(name: "Radiant Rabbits", score: 0),
    TeamModel(name: "Spirited Squirrels", score: 0),
    TeamModel(name: "Thrilling Tigers", score: 0),
]

let allTeamsUa: Set = [
    //    TeamModel(name: "Помідори", score: 0),
//    TeamModel(name: "Сомнамбули", score: 0),
//    TeamModel(name: "Пінгвіни", score: 0),
//    TeamModel(name: "Ананаси", score: 0),
//    TeamModel(name: "Пірати", score: 0),
//    TeamModel(name: "Янголи", score: 0),
//    TeamModel(name: "Коти", score: 0),
//    TeamModel(name: "Собаки", score: 0),
//    TeamModel(name: "Кролики", score: 0),
    TeamModel(name: "Блискучі Буряки", score: 0),
    TeamModel(name: "Веселі Вітрули", score: 0),
    TeamModel(name: "Галасливі Горішки", score: 0),
    TeamModel(name: "Дивовижні Динозаври", score: 0),
    TeamModel(name: "Єдиналітні Єноти", score: 0),
    TeamModel(name: "Запальні Зірки", score: 0),
    TeamModel(name: "Іскристі Індики", score: 0),
    TeamModel(name: "Крихітні Комети", score: 0),
    TeamModel(name: "Лунатичні Ліхтарі", score: 0),
    TeamModel(name: "Міцні Метеорити", score: 0),
    TeamModel(name: "Незламні Небожителі", score: 0),
    TeamModel(name: "Оптимістичні Орли", score: 0),
    TeamModel(name: "Полум'яні Персонажі", score: 0),
    TeamModel(name: "Радісні Ракети", score: 0),
    TeamModel(name: "Сяйливі Суперзірки", score: 0),
    TeamModel(name: "Талановиті Титани", score: 0),
    TeamModel(name: "Унікальні Уфологи", score: 0),
    TeamModel(name: "Фантастичні Феї", score: 0),
    TeamModel(name: "Хоробрі Химери", score: 0),
    TeamModel(name: "Цікаві Циклони", score: 0),
    TeamModel(name: "Чарівні Чаклуни", score: 0),
    TeamModel(name: "Шалені Шамани", score: 0),
    TeamModel(name: "Щасливі Щурі", score: 0),
    TeamModel(name: "Юні Юпітеряни", score: 0),
    TeamModel(name: "Яскраві Янголи", score: 0),
    TeamModel(name: "Неймовірні Німфи", score: 0),
    TeamModel(name: "Оптимістичні Октопуси", score: 0),
    TeamModel(name: "Полум'яні Піонери", score: 0),
    TeamModel(name: "Радісні Роботи", score: 0),
    TeamModel(name: "Сяйливі Супутники", score: 0),
    TeamModel(name: "Талановиті Торнадо", score: 0),
    TeamModel(name: "Унікальні Утопісти", score: 0),
    TeamModel(name: "Фантастичні Футуристи", score: 0),
    TeamModel(name: "Хоробрі Художники", score: 0),
    TeamModel(name: "Цікаві Циркачі", score: 0),
    TeamModel(name: "Чарівні Чародії", score: 0),
    TeamModel(name: "Шалені Шахраї", score: 0),
    TeamModel(name: "Щасливі Щури", score: 0),
    TeamModel(name: "Юні Юнголи", score: 0),
    TeamModel(name: "Яскраві Ястреби", score: 0),
    TeamModel(name: "Золоті Зорепади", score: 0),
    TeamModel(name: "Інтелектуальні Індіанці", score: 0),
    TeamModel(name: "Креативні Космонавти", score: 0),
    TeamModel(name: "Легендарні Леви", score: 0),
    TeamModel(name: "Мудрі Музиканти", score: 0),
]

let categoriesTMPEng: [CategoryModel] = [
    CategoryModel(name: "European countries", level: 0),
    CategoryModel(name: "Bad Habits", level: 0),
    CategoryModel(name: "Green fruits and vagitables", level: 0),
    CategoryModel(name: "Colors", level: 0),
    CategoryModel(name: "Superheroes", level: 5),
    CategoryModel(name: "Anime Series", level: 5),
    CategoryModel(name: "Computer Games", level: 5),
    CategoryModel(name: "Music Bands", level: 5),
    CategoryModel(name: "Fashion Brands", level: 5),
    CategoryModel(name: "Types of Dances", level: 5),
    CategoryModel(name: "Historical Events", level: 5),
    CategoryModel(name: "Famous Inventions", level: 5),
    CategoryModel(name: "Space Objects", level: 5),
    CategoryModel(name: "Mythical Creatures", level: 5),
    CategoryModel(name: "Famous Places of the World", level: 5),
    CategoryModel(name: "Famous Places of Europe", level: 5),
    CategoryModel(name: "Famous Places of Asia", level: 5),
    CategoryModel(name: "Famous Places of America", level: 5),
    CategoryModel(name: "Famous Places of Africa", level: 5),
    CategoryModel(name: "Famous Places of Australia", level: 5),
    CategoryModel(name: "Types of Sports", level: 5),
    CategoryModel(name: "Types of Art", level: 5),
    CategoryModel(name: "Types of Science", level: 5),
]

let categoriesTMPUa: [CategoryModel] = [
    CategoryModel(name: "Європейські країни", level: 0),
    CategoryModel(name: "Погані звички", level: 0),
    CategoryModel(name: "Зелені фрукти та овочі", level: 0),
    CategoryModel(name: "Кольори", level: 0),
    CategoryModel(name: "Живі організми в океані", level: 0),
    CategoryModel(name: "Види спорту", level: 0),
    CategoryModel(name: "Музичні інструменти", level: 0),
    CategoryModel(name: "Знамениті письменники", level: 0),
    CategoryModel(name: "Елементи автомобіля", level: 0),
    CategoryModel(name: "Види танців", level: 0),
    CategoryModel(name: "Космічні об'єкти", level: 0),
    CategoryModel(name: "Живі організми в джунглях", level: 0),
    CategoryModel(name: "Види тканин", level: 0),
    CategoryModel(name: "Знамениті актори", level: 0),
    CategoryModel(name: "Елементи комп'ютера", level: 0),
    CategoryModel(name: "Види меблів", level: 0),
    CategoryModel(name: "Живі організми в пустелі", level: 0),
    CategoryModel(name: "Види музики", level: 0),
    CategoryModel(name: "Знамениті спортсмени", level: 0),
    CategoryModel(name: "Елементи будинку", level: 0),
]

let challengingCategoriesUa: [CategoryModel] = [
    CategoryModel(name: "Формули в хімії", level: 10),
    CategoryModel(name: "Теорії в фізиці", level: 10),
    CategoryModel(name: "Види програмування", level: 10),
    CategoryModel(name: "Історичні події", level: 10),
    CategoryModel(name: "Види хмар", level: 10),
    CategoryModel(name: "Види математичних рівнянь", level: 10),
    CategoryModel(name: "Види алгоритмів", level: 10),
    CategoryModel(name: "Види архітектури", level: 10),
    CategoryModel(name: "Види музичних жанрів", level: 10),
    CategoryModel(name: "Види художніх стилів", level: 10),
    CategoryModel(name: "Види філософій", level: 10),
    CategoryModel(name: "Види психологічних теорій", level: 10),
    CategoryModel(name: "Види економічних систем", level: 10),
    CategoryModel(name: "Види політичних систем", level: 10),
    CategoryModel(name: "Види правових систем", level: 10),
    CategoryModel(name: "Види медичних спеціальностей", level: 10),
    CategoryModel(name: "Види біологічних класифікацій", level: 10),
    CategoryModel(name: "Види геологічних форм", level: 10),
    CategoryModel(name: "Види астрономічних об'єктів", level: 10),
    CategoryModel(name: "Види літературних жанрів", level: 10),
]

let diverseCategoriesUa: [CategoryModel] = [
    CategoryModel(name: "Транспорт", level: 5),
    CategoryModel(name: "Космічні програми", level: 5),
    CategoryModel(name: "Музичні інструменти", level: 5),
    CategoryModel(name: "Кулінарні страви", level: 5),
    CategoryModel(name: "Спортивне спорядження", level: 5),
    CategoryModel(name: "Тварини Африки", level: 5),
    CategoryModel(name: "Тварини Австралії", level: 5),
    CategoryModel(name: "Тварини Азії", level: 5),
    CategoryModel(name: "Тварини Америки", level: 5),
    CategoryModel(name: "Фільми про подорожі", level: 5),
    CategoryModel(name: "Книги про пригоди", level: 5),
    CategoryModel(name: "Відомі художники", level: 5),
    CategoryModel(name: "Відомі композитори", level: 5),
    CategoryModel(name: "Відомі письменники", level: 5),
    CategoryModel(name: "Відомі вчені", level: 5),
    CategoryModel(name: "Відомі спортсмени", level: 5),
    CategoryModel(name: "Відомі актори", level: 5),
    CategoryModel(name: "Відомі режисери", level: 5),
    CategoryModel(name: "Відомі музиканти", level: 5),
    CategoryModel(name: "Відомі політики", level: 5),
    CategoryModel(name: "Міста України", level: 5),
    CategoryModel(name: "Міста Європи", level: 5),
    CategoryModel(name: "Міста Азії", level: 5),
    CategoryModel(name: "Міста Америки", level: 5),
    CategoryModel(name: "Міста Африки", level: 5),
    CategoryModel(name: "Міста Австралії", level: 5),
    CategoryModel(name: "Видатні будівлі світу", level: 5),
    CategoryModel(name: "Видатні мости світу", level: 5),
    CategoryModel(name: "Видатні парки світу", level: 5),
    CategoryModel(name: "Супергерої", level: 5),
    CategoryModel(name: "Аніме серіали", level: 5),
    CategoryModel(name: "Комп'ютерні ігри", level: 5),
    CategoryModel(name: "Музичні гурти", level: 5),
    CategoryModel(name: "Модні бренди", level: 5),
    CategoryModel(name: "Види танців", level: 5),
    CategoryModel(name: "Історичні події", level: 5),
    CategoryModel(name: "Відомі винаходи", level: 5),
    CategoryModel(name: "Космічні об'єкти", level: 5),
    CategoryModel(name: "Міфічні істоти", level: 5),
]

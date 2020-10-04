import Foundation

/*
 1. Описать класс Car c общими свойствами автомобилей и пустым методом действия по аналогии с прошлым заданием.
 2. Описать пару его наследников trunkCar и sportСar. Подумать, какими отличительными свойствами обладают эти автомобили. Описать в каждом наследнике специфичные для него свойства.
 3. Взять из прошлого урока enum с действиями над автомобилем. Подумать, какие особенные действия имеет trunkCar, а какие – sportCar. Добавить эти действия в перечисление.
 4. В каждом подклассе переопределить метод действия с автомобилем в соответствии с его классом.
 5. Создать несколько объектов каждого класса. Применить к ним различные действия.
 6. Вывести значения свойств экземпляров в консоль.
 */

enum EngineState : String {
    case running = "Работает"
    case stopped = "Заглушен"
}
enum WindowState : String  {
    case opened = "Открыты"
    case closed = "Закрыты"
}

class Car {
    
    var model: String = ""
    var releaseYear: Int = 0
    var trunkVolume : Int = 0
    var speed : Int = 0
    var engineState: EngineState = .stopped
    var windowState: WindowState = .closed
    
    init(model: String, releaseYear: Int, trunkVolume: Int) {
        self.model = model
        self.releaseYear = releaseYear
        self.trunkVolume = trunkVolume
    }
    
    func doingWithEngine(do engineState: EngineState) {
        self.engineState = engineState
    }
    func doingWithWindows(do windowState: WindowState) {
        self.windowState = windowState
    }
    func carState() {
        print("\nТекущее состояние авто: ")
        print("Марка авто: \(self.model)")
        print("Год выпуска: \(self.releaseYear)")
        print("Состояние двигателя: \(self.engineState.rawValue)")
        print("Состояние окон: \(self.windowState.rawValue)")
        print("Текущая скорость: \(self.speed)\n")
    }
    func projection() {
        
    }
    
}

class SportCar : Car {
    // !!!!!!!!!!!!!!!!!!!!! Посмотрите пожалуйста в класс trunkCar - есть вопросы

    var spoiler : Bool
    override var engineState: EngineState {
        willSet {
            if newValue == .running {
                print("Мотор запускается")
            } else {
                print("Мотор останавливается")
            }
        }
        didSet {
            if oldValue == .stopped {
                print("Мотор в работе")
            } else {
                print("Мотор остановлен")
            }
        }
    }
    override var windowState: WindowState {
        willSet {
            if newValue == .opened {
                print("Окно открывается")
            } else {
                print("Окно закрывается")
            }
        }
        didSet {
            if oldValue == .closed {
                print("Окно открыто")
            } else {
                print("Окно закрыто")
            }
        }
    }
    
    init(model: String, releaseYear: Int, trunkVolume: Int, spoiler: Bool) {
        self.spoiler = spoiler
        super.init(model: model, releaseYear: releaseYear, trunkVolume: trunkVolume)
    }
    
    override func carState() {
        print("\nТекущее состояние авто: ")
        print("Марка авто: \(self.model)")
        print("Год выпуска: \(self.releaseYear)")
        print("Состояние двигателя: \(self.engineState.rawValue)")
        print("Состояние окон: \(self.windowState.rawValue)")
        print("Текущая скорость: \(self.speed)")
        print("Спойлер \(self.spoiler == true ? "выдвинут" : "не в работе")\n")
    }
    
    override func projection() {
        print("Проекция активирована, выведена текущая скорость - \(speed) кмч")
    }
    
    func usingSpoiler() {
        spoiler ? print("Спойлер выдвинулся, можем ускоряться дальше") : print("Спойлера нет, дальше не ускоряемся, а то взлетим")
    }
}

class TrunkCar : Car {
    var track : Bool
    // FIXME : #1 - как не копировать эти блоки кода с willSet и didSet? в супер классе нужно инициализировать, так делать не дает, выглядит не очень:)
    override var engineState: EngineState {
        willSet {
            if newValue == .running {
                print("Мотор запускается")
            } else {
                print("Мотор останавливается")
            }
        }
        didSet {
            if oldValue == .stopped {
                print("Мотор в работе")
            } else {
                print("Мотор остановлен")
            }
        }
    }
    override var windowState: WindowState {
        willSet {
            if newValue == .opened {
                print("Окно открывается")
            } else {
                print("Окно закрывается")
            }
        }
        didSet {
            if oldValue == .closed {
                print("Окно открыто")
            } else {
                print("Окно закрыто")
            }
        }
    }
    init(model: String, releaseYear: Int, trunkVolume: Int, track: Bool) {
        // FIXME : #2 - self.track = track Почему если эту строку поставить после super.init возникает ошибка? В классе выше то же самое
        self.track = track
        super.init(model: model, releaseYear: releaseYear, trunkVolume: trunkVolume)
    }
    
    override func carState() {
        print("\nТекущее состояние авто: ")
        print("Марка авто: \(self.model)")
        print("Год выпуска: \(self.releaseYear)")
        print("Состояние двигателя: \(self.engineState.rawValue)")
        print("Состояние окон: \(self.windowState.rawValue)")
        print("Текущая скорость: \(self.speed)")
        print("Прицеп: \(self.track == true ? "есть прицеп" : "нет прицепа")\n")
    }
    override func projection() {
        print("Проекция активирована, текущее местоположние и навигатор прямо перед тобой")
    }
}

var lambo = SportCar(model: "lamborgini", releaseYear: 2019, trunkVolume: 10, spoiler: true)

lambo.carState()
lambo.doingWithEngine(do: .running)
lambo.speed = 200
lambo.projection()
lambo.usingSpoiler()
lambo.carState()

print("\n-----Грузовик-----\n")

var scania = TrunkCar(model: "Scania", releaseYear: 2009, trunkVolume: 1000, track: true)

scania.carState()
scania.doingWithEngine(do: .running)
scania.speed = 90
scania.projection()
scania.carState()

import UIKit

/* дз 5
 1. Создать протокол «Car» и описать свойства, общие для автомобилей, а также метод действия.
 2. Создать расширения для протокола «Car» и реализовать в них методы конкретных действий с автомобилем: открыть/закрыть окно, запустить/заглушить двигатель и т.д. (по одному методу на действие, реализовывать следует только те действия, реализация которых общая для всех автомобилей).
 3. Создать два класса, имплементирующих протокол «Car» - trunkCar и sportСar. Описать в них свойства, отличающиеся для спортивного автомобиля и цистерны.
 4. Для каждого класса написать расширение, имплементирующее протокол CustomStringConvertible.
 5. Создать несколько объектов каждого класса. Применить к ним различные действия.
 6. Вывести сами объекты в консоль.
 */


// !!!!!!!!!!!!!!
/// На самом деле, что-то не понял прикола на самом деле с раширениями, все равно куча копипастного кода. Идеология наследования суперКласса выглядит как-то опрятней и понятней
/// Понимаю что это разные подходы, но дайте совет пожалуйста, можно ли протоколами делать так же как с наследованиями классов? одинаковые вещи определил в нем, и дальше уже внутри классов - наследников определяешь какие-то штуки конкретно их. Подскажите еще заданий пожалуйста, для тренировок - просить проверять не буду, хочу натренироваться,и понять разность подходов. Спасибо
// !!!!!!!!!!!!!!

enum EngineState : String {
    case running = "Работает"
    case stopped = "Заглушен"
}
enum WindowState : String  {
    case opened = "Открыты"
    case closed = "Закрыты"
}

protocol Car: AnyObject {
    
    var model: String { get set }
    var releaseYear: Int { get set }
    var trunkVolume : Int { get set }
    var speed : Int { get set }
    var engineState: EngineState { get set }
    var windowState: WindowState { get set }
    
    func doingWithEngine(do engineState: EngineState)
    func doingWithWindows(do windowState: WindowState)
}

extension Car {
    
    func doingWithEngine(do engineState: EngineState) {
        self.engineState = engineState
    }
    func doingWithWindows(do windowState: WindowState) {
        self.windowState = windowState
    }
}

class SportCar : Car {
    
    var model: String
    var releaseYear: Int
    var trunkVolume: Int
    var speed: Int
    var spoiler : Bool
    // так и не разобрался, как реализовать наблюдатели вне классов. Именно чтобы не писать свой метод, а сделать прям с willSet и didSet. В расширения их тоже нельзя запихать.
    var engineState: EngineState {
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
    var windowState: WindowState {
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
    
    init(model: String,
         releaseYear: Int,
         trunkVolume: Int,
         speed: Int,
         engineState: EngineState,
         windowState: WindowState,
         spoiler : Bool) {
        
        self.model = model
        self.releaseYear = releaseYear
        self.trunkVolume = trunkVolume
        self.speed = speed
        self.engineState = engineState
        self.windowState = windowState
        self.spoiler = spoiler
        
    }
    convenience init (model: String, releaseYear: Int, trunkVolume: Int, spoiler: Bool) {
        self.init(model: model,
                  releaseYear: releaseYear,
                  trunkVolume: trunkVolume,
                  speed : 0,
                  engineState: .stopped,
                  windowState: .closed,
                  spoiler: spoiler)
    }
    
    func usingSpoiler() {
        spoiler ? print("Спойлер выдвинулся, можем ускоряться дальше") : print("Спойлера нет, дальше не ускоряемся, а то взлетим")
    }
}

extension SportCar: CustomStringConvertible {
    var description: String {
        return """
                \nТекущее состояние авто:
                Марка авто: \(self.model)
                Год выпуска: \(self.releaseYear)
                Состояние двигателя: \(self.engineState.rawValue)
                Состояние окон: \(self.windowState.rawValue)
                Текущая скорость: \(self.speed)
                Спойлер \(self.spoiler == true ? "выдвинут" : "не в работе")\n
                """
    }
}


class TrunkCar: Car {
    var model: String
    var releaseYear: Int
    var trunkVolume: Int
    var speed: Int
    var track : Bool
    var engineState: EngineState {
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
    var windowState: WindowState {
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
    init(model: String,
         releaseYear: Int,
         trunkVolume: Int,
         speed: Int,
         engineState: EngineState,
         windowState: WindowState,
         track : Bool) {
        
        self.model = model
        self.releaseYear = releaseYear
        self.trunkVolume = trunkVolume
        self.speed = speed
        self.engineState = engineState
        self.windowState = windowState
        self.track = track
        
    }
    convenience init (model: String, releaseYear: Int, trunkVolume: Int, track: Bool) {
        self.init(model: model,
                  releaseYear: releaseYear,
                  trunkVolume: trunkVolume,
                  speed : 0,
                  engineState: .stopped,
                  windowState: .closed,
                  track: track)
    }
    
}

extension TrunkCar: CustomStringConvertible {
    var description: String {
        return """
                \nТекущее состояние авто:
                Марка авто: \(self.model)
                Год выпуска: \(self.releaseYear)
                Состояние двигателя: \(self.engineState.rawValue)
                Состояние окон: \(self.windowState.rawValue)
                Текущая скорость: \(self.speed)
                Прицеп: \(self.track == true ? "есть прицеп" : "нет прицепа")\n
                """
    }
}


var lambo = SportCar(model: "lamborgini", releaseYear: 2019, trunkVolume: 10, spoiler: true)

print(lambo.description)
lambo.doingWithEngine(do: .running)
lambo.speed = 200
lambo.usingSpoiler()
print(lambo.description)

print("\n-----Грузовик-----\n")

var scania = TrunkCar(model: "Scania", releaseYear: 2009, trunkVolume: 1000, track: true)

print(scania.description)
scania.doingWithEngine(do: .running)
scania.speed = 90
print(scania.description)


import Foundation

/*
 1. Описать несколько структур – любой легковой автомобиль SportCar и любой грузовик TrunkCar.
 2. Описать в каждом наследнике специфичные для него свойства.Структуры должны содержать марку авто, год выпуска, объем багажника/кузова, запущен ли двигатель, открыты ли окна, заполненный объем багажника. (Указать как сходие свойства структур, так и отличные для каждого вида авто. Можно добавить свои любые)
 3. Описать перечисление с возможными действиями с автомобилем: запустить/заглушить двигатель, открыть/закрыть окна, погрузить/выгрузить из кузова/багажника груз определенного объема. (Использовать свой тип enum по возможности, а не использовать тип Bool)
 4. Добавить в структуры метод с одним аргументом типа перечисления, который будет менять свойства структуры в зависимости от действия. (Написать такой метод, в который можно передать состояние чего-либо, например двигателя. И состояние двигателя структуры поменяется на переданное значение)
 5. Инициализировать несколько экземпляров структур. Применить к ним различные действия.
 6. Вывести значения свойств экземпляров в консоль.
 */
// можно было сделать лучше, но не успел
enum EngineState : String {
    case running = "Работает"
    case stopped = "Заглушен"
}
enum WindowState : String  {
    case opened = "Открыты"
    case closed = "Закрыты"
}
enum TrunkState { // не успел реализовать этот функционал с проверкой на заполнение багажника. Идея была сделать метод - загрузка, в котором проверялось бы значение которое нужно загрузить, с переменной trunkVolume и выдавалосб сообщение ОК или не ОК.
    case loaded
    case empty
}

protocol IAnyCar {
    var model: String { get set }
    var releaseYear: Int { get set }
    var trunkVolume: Int { get set } // объем багажника в литрах
    var engineState: EngineState { get set }
    var windowState: WindowState { get set }

    mutating func doingWithEngine(do engineState: EngineState)
    mutating func doingWithWindows(do windowState: WindowState)

}

struct Car : IAnyCar {
    
    var model: String
    var releaseYear: Int
    var trunkVolume: Int
    
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
    
    mutating func doingWithEngine(do engineState: EngineState) {
        self.engineState = engineState
    }
    
    mutating func doingWithWindows(do windowState: WindowState) {
        self.windowState = windowState
    }
    func carState() {
        print("\nТекущее состояние авто: ")
        print("Марка авто: \(self.model)")
        print("Год выпуска: \(self.releaseYear)")
        print("Объем багажника: \(self.trunkVolume)")
        print("Состояние двигателя: \(self.engineState.rawValue)")
        print("Состояние окон: \(self.windowState.rawValue)")
    }
    
    init(model: String, releaseYear: Int, trunkVolume: Int, engineState: EngineState, windowState: WindowState) {
        self.model = model
        self.releaseYear = releaseYear
        self.trunkVolume = trunkVolume
        self.engineState = engineState
        self.windowState = windowState
    }
}
struct TrunkCar : IAnyCar {
    var model: String
    var releaseYear: Int
    var trunkVolume: Int
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
    var track : Bool
    
    mutating func doingWithEngine(do engineState: EngineState) {
        self.engineState = engineState
    }
    mutating func doingWithWindows(do windowState: WindowState) {
        self.windowState = windowState
    }

    init(model: String, releaseYear: Int, trunkVolume: Int, engineState: EngineState, windowState: WindowState, track: Bool) {
        self.model = model
        self.releaseYear = releaseYear
        self.trunkVolume = trunkVolume
        self.engineState = engineState
        self.windowState = windowState
        self.track = track
    }
    func carState() {
        print("\nТекущее состояние авто: ")
        print("Марка авто: \(self.model)")
        print("Год выпуска: \(self.releaseYear)")
        print("Объем багажника: \(self.trunkVolume)")
        print("Состояние двигателя: \(self.engineState)")
        print("Состояние окон: \(self.windowState)")
        print("Прицеп: \(self.track == true ? "есть прицеп" : "нет прицепа")")

    }
}
print("Спорткар\n")
var lamborgini = Car(model: "lamborgini", releaseYear: 2020, trunkVolume: 10, engineState: .stopped, windowState: .opened)
lamborgini.carState()
lamborgini.doingWithEngine(do: .running)
lamborgini.carState()
// не понял как пользоваться rawvalue - где этот метод должен вызываться, чтобы показать значение??
print("\nГрузовик\n")
var kamaz = TrunkCar(model: "Kamaz", releaseYear: 1993, trunkVolume: 1000, engineState: .running, windowState: .closed, track: true)
kamaz.carState()


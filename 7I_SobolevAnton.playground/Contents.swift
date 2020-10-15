import Foundation

/*
 1. Придумать класс, методы которого могут завершаться неудачей и возвращать либо значение, либо ошибку Error?. Реализовать их вызов и обработать результат метода при помощи конструкции if let, или guard let.
 2. Придумать класс, методы которого могут выбрасывать ошибки. Реализуйте несколько throws-функций. Вызовите их и обработайте результат вызова при помощи конструкции try/catch.
 */

enum CarError: Error {
    
    case extraFuel
    case lowBattery
    case motorRunning
    case inDriving
    
    var errorDescription: String {
        switch self {
        case .extraFuel:
            return "Нельзя заправить больше топлива, чем влезает в бак!"
        case .lowBattery:
            return "Аккумулятор разряжен"
        case .motorRunning:
            return "Заглушите двигатель"
        case .inDriving:
            return "Мы в движении, заглушить нельзя. Сначала остановитесь"
        }
    }
}

enum EngineControl {
    case run
    case stop
}

class Car {
    
    // MARK: - Public Properties
    
    private var engineState: EngineControl = .stop
    var batteryCharging: Bool = true
    var speed: Int = 0
    var tunk = (currentLevel: 10, tunkVolume: 50)
    
    // MARK: - Public Methods
    
    func startEngine(doWithEngine engineState: EngineControl) -> (String?, CarError?) {
        switch engineState {
        case .run:
            guard batteryCharging else { return (nil, CarError.lowBattery) }
            guard engineState == .run else { return (nil, CarError.motorRunning) }
            self.engineState = .run
            return ("Двигатель запущен, можем ехать", nil)
        case .stop:
            guard speed == 0 else { return (nil, CarError.inDriving) }
            self.engineState = .stop
            return ("Двигатель остановлен", nil)
        }
    }
    
    func doRefueling(liters volume: Int) throws -> (Int, Int) {
        
        guard volume > tunk.tunkVolume || (volume + tunk.currentLevel) > tunk.tunkVolume else { throw CarError.extraFuel }
        guard self.engineState == .run else { throw CarError.motorRunning }
        tunk.currentLevel += volume

        // возвращаем текущий уровень топлива
        return tunk
    }
    
}
var car = Car()
car.startEngine(doWithEngine: .run)
car.speed = 60
car.startEngine(doWithEngine: .stop)
car.speed = 0
car.startEngine(doWithEngine: .stop)
car.batteryCharging = false
car.startEngine(doWithEngine: .run)



do {
    let refuel = try car.doRefueling(liters: 60)
    print("Заправили машину до \(refuel.0)")
} catch CarError.motorRunning {
    print("Нужно заглушить машину")
} catch CarError.extraFuel {
    print("Можно заправить только \(car.tunk.tunkVolume - car.tunk.currentLevel)")
} catch let error {
    print(error)
}


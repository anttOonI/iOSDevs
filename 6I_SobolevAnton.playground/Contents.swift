import Foundation

/* ДЗ 6
 1. Реализовать свой тип коллекции «очередь» (queue) c использованием дженериков.
 2. Добавить ему несколько методов высшего порядка, полезных для этой коллекции (пример: filter для массивов)
 3. * Добавить свой subscript, который будет возвращать nil в случае обращения к несуществующему индексу.
 */

//
class Men {
    
    // MARK: - Public Properties
    
    var name: String
    var height: Int

    // MARK: - Initializers
    
    init(name: String, height: Int) {
        self.name = name
        self.height = height
    }
}

class Women {
    
    // MARK: - Public Properties
    
    var name: String
    var height: Int
    var heel: Bool

    // MARK: - Initializers
    
    init(name: String, height: Int, heel: Bool) {
        self.name = name
        self.height = height
        self.heel = heel
        if self.heel {
            self.height += 5
        }
    }
}

enum People {
    case men(Men)
    case women(Women)
}

struct Queue<T> {
    
    // MARK: - Public Properties
    
    var elements: [T] = []
    
    // MARK: - Public Methods

    mutating func enqueue(_ element: T) {
        elements.append(element)
    }
    mutating func dequeue() -> T? {
        guard !elements.isEmpty else { return nil }
        return elements.removeFirst()
    }
    mutating func filter(_ heightClouser: (T) -> Bool) -> [T] {
        var tempArray = [T]()
        for element in elements {
            if heightClouser(element) {
                tempArray.append(element)
            }
        }
        elements = tempArray
        return elements
    }
    
    // MARK: - Subscripts !!! куда относятся сабскрипты, когда делаешь МАРК ?
    
    subscript (index: Int) -> T? {
        guard index > 0 && index < elements.count else { return nil }
        return elements[index]
    }
}

var queue = Queue<Men>()
var queue2 = Queue<Women>()
var queue3 = Queue<People>()

queue.enqueue(Men(name: "man1", height: 160))
queue.enqueue(Men(name: "man2", height: 154))
queue.enqueue(Men(name: "man3", height: 178))
queue.enqueue(Men(name: "man4", height: 180))

// вот отрабатывает subscript
queue[-5]
print(queue.elements[0].name)
//выводим сколько мужчин в очереди
print(queue.elements.count)
// фильтруем по росту
queue.filter({$0.height > 166})
print(queue.elements.count)

queue2.enqueue(Women(name: "woman1", height: 161, heel: false))
queue2.enqueue(Women(name: "woman2", height: 169, heel: true))
queue2.enqueue(Women(name: "woman3", height: 175, heel: true))
queue2.enqueue(Women(name: "woman4", height: 171, heel: false))


queue3.enqueue(.men(Men(name: "man1", height: 178)))
queue3.enqueue(.men(Men(name: "man2", height: 181)))
queue3.enqueue(.women(Women(name: "women1", height: 165, heel: true)))
queue3.enqueue(.men(Men(name: "man3", height: 179)))
queue3.enqueue(.women(Women(name: "women2", height: 168, heel: false)))

//!!!!!!!!! не понял как добраться до свойств объектов,которые положил в очеред queue3 через enum - подскажите
//queue3[2].  -  а как дальше то найти объект?)) и соответственно потом отфильтровать. Тут хотел отфильтровать по объектам, надо будет делать через as? - ?

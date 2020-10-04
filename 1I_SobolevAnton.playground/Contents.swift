import Foundation

// 1. Решить квадратное уравнение вида 𝑎𝑥2+𝑏𝑥+𝑐=0
// Где a, b, c - коэффициенты, а x - неизвестное
print ("1. Решить квадратное уравнение вида 𝑎𝑥2+𝑏𝑥+𝑐=0\n")
//Ввести свои значения для a, b и c сюда ----> ↓  ↓  ↓
var koef: (a: Double, b: Double, c: Double) = (3, 4, 0), answer: (x1: Double, x2: Double)
var diskriminant = pow(koef.b,2) - 4*koef.a*koef.c

if koef.a==0 {
    print("Введите другой коэффициент а, т.к. он не должен быть равен 0!!")
}
if diskriminant>0 && koef.a != 0 {
    answer.x1 = (-koef.b + sqrt(diskriminant))/(2*koef.a)
    answer.x2 = (-koef.b - sqrt(diskriminant))/(2*koef.a)
    print("Решение уравнение вида \(koef.a)xˆ2+\(koef.b)x+\(koef.c) - \nx1 = \(answer.x1) \nx2 = \(answer.x2) ")
}
else if diskriminant<0 {
    print("Дискриминант меньше нуля: D=\(diskriminant). Корней на множестве действительных чисел нет. Введите другие коэффициенты a, b и c!")
}
else if diskriminant==0 && koef.a != 0 {
    answer.x1 = -koef.b/(2*koef.a)
    answer.x2=answer.x1
    print("Решение уравнение вида \(koef.a)xˆ2+\(koef.b)x+\(koef.c) - \nx1 = x2 = \(answer.x1) ")
}

//---------------------------------------------------------------------------------------------
print("--------------------------------")
//2. Даны катеты прямоугольного треугольника. Найти площадь, периметр и гипотенузу треугольника.
// S = a*b/2, где a и b - катеты.
// P = a+b+c, где a и b - катеты, c - гипотенуза
// c = sqrt(aˆ2+bˆ2) - теорема Пифагора
print ("1. Найти площадь, периметр и гипотенузу прямоугольного треугольника\n")
var sides: (a: Double, b: Double, c: Double ), S: (Double), P: (Double)
//Ввести свои значения для a и b
sides.a = 4
sides.b = 6
sides.c = sqrt(pow(sides.a, 2)+pow(sides.b, 2))
S = sides.a*sides.b/2
P = sides.a + sides.b + sides.c
print("Гипотенуза = \((round(100*sides.c))/100)\nПлощадь треугольника S = \(round(100*S)/100)\nПериметор прямоугольника P = \(round(100*P)/100)")

//---------------------------------------------------------------------------------------------
print("--------------------------------")
//3. * Пользователь вводит сумму вклада в банк и годовой процент. Найти сумму вклада через 5 лет.
// Сюда введите сумму вклада ---- ↓
var initialDeposit: (Double) = 1, deposit = initialDeposit
var percent:(Double) = 15       // <---- Сюда введите процент по вкладу
var yearsOfDeposit = 50         // <---- Сюда введите длительность вклада (по умолчанию 5 лет)
print("Ваш вклад \(initialDeposit)")
for i in (1...yearsOfDeposit) {
    deposit+=deposit*percent/100
    print("Сумма вклада после \(i)-го года: \(round(10*deposit)/10)")
}
print("Итого депозит увеличился на \(round(10*(deposit-initialDeposit))/10)\n")

// 2 способ------------------------------------
print("Сумма вклада через 5 лет = \(initialDeposit*(pow((1+(percent/100)),Double(yearsOfDeposit))))")

// 3 способ-------------------------------------
func Invest (deposit: Double, percent: Double,yearsOfDeposit:Int)->Double {
    var dep = deposit
    if yearsOfDeposit<1{
        return deposit
    }
    dep+=dep*percent/100
    return Invest(deposit: dep, percent: percent, yearsOfDeposit: yearsOfDeposit-1)
}
print("Вклад размером \(initialDeposit) под \(percent)% на \(yearsOfDeposit) лет вырастет до \(round(10*Invest(deposit: initialDeposit, percent: percent, yearsOfDeposit: yearsOfDeposit))/10)")

print("\n---------------------Конец домашней работы 1----------------------------\n")

// MARK: Домашняя работа №2
print("\n---------------------Домашняя работа 2----------------------------\n")

/*
 Написать функцию, которая определяет, четное число или нет.
 Написать функцию, которая определяет, делится ли число без остатка на 3.
 Создать возрастающий массив из 100 чисел.
 Удалить из этого массива все четные числа и все числа, которые не делятся на 3.
 * Написать функцию, которая добавляет в массив новое число Фибоначчи, и добавить при помощи нее 50 элементов.
 Числа Фибоначчи определяются соотношениями Fn=Fn-1 + Fn-2.
 * Заполнить массив элементов различными простыми числами. Натуральное число, большее единицы, называется простым, если оно делится только на себя и на единицу. Для нахождения всех простых чисел не больше заданного числа n (пусть будет 100), следуя методу Эратосфена, нужно выполнить следующие шаги:
 a. Выписать подряд все целые числа от двух до n (2, 3, 4, ..., n).
 b. Пусть переменная p изначально равна двум — первому простому числу.
 c. Зачеркнуть в списке числа от 2 + p до n, считая шагом p.
 d. Найти первое не зачёркнутое число в списке, большее, чем p, и присвоить значению переменной p это число.
 e. Повторять шаги c и d, пока возможно.

 */
// кастомный мод оператор
func % (lhs: Decimal, rhs: Decimal) -> Decimal {
    precondition(lhs > 0 && rhs > 0)
    if lhs < rhs {
        return lhs
    } else if lhs == rhs {
        return 0
    }
    var quotient = lhs / rhs
    var rounded = Decimal()
    NSDecimalRound(&rounded, &quotient, 0, .down)

    return lhs - (rounded * rhs)
}

// 1.  Написать функцию, которая определяет, четное число или нет.
func CheckEvenNum(_ number: Int) -> Bool {
    if number % 2 == 0 {
        return true
    } else {
        return false
    }
}
// 2.  Написать функцию, которая определяет, делится ли число без остатка на 3.
func CheckNumDivByThree(_ number: Int) -> Bool {
    if number % 3 == 0 {
        return true
    } else {
        return false
    }
}
// 3.  Создать возрастающий массив из 100 чисел.
var incrArray = Array(1...100)
var incrArray1 = Array(1...100)
var incrArray2 = Array(1...100)


//  Удалить из этого массива все четные числа и все числа, которые не делятся на 3.
print("Массив \(incrArray) без четных чисел, и тех, которые не делятся на 3 через способ 1 -> ")
for i in incrArray {
    if (CheckEvenNum(i) != false || CheckNumDivByThree(i) == false) {
        incrArray.remove(at: incrArray.firstIndex(of: i)!)
    }
}
print("----> \(incrArray)\n")

// Способ 2
func CheckNumber(_ initArray: inout [Int], _ checkFunc: (Int) -> Bool) -> [Int] {
    for (index, value) in  initArray.enumerated() {
        if checkFunc(value) {
            initArray[index] = 0
        }
    }
    initArray.removeAll(where: {$0 == 0})
    return initArray
}
CheckNumber(&incrArray1, {i in (i % 2 == 0 || i % 3 != 0)})
print("Массив из чисел после фильрации - способ 2 -> \(incrArray1)\n")

// Способ 3
incrArray2.removeAll(where: {$0 % 2 == 0 || $0 % 3 != 0})
print("Массив из чисел после фильрации - способ 3 -> \(incrArray2)")
//-----------------------------------------------------------------------------------------

/* Задание 5
 * Написать функцию, которая добавляет в массив новое число Фибоначчи, и добавить при помощи нее 50 элементов.
 Числа Фибоначчи определяются соотношениями Fn=Fn-1 + Fn-2.
 */
// Можно было сделать еще через рекурсию,но это неэффективно. Слишком много ресурсов потребляет
// Еще как вариант можно использовать двунаправленную последовательность, т.е начать с отрицательных,тогда даже в Int залезет

print("\n----------------------------------------------------------------------------\n")
print("Задание 5. Функция Фибоначчи: \n")

/// Функция Фибоначчи, релизующая заполнение массива заданным количество элементов типа Double
func Fibonacci1(_ countOfSeq: Int) -> [Double] {
    var fibArray: [Double] = [0, 1]
    while fibArray.count <= countOfSeq {
        fibArray.append(fibArray[fibArray.count - 1] + fibArray[fibArray.count - 2])
    }
    return fibArray
}
// Сюда введи количество чисел в ряду --------------------------- ↓
print ("Массив с числами Фибоначчи, заданной длины - \(Fibonacci1(100))\n")

// Способ 2 - похожий, но использую кастомный мод оператор
/// Функция Фибоначчи, релизующая заполнение массива заданным количество элементов
func Fibonacci2(_ countOfSeq: Int) -> [Decimal] {
    var fibArray: [Decimal] = [0, 1]
    while fibArray.count <= countOfSeq {
        var prevOne = fibArray[fibArray.count - 1]
        var prevTwo = fibArray[fibArray.count - 2]
        fibArray.append(prevOne + prevTwo)
    }
    return fibArray
}
// Сюда введи количество чисел в ряду --------------------------- ↓
print ("Массив с числами Фибоначчи, заданной длины - \(Fibonacci2(100))")
//-----------------------------------------------------------------------------------------
print("\n----------------------------------------------------------------------------\n")
print("Задание 6. Простые числа \n")

/*
 6. * Заполнить массив из 100 элементов различными простыми числами. Натуральное число, большее единицы, называется простым, если оно делится только на себя и на единицу. Для нахождения всех простых чисел не больше заданного числа n, следуя методу Эратосфена, нужно выполнить следующие шаги:
 a. Выписать подряд все целые числа от двух до n (2, 3, 4, ..., n).
 b. Пусть переменная p изначально равна двум — первому простому числу.
 c. Зачеркнуть в списке числа от 2 + p до n, считая шагом p..
 d. Найти первое не зачёркнутое число в списке, большее, чем p, и присвоить значению переменной p это число.
 e. Повторять шаги c и d, пока возможно.
 */

// !насколько я понял, решето Эратосфена определяет простые числа именно на множестве. Поэтому чтобы заполнить массив ста простыми числами,
//                                                                                     нужно подбирать изначальное множество. Вроде это 545

let endOfWholeNumbers = 355
var wholeNumbers = Array(0...endOfWholeNumbers-1)
wholeNumbers [1] = 0
var p = 2
var finalArray = [Int]()
var countOfPrimeNum = 0
for p in wholeNumbers {
    if p != 0 {
        var j = p * p
        while j < endOfWholeNumbers {
            wholeNumbers[j] = 0
            j += p
        }
    }
}
wholeNumbers.removeAll(where: {$0 == 0})
print("\n\(wholeNumbers) - а размер = \(wholeNumbers.count)\n")

// Способ 2 - не могу понять где ошибка,постоянно вылетает - может подскажете?
func Ferma(_ n: Int) -> Bool {
    var i = 0
    while i < 100 {
        let a = Int.random(in: 2...n-2)
        var temp = Decimal(string: "\(pow(Double(a), Double(n-1)))")!
        print(temp)
        if (temp % Decimal(n) == 1) {
//            return "Число простое"
            return true
        }
        i += 1
    }
//    return "Число составное"
    return false
}

// тут закомментил,что не работат - формирую массив из простых чисел, но чет вылетает)
//let endOfWholeNumbers2 = 15
//var wholeNumbers2 = Array(0...endOfWholeNumbers2-1)
//var temp = [Int]()
//for i in wholeNumbers2 {
//    if Ferma(i) {
//        temp.append(i)
//    }
//}
//print(temp)


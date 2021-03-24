//
//  main.swift
//  HomeTaskLesson06
//
//  Created by Антон Оборин on 24.03.2021.
//

import Foundation
/*
1. Реализовать свой тип коллекции «очередь» (queue) c использованием дженериков.
2. Добавить ему несколько методов высшего порядка, полезных для этой коллекции (пример: filter для массивов)
3. * Добавить свой subscript, который будет возвращать nil в случае обращения к несуществующему индексу.
*/

//Для задания используем код из предыдущей работы. Добавил в протокол свойство totalWeightOfCar, для подсчета общей снаряженной массы и предусмотрел вывод информации Создадим два гаража, для спортивных автмоболей и для грузовых, в виде дженериков, в дженерике предусмотрим подсчет общего веса всех автомобилей стоящих в гараже. Сабскриптом сможем выводить общий вес определенных автомобилей либо одного по индексу.


//Описываем марки автомобилей
enum CarMark {
   case ford, mercedes, volkswagen, volvo
}

// общие перечисления действий для всех авто
// Описываем статус двигателя

enum EngineState {
   case start, stop
}

// Описываем статус открытия окон

enum WindowsState {
   case open, close
}

protocol Carable: class {
var mark: CarMark { get }
var year: Int { get }
var markString: String {get set}
var engineState: EngineState {get set}
var windowsState: WindowsState {get set}
var trunkVolume: Int {get set}
var maxTrunkVolume: Int {get set}
var totalWeightOfCar: Int { get set }
    
    func startEngine()
    
    func stopEngine()
    
    func openWindows()
    
    func closeWindows()
    
    func printVolState()
}

extension Carable {
    func startEngine() {
        engineState = .start
    }
    
    func stopEngine() {
        self.engineState = .stop
    }
    
    func openWindows() {
        self.windowsState = .open
    }
    
    func closeWindows() {
        self.windowsState = .close
    }
    
    func printVolState() {
        print("В багажнике \(trunkVolume) кг")
    }
}

//Имплементируем классу SportCar протокол Carable

class SportCar: Carable {
    
    // для спорткара делаем откидную крышу

    enum RoofState {
        case open, close
    }
    
    var mark: CarMark
    var markString: String
    var year: Int
    var engineState: EngineState = .stop {
    didSet {
        if oldValue == .start {
            print("Двигатель заглушен")
        } else {
            print("Двигатель запущен")
        }
    }
    }
    var windowsState: WindowsState = .close {
    didSet {
        if oldValue == .open {
            print("Окна закрыты")
        } else {
            print("Окна открыты")
        }
    }
    }
    var trunkVolume: Int = 0
    var maxTrunkVolume: Int = 0
    var totalWeightOfCar: Int
    var roofState: RoofState = .close {
        willSet {
            if newValue == .open {
                print("Складываем крышу в багажник")
            } else {
                print("Раскладываем крышу")
            }
        }
    }
    
    init (markName: CarMark, roof: RoofState){
        self.mark = markName
        self.roofState = roof
        switch markName {
        case .ford:
            self.maxTrunkVolume = 0
            self.year = 1999
            self.trunkVolume = 0
            self.totalWeightOfCar = 800
            self.markString = "Ford"
        case .mercedes:
            self.maxTrunkVolume = 0
            self.year = 2001
            self.trunkVolume = 0
            self.totalWeightOfCar = 1000
            self.markString = "Mercedes"
        case .volkswagen:
            self.maxTrunkVolume = 0
            self.year = 2010
            self.trunkVolume = 0
            self.totalWeightOfCar = 900
            self.markString = "Volkswagen"
        case .volvo:
            self.maxTrunkVolume = 0
            self.year = 2020
            self.trunkVolume = 0
            self.totalWeightOfCar = 1200
            self.markString = "Volvo"
        }
    }
    
    func openRoof() {
        self.roofState = .open
    }
    
    func closeRoof() {
        self.roofState = .close
    }
    
}

//Проверка инициализации спорткара
//var car2 = SportCar(markName: .mercedes, roof: .open)
//car2.startEngine()
//print(car2)





//Имплементируем классу TrunkCar протокол Carable
class TrunkCar: Carable {
    
    //для грузового авто будет прицеп

    enum TrunkBox {
       case withTrailer, withoutTrailer
    }
    
    var mark: CarMark
    var markString: String
    var year: Int
    var engineState: EngineState = .stop {
    didSet {
        if oldValue == .start {
            print("Двигатель заглушен")
        } else {
            print("Двигатель запущен")
        }
    }
    }
    var windowsState: WindowsState = .close {
    didSet {
        if oldValue == .open {
            print("Окна закрыты")
        } else {
            print("Окна открыты")
        }
    }
    }
    var trunkVolumeState: TrunkBox = .withoutTrailer {
        willSet {
            if newValue == .withTrailer {
                print("Мы прицепили прицеп. Можете грузиться")
            } else {
                print("Мы убрали прицеп, теперь грузиться нельзя")
            }
        }
    }
    var trunkVolume: Int = 0
    var maxTrunkVolume: Int = 0
    var weightOfCar: Int = 0
    var weightOfTrunk: Int = 0
    var totalWeightOfCar: Int = 0

    init (markName: CarMark, trailer: TrunkBox){
        self.mark = markName
        self.trunkVolumeState = trailer
        switch markName {
        case .ford:
            self.weightOfCar = 3000
            if trailer == .withTrailer {
            self.maxTrunkVolume = 25000
            self.weightOfTrunk = 2000
                self.totalWeightOfCar = self.weightOfTrunk + self.weightOfCar
            } else {
                self.maxTrunkVolume = 0
                self.totalWeightOfCar = self.weightOfCar
            }
            self.year = 1999
            self.trunkVolume = 0
            self.markString = "Ford"
        case .mercedes:
            self.weightOfCar = 3200
            if trailer == .withTrailer {
            self.maxTrunkVolume = 25000
            self.weightOfTrunk = 2100
                self.totalWeightOfCar = self.weightOfTrunk + self.weightOfCar
            } else {
                self.maxTrunkVolume = 0
                self.totalWeightOfCar = self.weightOfCar
            }
            self.year = 2001
            self.trunkVolume = 0
            self.markString = "Mercedes"
        case .volkswagen:
            self.weightOfCar = 3300
            if trailer == .withTrailer {
            self.maxTrunkVolume = 25000
            self.weightOfTrunk = 2000
                self.totalWeightOfCar = self.weightOfTrunk + self.weightOfCar
            } else {
                self.maxTrunkVolume = 0
                self.totalWeightOfCar = self.weightOfCar
            }
            self.year = 2010
            self.trunkVolume = 0
            self.markString = "Volkswagen"
        case .volvo:
            self.weightOfCar = 3000
            if trailer == .withTrailer {
            self.maxTrunkVolume = 25000
            self.weightOfTrunk = 2000
                self.totalWeightOfCar = self.weightOfTrunk + self.weightOfCar
            } else {
                self.maxTrunkVolume = 0
                self.totalWeightOfCar = self.weightOfCar
            }
            self.year = 2020
            self.trunkVolume = 0
            self.markString = "Volvo"
        }
    }
    
    func printVolState() {
        if trunkVolumeState == .withTrailer {
            print("Вы можете погрузить в прицеп \(maxTrunkVolume - trunkVolume)")
        } else {
            print("Прицеп отсутствует. Грузить ничего нельзя")
        }
    }
    
    func attachTrailerBox() {
        self.trunkVolumeState = .withTrailer
        self.maxTrunkVolume = 25000
        self.totalWeightOfCar = self.weightOfCar + self.weightOfTrunk
    }
    
    func dettachTrailerBox() {
        self.trunkVolumeState = .withoutTrailer
        self.maxTrunkVolume = 0
        self.totalWeightOfCar = self.weightOfCar
    }
    
    func addRemoveTrunkVol (volume: Int) {
        if trunkVolumeState == .withTrailer {
        if volume > 0 {
            self.trunkVolume += volume
            self.totalWeightOfCar += volume
            print("Вы добавили в прицеп \(volume) кг, общая снаряженная масса \(self.totalWeightOfCar) кг")
        } else if volume < 0 && self.trunkVolume >= -volume {
            self.trunkVolume -= -volume
            self.totalWeightOfCar -= -volume
            print("Вы убрали из прицепа \(-volume) кг, общая снаряженная масса \(self.totalWeightOfCar) кг")
        } else {
            print("Масса убираемого груза больше, чем уже закгруженный. Так нельзя.)")
        }
        if trunkVolume <= maxTrunkVolume && trunkVolume >= 0 {
            print("Вы можете доложить еще \(maxTrunkVolume - trunkVolume) кг")
        } else if trunkVolume > maxTrunkVolume {
            print("Автомобиль перегружен. Вам срочно необходимо выгрузить минимум \(trunkVolume - maxTrunkVolume) кг")
        } else {
            print("Вы не можете выгрузить больше чем загрузили")
            self.trunkVolume = 0
        }
        } else {
            trunkVolume = 0
            print ("Вы не можете ничего погрузить без прицепа")
        }
    }
    
}

//проверки работы со снаряженной массой
//var car1 = TrunkCar(markName: .ford, trailer: .withTrailer)
//car1.addRemoveTrunkVol(volume: 5000)
//car1.addRemoveTrunkVol(volume: 5000)
//car1.addRemoveTrunkVol(volume: -10000)
//car1.addRemoveTrunkVol(volume: -1)
//car1.addRemoveTrunkVol(volume: 25001)
//
//car1.dettachTrailerBox()
//car1.addRemoveTrunkVol(volume: 100)
//print(car1)



// расширяем класс SportCar  протоколом CustomStringConvertible
extension SportCar: CustomStringConvertible {
    var description: String {
        let engine: String
        let windows: String
        let weight: String = String(totalWeightOfCar)
        let roof: String
        if engineState == .start {
            engine = "Двигатель запущен"
        } else {
            engine = "Двигатель не запущен"
        }
        if windowsState == .open {
            windows = "Окна опущены"
        } else {
            windows = "Окна подняты"
        }
        if roofState == .open {
            roof = "Крыша убрана"
        } else {
            roof = "Крыша закрыта"
        }
        return "=============================\nМарка вашего автомобиля - \(mark)\nГод выпуска вашего автомобиля - \(year)\n" + engine + "\n" + windows + "\n" + roof + "\n" + "В вашем спорткаре отсутствует багажник\n" + "Снаряженная масса \(weight) кг"
        
    }
}


// Расширяем класс TrunkCar протоколом CustomStringConvertible
extension TrunkCar: CustomStringConvertible {
    var description: String {
        let engine: String
        let windows: String
        let trunk: String
        let weight: String = String(totalWeightOfCar)
        
        if engineState == .start {
            engine = "Двигатель запущен"
        } else {
            engine = "Двигатель не запущен"
        }
        if windowsState == .open {
            windows = "Окна опущены"
        } else {
            windows = "Окна подняты"
        }
        if trunkVolumeState == .withTrailer {
            if trunkVolume <= maxTrunkVolume && trunkVolume >= 0 {
                trunk = "Вы можете доложить еще \(maxTrunkVolume - trunkVolume) кг в прицеп"
            } else if trunkVolume > maxTrunkVolume {
                trunk = "Автомобиль перегружен. Вам срочно необходимо выгрузить минимум \(trunkVolume - maxTrunkVolume) кг из прицепа"
            } else {
                trunk = "Вы не можете выгрузить больше чем загрузили"
            }
        } else {
            trunk = "Вы не можете ничего погрузить без прицепа"
        }
        return "=============================\nМарка вашего автомобиля - \(mark)\nГод выпуска вашего автомобиля - \(year)\n" + engine + "\n" + windows + "\n" + trunk + "\n" + "Общая сняряженная масса \(weight) кг"
    }
}

// <Будем ставить автомобили в гаражи и подсчитывать их общую массу

struct GarageForCars<T: Carable> {
    private var elements: [T] = []
    
    mutating func push (_ element: T) {
        elements.append(element)
    }
    
    mutating func pop() -> T? {
        return elements.removeLast()
    }
    
    var arrayOfCars: [String] {
        var tmpArray: [String] = []
        for element in elements {
            tmpArray.append(element.markString)
        }
        return tmpArray
    }
    
    var totalweight: String {
        var weight: Int = 0
        //var markName: [String] = []
        for element in elements {
            weight += element.totalWeightOfCar
        }
        return "Общая масса автомобилей " + String(weight) + " кг"
    }
    
    subscript(indexes: UInt...) -> Int {
        var weight = 0
        
        for index in indexes where index < self.elements.count {
            weight += self.elements[Int(index)].totalWeightOfCar
    }
    return weight
}
}

// Создаем гаражи для спорткаров и грузовых авто с помощью дженерика
var garageForSportCars = GarageForCars<SportCar>()
var garageForTrunkCars = GarageForCars<TrunkCar>()

//Наполняем гаражи автомобилями
//Гараж со спорткарами
garageForSportCars.push(SportCar(markName: .ford, roof: .open))
garageForSportCars.push(SportCar(markName: .volvo, roof: .close))
garageForSportCars.push(SportCar(markName: .volkswagen, roof: .open))
garageForSportCars.push(SportCar(markName: .mercedes, roof: .close))

//Гараж с грузовыми автомобилями
garageForTrunkCars.push(TrunkCar(markName: .ford, trailer: .withTrailer))
garageForTrunkCars.push(TrunkCar(markName: .mercedes, trailer: .withoutTrailer))
garageForTrunkCars.push(TrunkCar(markName: .volkswagen, trailer: .withTrailer))
garageForTrunkCars.push(TrunkCar(markName: .volvo, trailer: .withoutTrailer))



// Выводим вес автомобилей в гараже из грузовых и спортивных авто, вес может менятся в зависимости от статуса трейлера, как добраться до метода пополнения груза не разобрался, но если не использовать дженерик, то можно менять общую снаряженную массу у грузовиков. По сути можно написать конструктор, который позволит задавать на этапе въезда в гараж снаряженную массу или добавлять груз в трейлер.

print(garageForTrunkCars.totalweight)
print(garageForSportCars.totalweight)
print(garageForSportCars.arrayOfCars)


//с помощью сабскрипта можем вычислять массу автомобиля по инжексу или общую массу автомобилей по нескольким индексам
print(garageForSportCars[5])


//Присваиваем замыкания переменным
let ford: (String) -> Bool = {(element: String) -> Bool in
    return element == "Ford"
}

let mercedes: (String) -> Bool = {(element: String) -> Bool in
    return element == "Mercedes"
}

let volkswagen: (String) -> Bool = {(element: String) -> Bool in
    return element == "Volkswagen"
}

let volvo: (String) -> Bool = {(element: String) -> Bool in
    return element == "Volvo"
}



// функция которая строит массив с марками, переданными в замыкании
func filterCarMark (array: [String], car: (String) -> Bool) -> [String] {
    var tmpArray: [String] = []
    for element in array {
        if car(element) {
            tmpArray.append(element)
        }
    }
    return tmpArray
}


//Использование переменной в функции с замыканием
print(filterCarMark(array: garageForSportCars.arrayOfCars, car: ford))

//Использование замыкания в качестве параметра функции
print(filterCarMark(array: garageForSportCars.arrayOfCars, car: {(element: String) -> Bool in return element == "Volvo"}))

// краткая запись

print(filterCarMark(array: garageForSportCars.arrayOfCars) {$0 == "Volkswagen"})

// подобной функцией можно вывести к примеру спорткары с открытыми крышами))))
// Не понял как, к примеру, вывести в замыкание отсутсвубщую марку и чтобы получил в массиве nil

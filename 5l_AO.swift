//
//  main.swift
//  HomeTaskLesson05
//
//  Created by Антон Оборин on 22.03.2021.
//

import Foundation
/*
1. Создать протокол «Car» и описать свойства, общие для автомобилей, а также методы действий.
2. Создать расширения для протокола «Car» и реализовать в них методы конкретных действий с автомобилем: открыть/закрыть окно, запустить/заглушить двигатель и т.д. (по одному методу на действие, реализовывать следует только те действия, реализация которых общая для всех автомобилей).
3. Создать два класса, имплементирующих протокол «Car» - trunkCar и sportСar. Описать в них свойства, отличающиеся для спортивного автомобиля и цистерны.
4. Для каждого класса написать расширение, имплементирующее протокол CustomStringConvertible.
5. Создать несколько объектов каждого класса. Применить к ним различные действия.
6. Вывести сами объекты в консоль.
*/

//Описываем марки автомобилей
enum CarMark {
   case ford, mercedes, volkswagen, volvo
}

// для спорткара делаем откидную крышу

enum RoofState {
    case open, close
}

//для грузового авто будет прицеп

enum TrunkBox {
   case withTrailer, withoutTrailer
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

protocol Carable {
var mark: CarMark { get }
var year: Int { get }
var engineState: EngineState {get set}
var windowsState: WindowsState {get set}
var trunkVolume: Int {get set}
var maxTrunkVolume: Int {get set}
    
    func startEngine()
    
    func stopEngine()
    
    func openWindows()
    
    func closeWindows()
    
    func printVolState()
}

extension Carable {
    mutating func startEngine() {
        self.engineState = .start
    }
    
    mutating func stopEngine() {
        self.engineState = .stop
    }
    
    mutating func openWindows() {
        self.windowsState = .open
    }
    
    mutating func closeWindows() {
        self.windowsState = .close
    }
    
    func printVolState() {
        print("В багажнике \(trunkVolume) кг")
    }
}

//Имплементируем классу SportCar протокол Carable

class SportCar: Carable {
    var mark: CarMark
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
        case .mercedes:
            self.maxTrunkVolume = 0
            self.year = 2001
            self.trunkVolume = 0
        case .volkswagen:
            self.maxTrunkVolume = 0
            self.year = 2010
            self.trunkVolume = 0
        case .volvo:
            self.maxTrunkVolume = 0
            self.year = 2020
            self.trunkVolume = 0
        }
    }
    
    func startEngine() {
        self.engineState = .start
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
    
    func openRoof() {
        self.roofState = .open
    }
    
    func closeRoof() {
        self.roofState = .close
    }
    
    func printCarState() {
        print("Марка вашего автомобиля - \(mark)")
        print("Год выпуска вашего автомобиля - \(year)")
        if engineState == .start {
            print("Двигатель запущен")
        } else {
            print("Двигатель не запущен")
        }
        if windowsState == .open {
            print("Окна опущены")
        } else {
            print("Окна подняты")
        }
        print("Багажник отсутствует")
        if roofState == .open {
            print("Крыша убрана")
        } else {
            print("Крыша закрыта")
        }
    }
    
}

//Инициализируем класс SportCar, играем))
var car1 = SportCar(markName: .volkswagen, roof: .close)
car1.printCarState()
car1.openRoof()
car1.openWindows()
car1.startEngine()



//Имплементируем классу TrunkCar протокол Carable
class TrunkCar: Carable {
    var mark: CarMark
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

    init (markName: CarMark, trailer: TrunkBox){
        self.mark = markName
        self.trunkVolumeState = trailer
        switch markName {
        case .ford:
            if trailer == .withTrailer {
            self.maxTrunkVolume = 25000
            } else {
                self.maxTrunkVolume = 0
            }
            self.year = 1999
            self.trunkVolume = 0
        case .mercedes:
            if trailer == .withTrailer {
            self.maxTrunkVolume = 25000
            } else {
                self.maxTrunkVolume = 0
            }
            self.year = 2001
            self.trunkVolume = 0
        case .volkswagen:
            if trailer == .withTrailer {
            self.maxTrunkVolume = 25000
            } else {
                self.maxTrunkVolume = 0
            }
            self.year = 2010
            self.trunkVolume = 0
        case .volvo:
            if trailer == .withTrailer {
            self.maxTrunkVolume = 25000
            } else {
                self.maxTrunkVolume = 0
            }
            self.year = 2020
            self.trunkVolume = 0
        }
    }
    
    func startEngine() {
        self.engineState = .start
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
        if trunkVolumeState == .withTrailer {
            print("Вы можете погрузить в прицеп \(maxTrunkVolume - trunkVolume)")
        } else {
            print("Прицеп отсутствует. Грузить ничего нельзя")
        }
    }
    
    func attachTrailerBox() {
        self.trunkVolumeState = .withTrailer
        self.maxTrunkVolume = 25000
    }
    
    func dettachTrailerBox() {
        self.trunkVolumeState = .withoutTrailer
        self.maxTrunkVolume = 0
    }
    
    func printCarState() {
        print("Марка вашего автомобиля - \(mark)")
        print("Год выпуска вашего автомобиля - \(year)")
        if engineState == .start {
            print("Двигатель запущен")
        } else {
            print("Двигатель не запущен")
        }
        if windowsState == .open {
            print("Окна опущены")
        } else {
            print("Окна подняты")
        }
        print("В прицепе \(trunkVolume) кг")
    }
    
    func addRemoveTrunkVol (volume: Int) {
        self.trunkVolume += volume
        if trunkVolumeState == .withTrailer {
        if volume > 0 {
            print("Вы добавили в прицеп \(volume) кг")
        } else if volume < 0 {
            print("Вы убрали из прицепа \(-volume) кг")
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

//Инициализируем класс TrunkCar, играем))
var car2 = TrunkCar(markName: .ford, trailer: .withTrailer)
car2.printCarState()
car2.addRemoveTrunkVol(volume: 200)
car2.dettachTrailerBox()
car2.addRemoveTrunkVol(volume: 300)
car2.printVolState()


// расширяем класс SportCar  протоколом CustomStringConvertible
extension SportCar: CustomStringConvertible {
    var description: String {
        let engine: String
        let windows: String
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
        return "=============================\nМарка вашего автомобиля - \(mark)\nГод выпуска вашего автомобиля - \(year)\n" + engine + "\n" + windows + "\n" + roof + "\n" + "В вашем спорткаре отсутствует багажник"
        
    }
}


// Расширяем класс TrunkCar протоколом CustomStringConvertible
extension TrunkCar: CustomStringConvertible {
    var description: String {
        let engine: String
        let windows: String
        let trunk: String
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
        return "=============================\nМарка вашего автомобиля - \(mark)\nГод выпуска вашего автомобиля - \(year)\n" + engine + "\n" + windows + "\n" + trunk
    }
}


//Проверяем вывод в консоль инициализируемых объектов
print(car1)
print(car2)


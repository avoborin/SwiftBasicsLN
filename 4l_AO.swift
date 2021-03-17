//
//  main.swift
//  HomeTaskLesson04
//
//  Created by Антон Оборин on 17.03.2021.
//

import Foundation

/*
 1. Описать класс Car c общими свойствами автомобилей и пустым методом действия по аналогии с прошлым заданием.

 2. Описать пару его наследников trunkCar и sportСar. Подумать, какими отличительными свойствами обладают эти автомобили. Описать в каждом наследнике специфичные для него свойства.

 3. Взять из прошлого урока enum с действиями над автомобилем. Подумать, какие особенные действия имеет trunkCar, а какие – sportCar. Добавить эти действия в перечисление.

 4. В каждом подклассе переопределить метод действия с автомобилем в соответствии с его классом.

 5. Создать несколько объектов каждого класса. Применить к ним различные действия.

 6. Вывести значения свойств экземпляров в консоль.

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


// опишем основной класс Car

class Car {
    let mark: CarMark
    let year: Int
    var engineState: EngineState = .stop {
        willSet {
            if newValue == .start {
                print("Заводим двигатель")
            } else {
                print("Глушим двигатель")
            }
        }
    }
    var windowsState: WindowsState = .close {
        willSet {
            if newValue == .open {
                print("Окна будут открыты")
            } else {
                print("Окна будут закрыты")
            }
        }
    }
    var trunkVolume: Int = 0
    var maxTrunkVolume: Int = 0
    
    init(markName: CarMark, carYear: Int, volCar: Int) {
        self.mark = markName
        self.year = carYear
        self.trunkVolume = volCar
    }
    
    init (markName: CarMark){
        self.mark = markName
        switch markName {
        case .ford:
            self.maxTrunkVolume = 400
            self.year = 1999
            self.trunkVolume = 0
        case .mercedes:
            self.maxTrunkVolume = 500
            self.year = 2001
            self.trunkVolume = 0
        case .volkswagen:
            self.maxTrunkVolume = 600
            self.year = 2010
            self.trunkVolume = 0
        case .volvo:
            self.maxTrunkVolume = 500
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
        print("В багажнике \(trunkVolume) кг")
    }
    
    func addRemoveTrunkVol (volume: Int) {
        self.trunkVolume += volume
        if volume > 0 {
            print("Вы добавили в багажник \(volume) кг")
        } else if volume < 0 {
            print("Вы убрали из багажника \(-volume) кг")
        }
        if trunkVolume <= maxTrunkVolume && trunkVolume >= 0 {
            print("Вы можете доложить еще \(maxTrunkVolume - trunkVolume) кг")
        } else if trunkVolume > maxTrunkVolume {
            print("Автомобиль перегружен. Вам срочно необходимо выгрузить минимум \(trunkVolume - maxTrunkVolume) кг")
        } else {
            print("Вы не можете выгрузить больше чем загрузили")
            self.trunkVolume = 0
        }
    }
}


class SportCar: Car {
    var roofState: RoofState = .close {
        willSet {
            if newValue == .open {
                print("Складываем крышу в багажник")
            } else {
                print("Раскладываем крышу")
            }
        }
    }
    
    init (markName: CarMark, roof: RoofState) {
        self.roofState = roof
        super.init(markName: markName)
        }
    
    func openRoof() {
        self.roofState = .open
    }
    
    func closeRoof() {
        self.roofState = .close
    }
    
    override func addRemoveTrunkVol(volume: Int) {
        print("Невозможно ничего загрузить - багажник отстутсвует.")
    }
    
    override func printVolState() {
        print("В багажнике \(trunkVolume) кг")
    }
    
    override func printCarState() {
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

var car2 = SportCar(markName: .ford, roof: .close)
car2.printCarState()
var car3 = Car(markName: .mercedes)
car3.addRemoveTrunkVol(volume: 100)


class TrunkCar: Car {
    var trunkVolumeState: TrunkBox = .withoutTrailer {
        willSet {
            if newValue == .withTrailer {
                print("Мы прицепили прицеп. Можете грузиться")
            } else {
                print("Мы убрали прицеп, теперь грузиться нельзя")
            }
        }
    }
    
    
    init(markName: CarMark, trailer: TrunkBox) {
        self.trunkVolumeState = trailer
        super.init(markName: markName)
    }
    
    func attachTrailerBox() {
        self.trunkVolumeState = .withTrailer
        self.maxTrunkVolume = 25000
    }
    
    func dettachTrailerBox() {
        self.trunkVolumeState = .withoutTrailer
        self.maxTrunkVolume = 0
    }
    
    override func printVolState() {
        if trunkVolumeState == .withTrailer {
            print("Вы можете погрузить в прицеп \(maxTrunkVolume - trunkVolume)")
        } else {
            print("Прицеп отсутствует. Грузить ничего нельзя")
        }
    }
    
    override func printCarState() {
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
    
    override func addRemoveTrunkVol (volume: Int) {
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


var car4 = TrunkCar(markName: .volkswagen, trailer: .withTrailer)
car4.printCarState()
car4.attachTrailerBox()
car4.addRemoveTrunkVol(volume: 100)
car4.addRemoveTrunkVol(volume: -200)
car4.addRemoveTrunkVol(volume: 300)
car4.dettachTrailerBox()


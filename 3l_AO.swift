//
//  main.swift
//  HomeTaskLesson03
//
//  Created by Антон Оборин on 12.03.2021.
//

import Foundation

/*
1. Описать несколько структур – любой легковой автомобиль SportCar и любой грузовик TrunkCar.

2. Структуры должны содержать марку авто, год выпуска, объем багажника/кузова, запущен ли двигатель, открыты ли окна, заполненный объем багажника.

3. Описать перечисление с возможными действиями с автомобилем: запустить/заглушить двигатель, открыть/закрыть окна, погрузить/выгрузить из кузова/багажника груз определенного объема.

4. Добавить в структуры метод с одним аргументом типа перечисления, который будет менять свойства структуры в зависимости от действия.

5. Инициализировать несколько экземпляров структур. Применить к ним различные действия.

6. Вывести значения свойств экземпляров в консоль.

*/

//Задание 1


//Описываем марки автомобилей в различных категориях
enum CitizenCarMark {
   case ford, toyota, volkswagen, cadillac, bmw, vaz, volvo
}

enum  SportCarMark{
   case ferrari, lotus, mercedes
}

enum TrunkCarMark {
   case man, fredliner, volvo
}


//для спорткара нет параметра багажник из за его отсутствия

// Описываем статус двигателя
enum EngineState {
   case start, stop
}

// Описываем статус открытия окон

enum WindowsState {
   case open, close
}

//Заполнять объем багажника будем в структуре
// А теперь сами структуры
//Инициализируем структуру легкового авто
struct CitizenCar {
   let mark: CitizenCarMark
   var year: Int
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
   

   
   mutating func addTrunkVol (volume: Int) {
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
   
   init(markName: CitizenCarMark, carYear: Int, volCar: Int) {
       self.mark = markName
       self.year = carYear
       self.trunkVolume = volCar
   }
   
   init (markName: CitizenCarMark){
       self.mark = markName
       switch markName {
       case .bmw:
           self.engineState = .stop
           self.windowsState = .close
           self.maxTrunkVolume = 400
           self.year = 1999
           self.trunkVolume = 0
       case .ford:
           self.engineState = .stop
           self.windowsState = .close
           self.maxTrunkVolume = 500
           self.year = 2001
           self.trunkVolume = 0
       case .toyota:
           self.engineState = .stop
           self.windowsState = .close
           self.maxTrunkVolume = 600
           self.year = 2010
           self.trunkVolume = 0
       case .volkswagen:
           self.engineState = .stop
           self.windowsState = .close
           self.maxTrunkVolume = 600
           self.year = 2017
           self.trunkVolume = 0
       case .cadillac:
           self.engineState = .stop
           self.windowsState = .close
           self.maxTrunkVolume = 600
           self.year = 2007
           self.trunkVolume = 0
       case .vaz:
           self.engineState = .stop
           self.windowsState = .close
           self.maxTrunkVolume = 200
           self.year = 2005
           self.trunkVolume = 0
       case .volvo:
           self.engineState = .stop
           self.windowsState = .close
           self.maxTrunkVolume = 500
           self.year = 2020
           self.trunkVolume = 0
       }
   
   }
}

print("Структура: Гражданский/легковой автомобиль:")
//Инициализация структуры CitizenCar
var car1 = CitizenCar(markName: .bmw)
car1.printCarState()
car1.addTrunkVol(volume: 100)
car1.startEngine()
print("============================\n")


//Инициализация структуры SportCar
struct SportCar {
   let mark: SportCarMark
   var year: Int
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
               print("Окна будут опущены")
           } else {
               print("Окна будут подняты")
           }
       }
   }
   
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
       print("У вас нет багажника, у вас же спорткар :D")
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
   }
   
  
   init(markName: SportCarMark, carYear: Int) {
       self.mark = markName
       self.year = carYear
   }
   
   init (markName: SportCarMark){
       self.mark = markName
       switch markName {
       case .ferrari:
           self.year = 2000
       case .lotus:
           self.year = 2001
       case .mercedes:
           self.year = 2020

       }
   
   }
}


print("Структура: Спорткар:")
var car2 = SportCar(markName: .mercedes)
car2.printCarState()
car2.openWindows()
car2.printVolState()
car2.startEngine()
print("=========================\n")



enum TrunkBox {
   case withTrailer, withoutTrailer
}
//Инициализация структуры TrunkCar
struct TrunkCar {
   let mark: TrunkCarMark
   var year: Int
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
               print("Окна будут опущены")
           } else {
               print("Окна будут подняты")
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
   
   mutating func attachTrailerBox() {
       self.trunkVolumeState = .withTrailer
       self.maxTrunkVolume = 25000
   }
   
   mutating func dettachTrailerBox() {
       self.trunkVolumeState = .withoutTrailer
       self.maxTrunkVolume = 0
   }
   
   func printVolState() {
       if trunkVolumeState == .withTrailer {
           print("Вы можете погрузить в прицеп \(maxTrunkVolume - trunkVolume)")
       } else {
           print("Прицеп отсутствует. Грузить ничего нельзя")
       }
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
   

   
   mutating func addTrunkVol (volume: Int) {
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
   
   
   init (markName: TrunkCarMark){
       self.mark = markName
       switch markName {
       case .fredliner:
           self.trunkVolumeState = .withTrailer
           self.maxTrunkVolume = 25000
           self.year = 2000
       case .man:
           self.trunkVolumeState = .withoutTrailer
           self.maxTrunkVolume = 0
           self.year = 2005

       case .volvo:
           self.trunkVolumeState = .withTrailer
           self.maxTrunkVolume = 25000
           self.year = 2010

       }
   }
   
}

print("Структура: Грузовой автомобиль:")
//Инициализация структуры CitizenCar
var car3 = TrunkCar(markName: .fredliner)
car3.addTrunkVol(volume: 1000)
car3.dettachTrailerBox()
car3.addTrunkVol(volume: 1000)
car3.attachTrailerBox()
car3.addTrunkVol(volume: 20000)
   
print("============================\n")



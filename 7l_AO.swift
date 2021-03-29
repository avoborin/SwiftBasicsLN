//
//  main.swift
//  HomeTaskLesson07
//
//  Created by Антон Оборин on 29.03.2021.
//

import Foundation
/*
1. Придумать класс, методы которого могут завершаться неудачей и возвращать либо значение, либо ошибку Error?. Реализовать их вызов и обработать результат метода при помощи конструкции if let, или guard let.
2. Придумать класс, методы которого могут выбрасывать ошибки. Реализуйте несколько throws-функций. Вызовите их и обработайте результат вызова при помощи конструкции try/catch.
*/

struct Cinema {
    var price: Int
    var ticketCount: Int
    let name: CinemaName
}

struct CinemaName {
    let name: String
}

enum OnlineCinemaError: Error {
    case WrongFilm
    case NoTicketsOnThisFilm
    case NotEnoughMoney (moneyNeeded: Int)
}

class OnlineCinema {
    var films = [
        "Властелин колец": Cinema(price: 150, ticketCount: 100, name: CinemaName(name: "Властелин колец")),
        "Гарри Поттер": Cinema(price: 200, ticketCount: 100, name: CinemaName(name: "Гарри Поттер")),
        "Пираты карибского моря": Cinema(price: 250, ticketCount: 100, name: CinemaName(name: "Пираты карибского моря"))
    ]
    
    var userWallet = 0
    
    func lookFilm(cinemaName filmName: String) throws -> CinemaName {
        guard let film = films[filmName] else {
            throw OnlineCinemaError.WrongFilm
        }
        guard film.ticketCount > 0 else {
            throw OnlineCinemaError.NoTicketsOnThisFilm
        }
        guard film.price <= userWallet else {
            throw OnlineCinemaError.NotEnoughMoney(moneyNeeded: film.price - userWallet)
        }
        userWallet -= film.price
        var newFilm = film
        newFilm.ticketCount -= 1
        films[filmName] = newFilm
        print("Билет на \(filmName) приобретен")
        return newFilm.name
    }
}

let films1 = OnlineCinema()

do {
    _ = try films1.lookFilm(cinemaName: "Мстители")
} catch OnlineCinemaError.WrongFilm {
    print("Такого фильма нет в каталоге")
} catch OnlineCinemaError.NoTicketsOnThisFilm {
    print("Билетов на данный фильм нет")
} catch OnlineCinemaError.NotEnoughMoney(let moneyNeeded) {
    print("У вас недостаточно денег на счету. Вам необходимо еще \(moneyNeeded) руб")
} catch let error {
    print(error.localizedDescription)
}

do {
    _ = try films1.lookFilm(cinemaName: "Властелин колец")
} catch OnlineCinemaError.WrongFilm {
    print("Такого фильма нет в каталоге")
} catch OnlineCinemaError.NoTicketsOnThisFilm {
    print("Билетов на данный фильм нет")
} catch OnlineCinemaError.NotEnoughMoney(let moneyNeeded) {
    print("У вас недостаточно денег на счету. Вам необходимо еще \(moneyNeeded) руб")
} catch let error {
    print(error.localizedDescription)
}

films1.userWallet = 150

do {
    _ = try films1.lookFilm(cinemaName: "Властелин колец")
} catch OnlineCinemaError.WrongFilm {
    print("Такого фильма нет в каталоге")
} catch OnlineCinemaError.NoTicketsOnThisFilm {
    print("Билетов на данный фильм нет")
} catch OnlineCinemaError.NotEnoughMoney(let moneyNeeded) {
    print("У вас недостаточно денег на счету. Вам необходимо еще \(moneyNeeded) руб")
} catch let error {
    print(error.localizedDescription)
}

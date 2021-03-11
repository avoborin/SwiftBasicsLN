//
//  main.swift
//  Lesson02
//
//  Created by Антон Оборин on 09.03.2021.
//

import Foundation


/*
 1. Написать функцию, которая определяет, четное число или нет.
 
 2. Написать функцию, которая определяет, делится ли число без остатка на 3.
 
 3. Создать возрастающий массив из 100 чисел.
 
 4. Удалить из этого массива все четные числа и все числа, которые не делятся на 3.
 
 5. * Написать функцию, которая добавляет в массив новое число Фибоначчи, и добавить при помощи нее 100 элементов.
 
 Числа Фибоначчи определяются соотношениями Fn=Fn-1 + Fn-2.
 6. * Заполнить массив из 100 элементов различными простыми числами. Натуральное число, большее единицы, называется простым, если оно делится только на себя и на единицу. Для нахождения всех простых чисел не больше заданного числа n, следуя методу Эратосфена, нужно выполнить следующие шаги:
 
 a. Выписать подряд все целые числа от двух до n (2, 3, 4, ..., n).
 b. Пусть переменная p изначально равна двум — первому простому числу.
 c. Зачеркнуть в списке числа от 2p до n, считая шагами по p (это будут числа, кратные p: 2p, 3p, 4p, ...).
 d. Найти первое не зачёркнутое число в списке, большее, чем p, и присвоить значению переменной p это число.
 e. Повторять шаги c и d, пока возможно.
 */


// Задание 1

print ("Задание 1")
func chetnoeChislo (a: Int) -> Int {
    if a % 2 == 0 {
        print("Число четное")
    } else {
        print("Число нечетное")
    }
    return a
}

print(chetnoeChislo(a: 6))
print("=========================\n")


// Задание 2

print ("Задание 2")

func delitsyaNaTri (a: Int) -> Int {
    if a % 3 == 0 {
        print("Число делится на 3")
    } else if  a == 0 {
        print("Вы ввели 0")
    } else {
        print("Число не делится на 3")
    }
    return a
}

print(delitsyaNaTri(a: 16))
print("=========================\n")


// Задание 3

print ("Задание 3")
var vozArray: [Int] = []
for i in 1...100 {
    vozArray.append(i)
}
print(vozArray)
print("=========================\n")


// Задание 4

print ("Задание 4")
for value in vozArray {
    if (value % 2 == 0) || (value % 3 == 0) {
        vozArray.remove(at: vozArray.firstIndex(of: value)!)
    }
}

print(vozArray)
print("=========================\n")


// Задание 5

print ("Задание 5")
func fibonacci (array: inout [Int]) -> [Int] {
    for i in array.count...array.count+50 {
        if i >= 2{
            let num: Int = array[array.count-1] + array[array.count-2]
            array.append(num)
        } else {
            array.append(i)
        }
}
    return array
}

var array: [Int] = [0,1]
print(fibonacci(array: &array))

print("=========================\n")
// Задание 6


print ("Задание 6")
//var p = 2
//var n = 100
//
//var arrayOfSimpleNumbers: [Int] = []
//
//for i in 2...n {
//    arrayOfSimpleNumbers.append(i)
//}
//print(arrayOfSimpleNumbers)
//
//for i in stride(from: 2+p, through: arrayOfSimpleNumbers.count, by: p) {
//    if let index = arrayOfSimpleNumbers.firstIndex(of: i) {
//        arrayOfSimpleNumbers.remove(at: index)
//    }
//}
//
//print(arrayOfSimpleNumbers)
//
//for ind in arrayOfSimpleNumbers {
//    if ind > p {
//        p = ind
//        break
//    }
//}
//
//print(p)
//
//for i in stride(from: 2+p, through: arrayOfSimpleNumbers.count, by: p) {
//    if let index = arrayOfSimpleNumbers.firstIndex(of: i) {
//        arrayOfSimpleNumbers.remove(at: index)
//    }
//}
//
//print(arrayOfSimpleNumbers)


//Не смог реализовать то, что изначально задумал. Распаковка с помощью if let ничего не дала, так как где получал значение nil. реализовал вариант из разбора ДЗ в 3-ем уроке

func createPrimeNumbersArray() -> [Int] {
    var primeNumbersArray = [2]
    var currentNumber = 3
    
    while primeNumbersArray.count < 100 {
        
        var isPrimeNumber = true
        for checkNumber in 2...currentNumber - 1 {
            if currentNumber % checkNumber == 0 {
                isPrimeNumber = false
                break
            }
        }
        
        if isPrimeNumber {
            primeNumbersArray.append(currentNumber)
        }
        
        currentNumber += 1
    }
    
    return primeNumbersArray
}

let primeNumbersArray = createPrimeNumbersArray()

print(primeNumbersArray)

//
//  CreateNewUser.swift
//  UILesson01HT
//
//  Created by Антон Оборин on 15.04.2021.
//

import Foundation
import UIKit

func createNewUser (userNumber: Int, name: String, age: UInt) -> User {
    var user = User(name: name)
    user.age = age
    
    var imageName = String(userNumber) + "_1"
    user.avatar = UIImage(named: imageName)
    
    
    for index in 2...5 {
        imageName = String(userNumber) + "_" + String(index)
        if let image = UIImage(named: imageName) {
            user.fotoArray.append(image)
            
        }
    }
    
    return user
}

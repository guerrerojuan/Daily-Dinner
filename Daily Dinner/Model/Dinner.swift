//
//  Dinner.swift
//  Daily Dinner
//
//  Created by Juan Guerrero on 1/10/18.
//  Copyright © 2018 Juan Guerrero. All rights reserved.
//

import UIKit
import Foundation


class Dinner {
    var imageRef : String?
    var dinnerTitle : String?
    var prepTime : String?
    var ingredientsText : String?
    
    init(dictionary: [String: Any]) {
        self.imageRef = dictionary["dinnerMainImage"] as? String
        self.dinnerTitle = dictionary["dinnerTitle"] as? String
        self.prepTime = dictionary ["prepTime"] as? String
        self.ingredientsText = dictionary["ingredients"] as? String
    }
    
}

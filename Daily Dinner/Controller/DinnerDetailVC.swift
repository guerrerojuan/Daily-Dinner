//
//  DinnerDetailVC.swift
//  Daily Dinner
//
//  Created by Juan Guerrero on 1/6/18.
//  Copyright © 2018 Juan Guerrero. All rights reserved.
//

import UIKit
import Hero

class DinnerDetailVC: UIViewController {
    
    @IBOutlet weak var dinnerImage: UIImageView!
    @IBOutlet weak var ingredientsTitle: UILabel!
    @IBOutlet weak var preparationTitle: UILabel!
    @IBOutlet weak var activeLine: UIView!
    @IBOutlet weak var ingredientsTextView: UITextView!

    var dinnerTitle: Any?
    var passedImageURL: Any?
    var passedIngredients: Any?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        ingredientsTitle.addCharacterSpacing()
        preparationTitle.addCharacterSpacing()
        self.navigationItem.title = dinnerTitle as? String
        dinnerImage.loadImageUsingCacheWithUrlString(passedImageURL as! String)
        formatIngredients(string: (passedIngredients as? String)!)
    }

    func formatIngredients(string: String) {
        let seperatedString = string.components(separatedBy: "-")
        var newSring = ""
        for word in seperatedString {
            newSring = newSring + "\(word)\n"
        }
        ingredientsTextView.text = newSring
    }
    
}

extension UILabel {
    func addCharacterSpacing() {
        if let labelText = text, labelText.count > 0 {
            let attributedString = NSMutableAttributedString(string: labelText)
            attributedString.addAttribute(NSAttributedStringKey.kern, value: 2, range: NSRange(location: 0, length: attributedString.length - 1))
            attributedText = attributedString
        }
    }
}

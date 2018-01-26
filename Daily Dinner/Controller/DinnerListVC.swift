//
//  FirstViewController.swift
//  Daily Dinner
//
//  Created by Juan Guerrero on 1/4/18.
//  Copyright © 2018 Juan Guerrero. All rights reserved.
//

import UIKit
import Firebase
import Hero

class DinnerListVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var dinnerArray = [Dinner]()
    
    @IBOutlet weak var dinnerTableView: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchDinners()
        // Do any additional setup after loading the view, typically from a nib.
        navigationController?.heroNavigationAnimationType = .zoom
        dinnerTableView.delegate = self
        dinnerTableView.dataSource = self
        dinnerTableView.separatorColor = UIColor.clear
        
    }
    
    func fetchDinners() {
        Database.database().reference().child("dinners").observe(.childAdded, with: { (snapshot) in
            
            if let dictionary = snapshot.value as? [String: AnyObject] {
                let dinner = Dinner(dictionary: dictionary)
                self.dinnerArray.append(dinner)
                
                //this will crash because of background thread, so lets use dispatch_async to fix
                DispatchQueue.main.async(execute: {
                    self.dinnerTableView.reloadData()
                    self.dinnerTableView.beginUpdates()
                    self.dinnerTableView.endUpdates()
                })
            }
            
        }, withCancel: nil)
    }

    override var preferredStatusBarStyle : UIStatusBarStyle {
        //return UIStatusBarStyle.lightContent
        return UIStatusBarStyle.default   // Make dark again
    }
    
    
    // UITableViewAutomaticDimension calculates height of label contents/text
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300.0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dinnerArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = dinnerTableView.dequeueReusableCell(withIdentifier: "dinnerCell", for: indexPath) as! DinnerCell
        cell.selectionStyle = .none
        cell.prepareForReuse()
        let dinner = dinnerArray[indexPath.row]
        if let profileImageUrl = dinner.imageRef {
            cell.dinnerUIImage.loadImageUsingCacheWithUrlString(profileImageUrl)
            cell.dinnerUIImage.roundImageCorners()
            cell.contentView.layer.shadowOpacity = 0.3
            cell.contentView.layer.shadowOffset = CGSize(width: 5, height: 5)
            cell.contentView.layer.shadowRadius = 5.0
            cell.contentView.layer.shadowColor = UIColor.black.cgColor
        }
        cell.dinnerTitleLabel.text = dinner.dinnerTitle
        cell.dinnerPrepTimeLabel.text = dinner.prepTime
        cell.titleBackground?.roundBottomCorners()
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showDetail", sender: nil)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" ,
            let nextScene = segue.destination as? DinnerDetailVC ,
            let indexPath = self.dinnerTableView.indexPathForSelectedRow {
            let selectedDinner = dinnerArray[indexPath.row]
            nextScene.dinnerTitle = selectedDinner.dinnerTitle
            nextScene.passedImageURL = selectedDinner.imageRef
            nextScene.passedIngredients = selectedDinner.ingredientsText
        }
    }
    
}


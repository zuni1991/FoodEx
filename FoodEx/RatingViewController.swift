//
//  RatingViewController.swift
//  FoodEx
//
//  Created by Andrew on 4/30/20.
//  Copyright © 2020 Juan Zuniga. All rights reserved.
//

import UIKit
import Parse

class RatingViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UITableViewDelegate, UITableViewDataSource {
    

    

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var pickerView: UIPickerView!
    //  *THE TEXTFIELD IN STORYBOARD IS NOT CONNECTED YET*
    
    
    //  BROUGHT THIS FROM FeedViewController
    var feeds:PFUser?
    //  LIST USED FOR PICKER VIEW
    let rateStars = ["★☆☆☆☆", "★★☆☆☆", "★★★☆☆", "★★★★☆", "★★★★★"]
    
    //  **NOT BEING USED ATM**
    var selectedRating = 0
    var numberOfRating = 0
    var currentRating = 0
    
    
    
    //  FIVE, SO THAT ONLY FIVE REVIEWS ARE SHOWN.
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    //  HARDCODED REVIEW IS PRINTED FOR 5 CELLS
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
    
        cell.textLabel!.text = "★★★☆☆ This is a review"
        return cell
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
        
        
        //  OLD CODE **WE MIGHT USE**
        //  GETS THE AVERAGE RATING OF EACH USER
        //  COULDN'T USE BECAUSE COULDN'T FIGURE OUT HOW TO CHANGE INFO IN USER CLASS FROM HERE
        numberOfRating = feeds!["numberOfRatings"] as? Int ?? 1
        currentRating = feeds!["rating"] as? Int ?? 1
        let averageRating = currentRating/numberOfRating
        let stringNum = "\(averageRating as! Int)"
        
        //  HARDED SO THE STRING WON'T SHOW WHEN YOU RUN THE APP
        //  UNCOMMENT line 69 TO SHOW THE STRING WHEN YOU RUN THE APP
        self.ratingLabel.text = ""
        //self.ratingLabel.text = stringNum + "★ / 5★"
    }

    //  CURRENTLY SAVES A HARD CODED REVIEW TO PARSE
    @IBAction func onSubmit(_ sender: Any) {
        
        let poster = feeds
        let review = PFObject(className: "Reviews")

        review["poster"] = poster
        review["author"] = PFUser.current()!
        review["stars"] = "★★★★☆"
        review["comment"] = "The food great!"
        
        poster?.add(review, forKey: "reviews")

        poster?.saveInBackground { (success, error) in
        if success {
            print("Saved")
        } else {
            print("Error: \(error?.localizedDescription)")
        }
        }

    }
    
    
    //  THIS IS USED FOR THE PICKER
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    //  MAKES SURE THE PICKER ONLY HAS FIVE OPTIONS (SIZE OF rateStars ARRAY)
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        return rateStars.count
    }
    
    //  PRINTS THE OPTIONS FOR PICKER FROM rateStars ARRAY
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return rateStars[row]
    }
    
    //  **MUST BE CHANGED** //  SAVES THE INDEX+1 OF THE STARS YOU SELECT IN THE PICKER.
                            //  MUST BE CHANGED TO SAVE THE STRING VALUE, INSTEAD OF THE INT/INDEX
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedRating = row + 1
        print(selectedRating)
    }
    
}

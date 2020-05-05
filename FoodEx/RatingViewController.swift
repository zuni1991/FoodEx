//
//  RatingViewController.swift
//  FoodEx
//
//  Created by Andrew on 4/30/20.
//  Copyright © 2020 Juan Zuniga. All rights reserved.
//

import UIKit
import Parse

class RatingViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UITableViewDelegate, UITableViewDataSource  {

    @IBOutlet weak var reviewTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var reviewsLabel: UILabel!
    //  ARRAY TO SAVE REVIEWS FROM PARSE
    var reviewList:[String] = []
    //  BROUGHT THIS FROM FeedViewController
    var feeds:PFUser?
    //  LIST USED FOR PICKER VIEW
    let rateStars = ["★☆☆☆☆", "★★☆☆☆", "★★★☆☆", "★★★★☆", "★★★★★"]
    //  INITIALIZED IN CASE USER DOESN'T MOVE PICKER
    var selectedRating = "★☆☆☆☆"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        //  STORES THE USER'S objectId INTO userOID **NEEDED FOR QUERY**
        let userOID = feeds?.objectId as! String
        //  STORES THE USER'S username INTO userName **NEEDED TO UPDATE LABELS**
        let userName = feeds?.username as! String
        //  LABELS + TEXT FOR STORYBOARD
        self.ratingLabel.text = "Leave a review for " + userName + ":"
        self.reviewsLabel.text = userName + "'s reviews"
        
        //  QUERY TO GET ALL REVIEWS FOR USER WHERE objectId = userOID
        let query = PFQuery(className: "Reviews2")
        query.whereKey("poster", equalTo:userOID)
        query.order(byDescending: "createdAt")
        query.findObjectsInBackground { (objects: [PFObject]?, error: Error?) in
            if let error = error {
                // Log details of the failure
                print(error.localizedDescription)
            } else if let objects = objects {
                // The find succeeded.
                print("Successfully retrieved \(objects.count) reviews.")
                // Do something with the found objects
                for object in objects {
                    let starString = object["stars"] as? String
                    let reviewString = object["comment"] as? String
                    self.reviewList.append(starString! + " " + reviewString!)
                    self.tableView.reloadData()
                }
            }
        }
    }

    //   SAVES A REVIEW TO PARSE
    @IBAction func onSubmit(_ sender: Any) {
        let poster = feeds
        let objId = poster!.objectId as! String
        print(objId)
        let review = PFObject(className: "Reviews2")
        review["poster"] = objId
        review["author"] = PFUser.current()
        review["stars"] = selectedRating
        review["comment"] = reviewTextField.text
        review.saveInBackground { (success, error) in
        if success {
            print("Saved")
        } else {
            print("Error: \(error?.localizedDescription)")
        }
        }
        dismiss(animated: true, completion: nil)
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
    
    //  SAVES THE STRING VALUE OF THE STARS YOU SELECT IN THE PICKER.
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedRating = rateStars[row]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reviewList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let rreview = reviewList[indexPath.row]
        cell.textLabel!.text = rreview
        return cell
    }
    
}

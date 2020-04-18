//
//  FeedViewController.swift
//  FoodEx
//
//  Created by Andrew on 3/16/20.
//  Copyright © 2020 Juan Zuniga. All rights reserved.
//

import UIKit
import Parse
import AlamofireImage

class FeedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{

    
    @IBOutlet weak var tableView: UITableView!

    var posts = [PFObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let query = PFQuery(className:"Posts")
        query.includeKey("author")
        query.limit = 5
        
        query.findObjectsInBackground{(posts,error) in
            if posts != nil{
                self.posts = posts!
                self.tableView.reloadData()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell =  tableView.dequeueReusableCell(withIdentifier: "PostCell") as! PostCell
        let  post = posts[indexPath.row]
        

        //let user = post["author"] as! PFUser
        //cell.userName = user.username
        
        cell.captionLabel.text = post["caption"] as? String
        let ImageFile = post["image"] as! PFFileObject
        let urlString = ImageFile.url!
        let url = URL(string: urlString)!
        cell.photoView.af_setImage(withURL: url)
        return cell

}
    @IBAction func Itinerario(sender: UITapGestureRecognizer) {
        //if you need the cell or index path
        let location = sender.location(in: self.tableView)
        let indexPath = self.tableView.indexPathForRow(at: location)
        if indexPath != nil
        {
          let a = "Ashish"
            print("Ashish")
          let b: String = "\n"
          let c: String = "\n"
          let d: String = "*Lugar Destacado"
          let sum = a + b + c + d

            let alert = UIAlertController(title: "Itinerario de Procesión", message: "\(sum)", preferredStyle: UIAlertController.Style.alert)
            let action1 = UIAlertAction(title: "Atrás", style: UIAlertAction.Style.cancel, handler: nil)

          alert.addAction(action1)


            self.present(alert, animated: true, completion: nil);
        }


    }
    
    
    



    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    
    
    @IBAction func onLogoutButton(_ sender: Any) {
        PFUser.logOut()
        self.performSegue(withIdentifier: "LoggingOut", sender: nil)
    }
    
    
    
    
}

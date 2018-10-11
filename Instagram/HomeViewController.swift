//
//  HomeViewController.swift
//  Instagram
//
//  Created by Mac on 7/16/1397 AP.
//  Copyright © 1397 Abraham Asmile. All rights reserved.
//

import UIKit
import Parse

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var tableView: UITableView!
    
   // @IBOutlet weak var imagePosts: UIImageView!
    var refreshControl: UIRefreshControl!
    var information = [Post]()
     var window: UIWindow?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
       tableView.delegate = self
        tableView.dataSource = self
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(HomeViewController.didPullTorefresh(_:)) , for: .valueChanged)
        tableView.insertSubview(refreshControl, at: 0)
        
        
        tableView.dataSource = self
        tableView.rowHeight = 150
        tableView.estimatedRowHeight = 200
        self.pullInformation()
    }
    @objc func didPullTorefresh (_ refreshControl: UIRefreshControl) {
       // call a method
        pullInformation()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
            func singOut() {
                // Logout the current user
                PFUser.logOutInBackground(block: { (error) in
                    if let error = error {
                        print(error.localizedDescription)
                    } else {
                        print("Successful loggout")
                        // Load and show the login view controller
                        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                        let loginViewController = storyboard.instantiateViewController(withIdentifier: "loginViewController")
                        self.window?.rootViewController = loginViewController
                    }
                })
            }
    }
    func pullInformation() {
        let query = Post.query()
        query?.order(byDescending: "createdAt")
        query?.includeKey("author")
        query?.order(byDescending: "createdAt")
        query?.limit = 20
        query?.findObjectsInBackground { (objects: [PFObject]?, error: Error?) -> Void in
            if error == nil {
                // The find succeeded.
                self.information = objects! as! [Post]
                self.tableView.reloadData()
                self.refreshControl.endRefreshing()
            }
        }
    }

   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return information.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeFeedTableViewCell", for: indexPath) as! HomeFeedTableViewCell
        let post = information[indexPath.row]
        
        if let imageFile : PFFile = post.media{
            imageFile.getDataInBackground { (data,error) in
                if (error != nil) {
                    print(error.debugDescription)
                }
                else{
                    cell.imageViewpost.image = UIImage(data: data!)
                }
            }
        }
        cell.textLabel?.text = post.caption
//        let user = PFUser.current()
        return cell
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let detail = segue.destination as? DetailsViewController
       if let cell = sender as! HomeFeedTableViewCell? {
           if let indexpath = tableView.indexPath(for: cell) {
               let post = information[indexpath.row]
               detail?.post = post
           }
        }
    
   }

    @IBAction func onCamera(_ sender: Any) {
        performSegue(withIdentifier: "photoSegue", sender: nil)
    }
    
    @IBAction func onLogOut(_ sender: Any) {
       NotificationCenter.default.post(name: NSNotification.Name("didLogout"), object: nil)
    }
    
}

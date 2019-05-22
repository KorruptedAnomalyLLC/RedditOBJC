//
//  RedditPostViewController.swift
//  RedditOBJC
//
//  Created by Austin West on 5/22/19.
//  Copyright © 2019 Austin West. All rights reserved.
//

import UIKit

class RedditPostViewController: UIViewController {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        
        AJWRedditPostController.shared().fetchPosts { (success) in
            if success {
                DispatchQueue.main.async{
                    self.tableView.reloadData() }
            } else {
                print("Didn't fetch posts")
            }
        }
        
    }
}

extension RedditPostViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return AJWRedditPostController.shared().posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "postCell", for: indexPath)
        
        let post = AJWRedditPostController.shared().posts[indexPath.row]
        
        cell.textLabel?.text = post.title
        
        return cell
    }
}

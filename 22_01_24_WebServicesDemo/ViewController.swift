//
//  ViewController.swift
//  22_01_24_WebServicesDemo
//
//  Created by Vishal Jagtap on 11/03/24.
//

import UIKit

class ViewController: UIViewController {
    var url : URL?
    var urlRequest : URLRequest?
    var urlSession : URLSession?
    var uiNib : UINib?
    var postTableViewCell : PostTableViewCell?
    private let postTableViewCellReuseIdentifier = "PostTableViewCell"
    var posts : [Post] = []

    @IBOutlet weak var postTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        serializeJSON()
        initializePostTableView()
        registerXIBWithPostTableView()
    }
    
    func initializePostTableView(){
        postTableView.dataSource = self
        postTableView.delegate = self
    }
    
    func registerXIBWithPostTableView(){
        uiNib = UINib(nibName: postTableViewCellReuseIdentifier, bundle: nil)
        self.postTableView.register(uiNib, forCellReuseIdentifier: postTableViewCellReuseIdentifier)
    }
    
    func serializeJSON(){
        url = URL(string: "https://jsonplaceholder.typicode.com/posts")         //step 1 --> to convert string into URL
        urlRequest = URLRequest(url: url!)
        urlRequest?.httpMethod = "GET"
        
        urlSession = URLSession(configuration: .default)
        let dataTask = urlSession?.dataTask(with: urlRequest!){
            data, response, error in
            
            print(data)
            print(response)
            print(error)
            
            let jsonResponse = try! JSONSerialization.jsonObject(with: data!) as! [[String:Any]]
            for eachPost in jsonResponse{
                let eachPostUserId = eachPost["userId"] as! Int
                let eachPostId = eachPost["id"] as! Int
                let eachPostTitle = eachPost["title"] as! String
                let eachPostBody = eachPost["body"] as! String
                
                let eachPostObject = Post(userId: eachPostUserId, id: eachPostId, title: eachPostTitle, body: eachPostBody)
                
                self.posts.append(eachPostObject)
            }
            
            DispatchQueue.main.async {
                self.postTableView.reloadData()
            }
            
            print(self.posts)
        }
        dataTask?.resume()
    }
}

//MARK : UITableViewDataSource
extension ViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        postTableViewCell = self.postTableView.dequeueReusableCell(withIdentifier: postTableViewCellReuseIdentifier, for: indexPath) as! PostTableViewCell
        
        postTableViewCell?.userIdLabel.text = String(posts[indexPath.row].userId)
        postTableViewCell?.idLabel.text = String(posts[indexPath.row].id)
        postTableViewCell?.titleLabel.text = posts[indexPath.row].title
        postTableViewCell?.bodyLabel.text = posts[indexPath.row].body
        
        return postTableViewCell!
    }
}

//MARK : UITableViewDelegate
extension ViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 143.0
    }
}

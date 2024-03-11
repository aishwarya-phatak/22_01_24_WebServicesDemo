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
    var posts : [Post] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        serializeJSON()
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
            print(self.posts)
        }
        dataTask?.resume()
    }
}

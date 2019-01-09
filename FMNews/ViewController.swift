
//
//  Created by Dione on 05/01/2018.
//  Copyright © 2018 Dione. All rights reserved.

import UIKit
import Social

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    //  UITableViewDelegate: represents the display and behaviour of the cells.
    // UITableViewDataSource : represents the data model object
    //it supplies no information about appearance
    
 
   
    @IBAction func back(_ sender: Any) {
    }
   
    @IBOutlet weak var tableview: UITableView!
    
    var articless: [News]? = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchArticles() // this part featchs all the articles from json and populate the viewtable
    }
    
    func fetchArticles(){
        let urlRequest = URLRequest(url: URL(string: //url that is being used 
            "https://newsapi.org/v2/top-headlines?sources=four-four-two&apiKey=5d0f0e3f78ba4a4890ae3ac3e3718ec6")!)
        
        let task = URLSession.shared.dataTask(with: urlRequest) { (data,response,error) in
            // required to laod the data, will give us required json data, response and error
            // data = football, response = everyhting okay, no errors
            
            
            if error != nil { // check if there are any problems
                print(error)
                return
            }
            /// JsonSerilization - //This returns YES if the given object can be converted to JSON data, NO otherwise.

            self.articless = [News]()   // = jsonSerlization insereted
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! [String : AnyObject]  // Anyobject=The protocol to which all class types implicitly conform.
                print ("Returned JSON = \(json)") // prints the returned json data
                if let articlesFromJson = json["articles"] as? [[String : AnyObject]] { 
                    for articleFromJson in articlesFromJson {
                        let article = News()
                        if let title = articleFromJson["title"] as? String, let desc = articleFromJson["description"] as? String, let url = articleFromJson["url"] as? String, let urlToImage = articleFromJson["urlToImage"] as? String {
                            
                        
                            article.desc = desc
                            article.headline = title
                            article.url = url
                            article.imageUrl = urlToImage
                        }
                        self.articless?.append(article)
                    }
                }
                DispatchQueue.main.async {
                    self.tableview.reloadData() // Dispatch queues invoke blocks submitted to them serially in FIFO order.
                        // queue will only invoke one block at a time, but independent queues may each
                   
                }
                
            } catch let error {
                print(error)
            }
            
            
        }
        
        task.resume()
        
    }
    
    
    
    
    
    
    // IndexPath` is  the path to a specific node in a tree of nested array collections.

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "articleCell", for: indexPath) as!ArticleCell
        
        // populates the football articles in tableview
        cell.title.text = self.articless?[indexPath.item].headline
        cell.desc.text = self.articless?[indexPath.item].desc
        cell.imgView.downloadImage(from: (self.articless?[indexPath.item].imageUrl!)!)

        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.articless?.count ?? 0
    }
    // the fun: used to inherit information from selected row and pass it on to the web view
    

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let webVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "web")as! WebviewViewController
        
        
        
        webVC.url = self.articless?[(tableview.indexPathForSelectedRow?.row)!].url
        self.present(webVC, animated: true, completion: nil)
        
    }
    
}
// Downlaod images from the ULR of the API
extension UIImageView {
    
    func downloadImage(from url: String){
        
        let urlRequest = URLRequest(url: URL(string: url)!)
        
        let task = URLSession.shared.dataTask(with: urlRequest) { (data,response,error) in
            
            if error != nil {
                print(error)
                return
            }
            
            DispatchQueue.main.async {
                self.image = UIImage(data: data!)
            }
        }
        task.resume()
    }
}




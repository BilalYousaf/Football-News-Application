//
//  TalkSportViewController.swift
//  FM

//
//  Created by Dione on 05/01/2018.
//  Copyright © 2018 Dione. All rights reserved.

import UIKit

class TalkSportViewController:  UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableview: UITableView!
    
    @IBAction func back(_ sender: Any) {
    }
    
    var articles: [TalkSport]? = []
    override func viewDidLoad() {
        super.viewDidLoad()

        fetchArticles()
    }
    func fetchArticles(){
        let urlRequest = URLRequest(url: URL(string: "https://newsapi.org/v2/top-headlines?sources=talksport&apiKey=5d0f0e3f78ba4a4890ae3ac3e3718ec6")!)
        
        let task = URLSession.shared.dataTask(with: urlRequest) { (data,response,error) in //
            
            
            if error != nil {                 print(error)
                return
            }
            
            
            self.articles = [TalkSport]()
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! [String : AnyObject]
                
                
                print ("Returned JSON = \(json)")
                if let articlesFromJson = json["articles"] as? [[String : AnyObject]] {
                    for articleFromJson in articlesFromJson {
                        let article = TalkSport()
                        if let title = articleFromJson["title"] as? String, let desc = articleFromJson["description"] as? String, let url = articleFromJson["url"] as? String, let urlToImage = articleFromJson["urlToImage"] as? String {
                            
                           
                            article.desc = desc
                            article.headline = title
                            article.url = url
                            article.imageUrl = urlToImage
                        }
                        self.articles?.append(article)
                    }
                }
                DispatchQueue.main.async {
                    self.tableview.reloadData()                                   }
                
            } catch let error {
                print(error)
            }
            
            
        }
        
        task.resume()
        
    }
    
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SportCell", for: indexPath) as!TalksportCell
        
     
        cell.title.text = self.articles?[indexPath.item].headline
        cell.desc.text = self.articles?[indexPath.item].desc
        cell.imgView.downloadImage2(from:(self.articles? [indexPath.item].imageUrl!)!)
        
        
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.articles?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let webVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "web2")as! TalkSportWebViewController
        
        
        
        webVC.url = self.articles?[(tableview.indexPathForSelectedRow?.row)!].url
        self.present(webVC, animated: true, completion: nil)
        
    }
    
}
// downlaod images from the ULR of the API
extension UIImageView {
    
    func downloadImage2(from url: String){
        
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
    

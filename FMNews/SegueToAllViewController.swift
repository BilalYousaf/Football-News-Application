
//
//  Created by Dione on 05/01/2018.
//  Copyright © 2018 Dione. All rights reserved.
//

import UIKit

class SegueToAllViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var tableArray = ["TalkSport", "FourFourTwo"]
    var segueIdentifiers = ["A", "B", "saved"]
 
    override func viewDidLoad() {
        super.viewDidLoad()

        //segue to all view controllers allows users to go to different controllers such as talksport and fourfurtwo
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")! as UITableViewCell
        cell.textLabel?.text = tableArray[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: segueIdentifiers[indexPath.row], sender: self)
        
    }
    
}


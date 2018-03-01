//
//  HomeViewController
//  TwitSplit
//
//  Created by Duc Nguyen on 3/1/18.
//  Copyright © 2018 Duc Nguyen. All rights reserved.
//

import UIKit
import RxSwift
class HomeViewController: UIViewController {

    @IBOutlet weak var twitTextView: UITextView!
    
    @IBOutlet weak var twitButton: UIButton!
    
    @IBOutlet weak var clearButton: UIButton!
    
    @IBOutlet weak var textNumberLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


//
//  HomeViewController
//  TwitSplit
//
//  Created by Duc Nguyen on 3/1/18.
//  Copyright © 2018 Duc Nguyen. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import QuartzCore
class HomeViewController: BaseViewController, UITableViewDelegate {

    @IBOutlet weak var twitTextView: UITextView!
    
    @IBOutlet weak var twitButton: UIButton!
    
    @IBOutlet weak var clearButton: UIButton!
    
    @IBOutlet weak var textNumberLabel: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel : HomeViewModel?
    
//    let items = [0,1,2,3,4,5]
    
    let twitMessageCellIdentifier = "TwitMessageCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set Twit TextView Border Color And Radius
        let borderColor : UIColor = UIColor.lightGray
        twitTextView.layer.borderWidth = 1
        twitTextView.layer.borderColor = borderColor.cgColor
        twitTextView.layer.cornerRadius = 10.0
        
        // This view controller itself will provide the delegate methods and row data for the table view.
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func initViewModel() {
        if(viewModel == nil){
            viewModel = HomeViewModel()
        }
    }
    
    override func initReactive() {
        self.viewModel?.items.value = (0..<20).map { "\($0)" }

        self.viewModel?.items.asObservable()
            .bind(to: tableView.rx.items(cellIdentifier: twitMessageCellIdentifier, cellType: TwitMessageCell.self)) { (row, element, cell) in
                cell.twitMessageLabel?.text = "\(element) @ row \(row)"
                print("\(element) @ row \(row)")
            }
            .disposed(by: disposeBag)


        tableView.rx
            .modelSelected(String.self)
            .subscribe(onNext:  { value in
                print("Tapped `\(value)`")

            })
            .disposed(by: disposeBag)

        tableView.rx
            .itemAccessoryButtonTapped
            .subscribe(onNext: { indexPath in
                print("Tapped Detail @ \(indexPath.section),\(indexPath.row)")
            })
            .disposed(by: disposeBag)
        
    }


}


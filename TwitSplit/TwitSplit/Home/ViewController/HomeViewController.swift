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
    
    let borderWidth : CGFloat = 1.00
    let cornerRadius : CGFloat = 10.0
    let estimationHeight : CGFloat = 300.0
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set Twit TextView Border Color And Radius
        let borderColor : UIColor = UIColor.lightGray
        twitTextView.layer.borderWidth = borderWidth
        twitTextView.layer.borderColor = borderColor.cgColor
        twitTextView.layer.cornerRadius = cornerRadius
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = estimationHeight
        
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

        self.viewModel?.items.asObservable()
            .bind(to: tableView.rx.items(cellIdentifier: twitMessageCellIdentifier, cellType: TwitMessageCell.self)) { (row, element, cell) in
                cell.twitMessageLabel?.text = element
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
        
        self.twitButton.rx.tap.subscribe(onNext: { [weak self] _ in
            let hasError = self?.viewModel?.addNewTwit(message: self?.viewModel?.twitMessage.value ?? "")
            if(hasError == false){
                self?.viewModel?.resetTwitMessage()
            }
            else{
                let alert = UIAlertController(title: NSLocalizedString("AppName", comment: ""), message: NSLocalizedString("ErrorSplitMessage", comment: ""), preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: UIAlertActionStyle.default, handler: nil))
                self?.present(alert, animated: true, completion: nil)
            }
            
        }).disposed(by: disposeBag)
        
        self.clearButton.rx.tap.subscribe(onNext: { [weak self] _ in
            self?.viewModel?.resetTwitMessage()
        }).disposed(by: disposeBag)
        
        _ = self.twitTextView.rx.textInput <-> (self.viewModel?.twitMessage)!
        
        let twitButtonValidation = self.viewModel?.twitMessage.asObservable().map({!$0.isEmpty}).share(replay: 1)
        
        twitButtonValidation?
            .bind(to: self.twitButton.rx.isEnabled)
            .disposed(by: disposeBag)
        
        self.viewModel?.twitMessage.asObservable().subscribe(onNext: { [weak self] (value) in
            self?.textNumberLabel.text = "\(value.count)"
        }, onError: { (error) in
            print(error)
        }, onCompleted: {
            
        }, onDisposed: {
            
        }).disposed(by: disposeBag)
        
    }


}


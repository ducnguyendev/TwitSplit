//
//  HomeViewModel.swift
//  TwitSplit
//
//  Created by Duc Nguyen on 3/1/18.
//  Copyright © 2018 Duc Nguyen. All rights reserved.
//

import Foundation
import RxSwift
struct HomeViewModel{
    var items = Variable([String]())
    var twitMessage : Variable<String> = Variable("I can't believe Tweeter now supports chunking my messages, so I don't have to do it myself.")
    
    func addNewTwit(message : String)  {
        let messageChanks = splitMessage(message: message)
        items.value.insert(contentsOf: messageChanks, at: 0)
    }
    
    func resetTwitMessage(){
        twitMessage.value = ""
    }
    
    func splitMessage(message : String) -> [String] {
        if(message.count < 50){
            return [message]
        }
        let error = "The message contains a span of non-whitespace characters longer than 50 characters"
        var messageChanks = message.ranges(of: "\\b.{1,46}\\s|$\\s*/g", options: .regularExpression).map{message[$0] }
        if(messageChanks.count > 1){
            messageChanks = messageChanks.enumerated().map({ (offset,element) -> Substring in
                let plusString = Substring("\(offset + 1)/\(messageChanks.count) \(element.trim())")
                if(plusString.count > 50){
                    return Substring(error)
                }
                else{
                    return plusString
                }
                
            })
        }
        return messageChanks.map({ text -> String in
            return String(text)
        })
        
    }
    
    
}

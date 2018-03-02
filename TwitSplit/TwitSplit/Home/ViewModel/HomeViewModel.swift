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
    var twitMessage : Variable<String> = Variable("")
    
    func addNewTwit(message : String) -> Bool  {
        let (messageChanks, hasError) = splitMessage(message: message)
        if(hasError == false){
            items.value.insert(contentsOf: messageChanks, at: 0)
        }
        return hasError
    }
    
    func resetTwitMessage(){
        twitMessage.value = ""
    }
    
    func splitMessage(message : String) -> ([String],Bool) {
        if(message.count < 50){
            return ([message],false)
        }
        
        let childStrings = message.split(separator: " ")
        for childSring in childStrings {
            if(childSring.count > 50){
                return([], true)
            }
        }
        var messageChanks = message.ranges(of: "\\b.{1,46}\\s|$\\s*/g", options: .regularExpression).map{message[$0] }
        print(messageChanks)
        if(messageChanks.count > 1){
            messageChanks = messageChanks.enumerated().map({ (offset,element) -> Substring in
                return Substring("\(offset + 1)/\(messageChanks.count) \(element.trim())")
            })
        }
        return (messageChanks.map({ text -> String in
            return String(text)
        }), false)
        
    }
    
    
}

//
//  YBDispatchUtils.swift
//  YBAsyncUtils
//
//  Created by yassine benabbas on 20/03/2016.
//  Copyright © 2016 yostane. All rights reserved.
//

import Foundation

/**
 
 This class contains static functions for using CGD (Grand Central Dispatch). GCD is very verbose and confusing. This class aims to reduce code and makes using GCD more clear.
 
*/
public class YBDispatchUtils: NSObject{
    
    /**
     
     Runs a block of code on the UI thread and waits until the block completes. If the current thread is the UI thread, the block of code simply executes whithout using GCD
     
     - parameter uiBlock: the block to run synchroniously on the UI thread
     
    */
    public static func runOnUISync(uiBlock:() -> Void){
        if(NSThread.isMainThread()){
            uiBlock();
        }else{
            dispatch_sync(dispatch_get_main_queue(), { () -> Void in
                uiBlock();
            })
        }
    }
    
    /**
     
     Posts a block of code on to run on the UI thread. The caller will not wait for the block to finish.
     
     - parameter uiBlock: the block to run asynchroniously on the UI thread
     
    */
    public static func runOnUIAsync(uiBlock:() -> Void){
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            uiBlock();
        })
    }
    
    /**
     
     Posts a block of code on to run on a background thread. You can specify a priority.
     
     - parameter priority: the priority of the block, defaults to DISPATCH_QUEUE_PRIORITY_DEFAULT
     
     - parameter asyncBlock: the block to run asynchroniously in a background thread
     
    */
    public static func runAsync(priority:dispatch_queue_priority_t = DISPATCH_QUEUE_PRIORITY_DEFAULT, asyncBlock:() -> Void){
        dispatch_async(dispatch_get_global_queue(priority, 0)) {
            asyncBlock();
        }
    }

    /**
     
     Posts a block of code on to run on a background thread with default prority.
     
     - parameter asyncBlock: the block to run asynchroniously in a background thread
     
    */
    public static func runAsync(asyncBlock:() -> Void){
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
            asyncBlock();
        }
    }
    
    /**
     
     Posts a block of code on to run on a background thread with default prority. The ui completion block is execute on the UI thread when the asyncBlock completes
     
     - parameter asyncBlock: the block to run asynchroniously in a background thread
     
     - parameter uiCompletionBlock: the block to run asynchroniously on the UI thread when the asyncBlock completes
     
    */
    public static func runAsync(asyncBlock:() -> Void, uiCompletionBlock:() -> Void){
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
            asyncBlock();
            runOnUIAsync({ () -> Void in
                uiCompletionBlock();
            })
        }
    }
    
    /**
     
     Posts a block of code on to run on a background thread with a specified priority. The ui completion block is execute on the UI thread when the asyncBlock completes
     
     - parameter priority: the priority of the block, defaults to DISPATCH_QUEUE_PRIORITY_DEFAULT
     
     - parameter asyncBlock: the block to run asynchroniously in a background thread
     
     - parameter uiCompletionBlock: the block to run asynchroniously on the UI thread when the asyncBlock completes
     
    */
    public static func runAsync(priority:dispatch_queue_priority_t = DISPATCH_QUEUE_PRIORITY_DEFAULT, asyncBlock:() -> Void, uiCompletionBlock:()->Void){
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
            asyncBlock();
            runOnUIAsync({ () -> Void in
                uiCompletionBlock()
            })
        }
    }
}


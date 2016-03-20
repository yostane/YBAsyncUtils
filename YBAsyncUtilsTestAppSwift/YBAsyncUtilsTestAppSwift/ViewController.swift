//
//  ViewController.swift
//  YBAsyncUtils
//
//  Created by yassine benabbas on 20/03/2016.
//  Copyright © 2016 yostane. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var loadingIndocator: UIActivityIndicatorView!
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        // Do any additional setup after loading the view, typically from a nib.
        
        YBDispatchUtils.runAsync(asyncBlock: {
            print("start 1")
            sleep(1)
            print("end 1")
        })
        
        loadingIndocator.startAnimating()
        YBDispatchUtils.runAsync({ () -> Void in
            print("start 2")
            sleep(1)
            print("end 2")
            }, uiCompletionBlock: { () -> Void in
                self.loadingIndocator.stopAnimating()
                print("done 2")
        })
        
        YBDispatchUtils.runAsync({ () -> Void in
            print("start 3")
            sleep(1)
            print("end 3")
            YBDispatchUtils.runOnUIAsync({ () -> Void in
                print("I am on ui thread 3")
            })
            print("done 3")
        })
        
        YBDispatchUtils.runAsync({ () -> Void in
            print("start 4")
            sleep(1)
            print("end 4")
            YBDispatchUtils.runOnUISync({ () -> Void in
                print("I am on ui thread 4")
            })
            print("done 4")
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


//
//  LoadingViewController.swift
//  LoadingUIExample
//
//  Created by Samantha Gatt on 9/19/18.
//  Copyright © 2018 Samantha Gatt. All rights reserved.
//

import Foundation
import LoadingUIFramework


class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        loadingView = LoadingView(frame: CGRect(x: view.center.x, y: view.center.y, width: 100, height: 100))
//        loadingView?.strokeColor = UIColor.green.cgColor
//
//        if let loadingView = loadingView {
//            view.addSubview(loadingView)
//        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        loadingView.animate()
    }
    
    @IBOutlet weak var loadingView: LoadingView!
    
}

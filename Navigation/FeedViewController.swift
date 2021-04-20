//
//  ViewController.swift
//  Navigation
//
//  Created by Artem Novichkov on 12.09.2020.
//  Copyright © 2020 Artem Novichkov. All rights reserved.
//

import UIKit

final class FeedViewController: UIViewController {
    
    let post: Post = Post(title: "Пост")
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        print(type(of: self), #function)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        print(type(of: self), #function)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(type(of: self), #function)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print(type(of: self), #function)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print(type(of: self), #function)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print(type(of: self), #function)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print(type(of: self), #function)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        print(type(of: self), #function)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        print(type(of: self), #function)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "post" else {
            return
        }
        guard let postViewController = segue.destination as? PostViewController else {
            return
        }
        postViewController.post = post
    }
    
    lazy var firtsStackViewButton: UIButton = {
        let fButton = UIButton()
        
        return fButton
    }()
/*
     Попытка сделать доп.задание программно:
     
     lazy var secondStackViewButton: UIButton = {
         let sButton = UIButton()
         
         return sButton
     }()
     
     lazy var newStackView: UIStackView = {
         let stack = UIStackView(frame: self.view.bounds)
         stack.axis = .vertical
         
         stack.distribution = .fillEqually
         stack.alignment = .fill
         stack.spacing = 10
         stack.autoresizingMask = [.flexibleWidth, .flexibleHeight]
                 
         stack.addArrangedSubview(self.firtsStackViewButton)
         stack.addArrangedSubview(self.secondStackViewButton)
         
         return stack
     }()
     
     */
}

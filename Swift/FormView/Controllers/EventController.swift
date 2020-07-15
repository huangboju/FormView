//
//  EventController.swift
//  FormView
//
//  Created by jourhuang on 2020/7/14.
//  Copyright © 2020 黄伯驹. All rights reserved.
//

import UIKit

class EventController: UIViewController {
    
    var singleTapGesture: UITapGestureRecognizer?
    var doubleTapGesture: UITapGestureRecognizer?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        initGestures()
        initSubviews()
    }

    func initSubviews() {
        let eventView = UIView()
        eventView.backgroundColor = .blue
        view.addSubview(eventView)
        eventView.translatesAutoresizingMaskIntoConstraints = false
        eventView.widthAnchor.constraint(equalToConstant: 200).isActive = true
        eventView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        eventView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        eventView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        let singleTapGesture = UITapGestureRecognizer(target: self, action: #selector(handleSingleTap1))
        singleTapGesture.delegate = self
        singleTapGesture.numberOfTapsRequired = 1
        singleTapGesture.numberOfTouchesRequired = 1
        singleTapGesture.name = "singleBlue"
        eventView.addGestureRecognizer(singleTapGesture)
        self.singleTapGesture = singleTapGesture

        let doubleTapGesture = UITapGestureRecognizer(target: self, action: #selector(handleDoubleTap1))
        doubleTapGesture.numberOfTapsRequired = 2
        doubleTapGesture.numberOfTouchesRequired = 1
        doubleTapGesture.name = "doubleBlue"
        doubleTapGesture.delegate = self
        self.doubleTapGesture = doubleTapGesture
        eventView.addGestureRecognizer(doubleTapGesture)

        singleTapGesture.require(toFail: doubleTapGesture)
    }

    func initGestures() {
        let eventView = UIView()
        eventView.backgroundColor = .red
        view.addSubview(eventView)
        eventView.translatesAutoresizingMaskIntoConstraints = false
        eventView.widthAnchor.constraint(equalToConstant: 300).isActive = true
        eventView.heightAnchor.constraint(equalToConstant: 300).isActive = true
        eventView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        eventView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true

        let singleTapGesture = UITapGestureRecognizer(target: self, action: #selector(handleSingleTap))
        singleTapGesture.numberOfTapsRequired = 1
        singleTapGesture.numberOfTouchesRequired = 1
        singleTapGesture.name = "singleRed"
        eventView.addGestureRecognizer(singleTapGesture)

        let doubleTapGesture = UITapGestureRecognizer(target: self, action: #selector(handleDoubleTap))
        doubleTapGesture.numberOfTapsRequired = 2
        doubleTapGesture.numberOfTouchesRequired = 1
        doubleTapGesture.name = "doubleRed"
        eventView.addGestureRecognizer(doubleTapGesture)

        singleTapGesture.require(toFail: doubleTapGesture)
        
        let pan = UIPanGestureRecognizer(target: self, action: #selector(handlePan))
        eventView.addGestureRecognizer(pan)
    }
    
    @objc
    func handlePan(_ sender: UIPanGestureRecognizer) {
        print("🥶🥶🥶🥶🥶🥶")
    }
    
    @objc
    func handleDoubleTap(_ sender: UITapGestureRecognizer) {
        print("🍀🍀🍀🍀🍀🍀🍀🍀")
    }

    @objc
    func handleSingleTap(_ sender: UITapGestureRecognizer) {
        NSObject.cancelPreviousPerformRequests(withTarget: self)
        print("😀😀😀😀😀😀😀😀")
    }
    
    func performTap() {
        
    }
    
    @objc
    func handleDoubleTap1(_ sender: UITapGestureRecognizer) {
        print("🍑🍑🍑🍑🍑🍑🍑🍑🍑")
    }

    @objc
    func handleSingleTap1(_ sender: UITapGestureRecognizer) {
        print("🐖🐖🐖🐖🐖🐖🐖🐖🐖")
    }
}

extension EventController: UIGestureRecognizerDelegate {
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        print(gestureRecognizer)
        return gestureRecognizer !== doubleTapGesture
    }
}

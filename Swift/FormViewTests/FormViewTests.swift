//
//  FormViewTests.swift
//  FormViewTests
//
//  Created by 黄伯驹 on 20/01/2018.
//  Copyright © 2018 黄伯驹. All rights reserved.
//

import XCTest
@testable import FormView

class FormViewTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        
    }
    
    func testPerformanceExample() {
        let arr = (0..<10000).map { _ -> Int in
            let n = Int(arc4random_uniform(10000))
            return n
        }
        
        self.measure {
            _ = insertionSort(arr)
        }
    }
    
    func insertionSort(_ array: [Int]) -> [Int] {
        var a = array             // 1
        for x in 1..<a.count {         // 2
            var y = x
            while y > 0 && a[y] < a[y - 1] { // 3
                a.swapAt(y - 1, y)
                y -= 1
            }
        }
        return a
    }
    
}

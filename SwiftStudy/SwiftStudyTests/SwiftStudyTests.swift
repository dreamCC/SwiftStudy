//
//  SwiftStudyTests.swift
//  SwiftStudyTests
//
//  Created by Zhu ChaoJun on 2020/12/9.
//  Copyright © 2020 Zhu ChaoJun. All rights reserved.
//

import XCTest
@testable import SwiftStudy

class SwiftStudyTests: XCTestCase {

    override func setUpWithError() throws {
        print("setUpWithError：一般用于做一些初始化操作，每个test方法调用前，会进行一次调用")
    }

    override func tearDownWithError() throws {
        print("tearDownWithError：每个test方法调用完成后，会进行一次调用")

    }

    func testExample() throws {
        print("testExample：测试方法，测试方法以test开头")
        let result = RegexUtil.isPhone("17720501596")
        XCTAssertTrue(result)
    }
    
    func testIfModel() throws {
        let result = RegexUtil.isPwd("5681")
        XCTAssertTrue(result)
    }

    func testPerformanceExample() throws {
        print("testPerformanceExample：主要用来进行性能测试")
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}

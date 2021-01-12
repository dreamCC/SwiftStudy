//
//  RegexTests.swift
//  SwiftStudyTests
//
//  Created by Zhu ChaoJun on 2021/1/4.
//  Copyright © 2021 Zhu ChaoJun. All rights reserved.
//

import XCTest
@testable import SwiftStudy

class RegexTests: XCTestCase {

    override func setUpWithError() throws {

    }

    override func tearDownWithError() throws {

    }

    func testIsPhone() throws {
        
        let isPhone = RegexUtil.isPhone("17720402102")
        XCTAssertTrue(isPhone)
        
        
    }
    

    func testIsPwd() throws {
        
        let isPwd = RegexUtil.isPwd("1246")
        XCTAssertTrue(isPwd, "不是密码----")
    }


}

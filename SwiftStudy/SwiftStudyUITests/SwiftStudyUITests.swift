//
//  SwiftStudyUITests.swift
//  SwiftStudyUITests
//
//  Created by Zhu ChaoJun on 2021/1/4.
//  Copyright © 2021 Zhu ChaoJun. All rights reserved.
//

import XCTest
@testable import SwiftStudy

class SwiftStudyUITests: XCTestCase {

    
    override func setUpWithError() throws {
        // 同样做一些配置操作。
        // 每次调用test方法前，会进行一次调用
        continueAfterFailure = false
        print("setUpWithError：一般用于做一些初始化操作，每个test方法调用前，会进行一次调用")

     
    }

    override func tearDownWithError() throws {
        // 每次调用test方法后，会进行一次调用
        print("tearDownWithError：一般用于做一些初始化操作，每个test方法调用后，会进行一次调用")

    }

    // 测试方法。
    func testExample() throws {
        // UI tests must launch the application that they test.

       
        let app = XCUIApplication()
        app.launch()
        
        app.tabBars["Tab Bar"].buttons["Contacts"].tap()
    
        let tablesQuery = app.tables
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["SystermUtil"]/*[[".cells.staticTexts[\"SystermUtil\"]",".staticTexts[\"SystermUtil\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Multithreading"]/*[[".cells.staticTexts[\"Multithreading\"]",".staticTexts[\"Multithreading\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Thread"]/*[[".cells.staticTexts[\"Thread\"]",".staticTexts[\"Thread\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
    }
    
    func testB() throws {
        // UI tests must launch the application that they test.

       
        let app = XCUIApplication()
        app.launch()
        
        app.tabBars["Tab Bar"].buttons["Contacts"].tap()
    
        let tablesQuery = app.tables
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["SystermUtil"]/*[[".cells.staticTexts[\"SystermUtil\"]",".staticTexts[\"SystermUtil\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Multithreading"]/*[[".cells.staticTexts[\"Multithreading\"]",".staticTexts[\"Multithreading\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Thread"]/*[[".cells.staticTexts[\"Thread\"]",".staticTexts[\"Thread\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}

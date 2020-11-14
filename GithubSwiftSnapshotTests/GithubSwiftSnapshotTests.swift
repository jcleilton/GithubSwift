//
//  GithubSwiftSnapshotTests.swift
//  GithubSwiftSnapshotTests
//
//  Created by Cleilton Feitosa on 14/11/20.
//  Copyright © 2020 Cleilton Feitosa. All rights reserved.
//

import XCTest
import FBSnapshotTestCase

@testable import GithubSwift

class GithubSwiftSnapshotTests: FBSnapshotTestCase {

    override func setUpWithError() throws {
        try super.setUpWithError()
        super.setUp()
//        usesDrawViewHierarchyInRect = true
        fileNameOptions = [.device, .screenSize]
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
    }

    func testMainScreen() throws {
        
    }
}

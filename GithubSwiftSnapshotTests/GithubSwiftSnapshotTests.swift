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
    override func setUp() {
        super.setUp()
        
        recordMode = false
//        usesDrawViewHierarchyInRect = true
        fileNameOptions = [.device, .screenSize]
    }

    override func tearDown() {
        super.tearDown()
    }

    func testMainScreen() throws {
        let viewModel = DetailViewModel(model: MainModel(
                                            userID: 1,
                                            authorPhotoURL: "",
                                            authorName: "Test",
                                            repoID: 1,
                                            repoName: "Test",
                                            stargazersCount: 1,
                                            itemDescription: "Test",
                                            sshURL: "",
                                            cloneURL: "",
                                            score: 1), imageData: UIImage(named: "placeholder")?.pngData() ?? Data())
        let sut = DetailViewController(viewModel: viewModel)
        sut.beginAppearanceTransition(true, animated: false)
        sut.endAppearanceTransition()
        
        FBSnapshotVerifyView(sut.view)
    }
}

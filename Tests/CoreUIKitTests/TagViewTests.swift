//
//  TagViewTests.swift
//  CoreUIKit
//
//  Created by Anderson Oliveira on 29/08/25.
//

import XCTest
import SnapshotTesting
@testable import CoreUIKit

final class TagViewTests: XCTestCase {

    var record: SnapshotTestingConfiguration.Record!

    override func setUp() {
        super.setUp()
        record = .never
    }

    override func tearDown() {
        super.tearDown()
        record = nil
    }

    @MainActor
    func testTagView_LightMode() {
        let tagView = configureTagView(color: nil)
        tagView.overrideUserInterfaceStyle = .light

        withSnapshotTesting(record: record, diffTool: .ksdiff) {
            assertSnapshot(of: tagView, as: .image)
        }
    }

    @MainActor
    func testTagView_DarkMode() {
        let tagView = configureTagView(color: nil)
        tagView.overrideUserInterfaceStyle = .light

        withSnapshotTesting(record: record, diffTool: .ksdiff) {
            assertSnapshot(of: tagView, as: .image)
        }
    }

    @MainActor
    func testTagView_WithLightBackgroundColor() {
        let tagView = configureTagView(color: .systemBackground)
        tagView.overrideUserInterfaceStyle = .light

        withSnapshotTesting(record: record, diffTool: .ksdiff) {
            assertSnapshot(of: tagView, as: .image)
        }
    }

    @MainActor
    func testTagView_WithDarkBackgroundColor() {
        let tagView = configureTagView(color: .systemBackground)
        tagView.overrideUserInterfaceStyle = .dark

        withSnapshotTesting(record: record, diffTool: .ksdiff) {
            assertSnapshot(of: tagView, as: .image)
        }
    }

    
    @MainActor
    private func configureTagView(color: UIColor?) -> TagView {
        let tagView = TagView()
        tagView.setupView(title: "Suspense")
        tagView.translatesAutoresizingMaskIntoConstraints = false
        tagView.backgroundColor = color
        tagView.setNeedsLayout()
        tagView.layoutIfNeeded()
        return tagView
    }
}

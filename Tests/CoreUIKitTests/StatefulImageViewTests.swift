//
//  StatefulImageViewTests.swift
//  CoreUIKit
//
//  Created by Anderson Oliveira on 29/08/25.
//

import XCTest
import SnapshotTesting
@testable import CoreUIKit

final class StatefulImageViewTests: XCTestCase {

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
    func testStatefulImageView_Loading() {
        let statefulImageView = configureStatefulImageView()
        statefulImageView.state = .loading
        statefulImageView.overrideUserInterfaceStyle = .light

        withSnapshotTesting(record: record, diffTool: .ksdiff) {
            assertSnapshot(of: statefulImageView, as: .image)
        }
    }

    @MainActor
    func testStatefulImageView_Empty_WithPlaceholder() {
        let statefulImageView = configureStatefulImageView()
        statefulImageView.state = .empty

        withSnapshotTesting(record: record, diffTool: .ksdiff) {
            assertSnapshot(of: statefulImageView, as: .image)
        }
    }

    @MainActor
    func testStatefulImageView_Empty_WithoutPlaceholder() {
        let statefulImageView = configureStatefulImageView(placeholder: nil)
        statefulImageView.state = .empty

        withSnapshotTesting(record: record, diffTool: .ksdiff) {
            assertSnapshot(of: statefulImageView, as: .image)
        }
    }

    @MainActor
    func testStatefulImageView_Success() {
        let statefulImageView = configureStatefulImageView()
        statefulImageView.state = .success(image: UIImage(named: "poster_test", in: Bundle.module, with: nil)!)

        withSnapshotTesting(record: record, diffTool: .ksdiff) {
            assertSnapshot(of: statefulImageView, as: .image(size: CGSize(width: 150, height: 225)))
        }
    }
    
    @MainActor
    private func configureStatefulImageView(placeholder: UIImage? = UIImage(named: "default_movie_poster", in: Bundle.module, with: nil)) -> StatefulImageView {
        let statefulImageView = StatefulImageView()

        statefulImageView.translatesAutoresizingMaskIntoConstraints = false
        statefulImageView.widthAnchor.constraint(equalToConstant: 150).isActive = true
        statefulImageView.heightAnchor.constraint(equalToConstant: 225).isActive = true

        statefulImageView.placeholderImage = placeholder
        return statefulImageView
    }
}

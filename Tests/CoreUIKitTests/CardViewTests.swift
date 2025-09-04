//
//  CardViewTests.swift
//  CoreUIKit
//
//  Created by Anderson Oliveira on 29/08/25.
//

import XCTest
import SnapshotTesting
@testable import CoreUIKit

final class CardViewTests: XCTestCase {
    
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
    func testCardView_LightMode() {
        let cardView = configureCardView()
        cardView.overrideUserInterfaceStyle = .light
        
        withSnapshotTesting(record: record, diffTool: .ksdiff) {
            assertSnapshot(of: cardView, as: .image)
        }
    }

    @MainActor
    func testCardView_DarkMode() {
        let cardView = configureCardView()
        cardView.overrideUserInterfaceStyle = .dark
        
        withSnapshotTesting(record: record, diffTool: .ksdiff) {
            assertSnapshot(of: cardView, as: .image)
        }
    }

    @MainActor
    func testLargerCardView_DarkMode_ImageLoading() {
        let cardView = configureCardView()
        cardView.overrideUserInterfaceStyle = .dark
        cardView.startLoading()
        
        withSnapshotTesting(record: record, diffTool: .ksdiff) {
            assertSnapshot(of: cardView, as: .image)
        }
    }

    @MainActor
    func testLargerCardView_DarkMode_WithoutImage() {
        let cardView = configureCardView(poster: nil)
        cardView.overrideUserInterfaceStyle = .dark
        
        withSnapshotTesting(record: record, diffTool: .ksdiff) {
            assertSnapshot(of: cardView, as: .image)
        }
    }

    @MainActor
    private func configureCardView(poster: UIImage? = UIImage(named: "poster_test", in: Bundle.module, with: nil)) -> CardView {
        let cardView = CardView()

        cardView.translatesAutoresizingMaskIntoConstraints = false
        cardView.asView().heightAnchor.constraint(equalToConstant: 300).isActive = true

        cardView.placeholderImage = UIImage(named: "default_movie_poster", in: Bundle.module, with: nil)
        cardView.setupView(poster: poster,
                           title: "Up",
                           releaseDate: "2023")
        cardView.setNeedsLayout()
        cardView.layoutIfNeeded()
        return cardView
    }
}

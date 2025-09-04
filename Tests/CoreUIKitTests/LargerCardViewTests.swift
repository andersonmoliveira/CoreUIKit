//
//  LargerCardViewTests.swift
//  CoreUIKit
//
//  Created by Anderson Oliveira on 29/08/25.
//

import XCTest
import SnapshotTesting
@testable import CoreUIKit

final class LargerCardViewTests: XCTestCase {
    
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
    func testLargerCardView_LightMode() {
        let largerCardView = configureLargerCardView()
        largerCardView.overrideUserInterfaceStyle = .light
        
        withSnapshotTesting(record: record, diffTool: .ksdiff) {
            assertSnapshot(of: largerCardView, as: .image)
        }
    }
    
    @MainActor
    func testLargerCardView_DarkMode() {
        let largerCardView = configureLargerCardView()
        largerCardView.overrideUserInterfaceStyle = .dark
        
        withSnapshotTesting(record: record, diffTool: .ksdiff) {
            assertSnapshot(of: largerCardView, as: .image)
        }
    }
    
    @MainActor
    func testLargerCardView_DarkMode_WithoutBackdrop() {
        let largerCardView = configureLargerCardView(backdrop: nil)
        largerCardView.overrideUserInterfaceStyle = .dark
        
        withSnapshotTesting(record: record, diffTool: .ksdiff) {
            assertSnapshot(of: largerCardView, as: .image)
        }
    }
    
    @MainActor
    func testLargerCardView_DarkMode_WithoutPoster() {
        let largerCardView = configureLargerCardView(poster: nil)
        largerCardView.overrideUserInterfaceStyle = .dark
        
        withSnapshotTesting(record: record, diffTool: .ksdiff) {
            assertSnapshot(of: largerCardView, as: .image)
        }
    }
    
    @MainActor
    func testLargerCardView_DarkMode_WithoutOverview() {
        let largerCardView = configureLargerCardView(overview: nil)
        largerCardView.overrideUserInterfaceStyle = .dark
        
        withSnapshotTesting(record: record, diffTool: .ksdiff) {
            assertSnapshot(of: largerCardView, as: .image)
        }
    }

    @MainActor
    func testLargerCardView_DarkMode_BackdropLoading() {
        let largerCardView = configureLargerCardView()
        largerCardView.startLoading(type: .backdrop)
        largerCardView.overrideUserInterfaceStyle = .dark
        
        withSnapshotTesting(record: record, diffTool: .ksdiff) {
            assertSnapshot(of: largerCardView, as: .image)
        }
    }

    @MainActor
    func testLargerCardView_DarkMode_PosterLoading() {
        let largerCardView = configureLargerCardView()
        largerCardView.startLoading(type: .poster)
        largerCardView.overrideUserInterfaceStyle = .dark
        
        withSnapshotTesting(record: record, diffTool: .ksdiff) {
            assertSnapshot(of: largerCardView, as: .image)
        }
    }

    @MainActor
    private func configureLargerCardView(backdrop: UIImage? = UIImage(named: "backdrop_test", in: Bundle.module, with: nil),
                                         poster: UIImage? = UIImage(named: "poster_test", in: Bundle.module, with: nil),
                                         overview: String? = """
            Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam eget ligula eu lectus lobortis condimentum. Aliquam nonummy auctor massa. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Nulla at risus. Quisque purus magna, auctor et, sagittis ac, posuere eu, lectus. Nam mattis, felis ut adipiscing.
            """) -> LargerCardView {
        let largerCardView = LargerCardView()

        largerCardView.translatesAutoresizingMaskIntoConstraints = false
        largerCardView.widthAnchor.constraint(equalToConstant: 400).isActive = true

        largerCardView.backdropPlaceholderImage = UIImage(named: "default_movie_backdrop", in: Bundle.module, with: nil)
        largerCardView.posterPlaceholderImage = UIImage(named: "default_movie_poster", in: Bundle.module, with: nil)
        largerCardView.setupView(
            backdrop: backdrop,
            poster: poster,
            title: "Como Treinar Seu Dragão",
            releaseDate: "2023",
            rating: "7,5",
            overview: overview
        )
        largerCardView.setNeedsLayout()
        largerCardView.layoutIfNeeded()
        return largerCardView
    }
}

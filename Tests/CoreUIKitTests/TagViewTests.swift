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

    func testTagView_LightMode() {
        let tagView = configureTagView(color: nil)

        withSnapshotTesting(record: record, diffTool: .ksdiff) {
            assertSnapshot(of: tagView, as: .image)
        }
    }

    func testTagView_DarkMode() {
        let tagView = configureTagView(color: nil)
        tagView.overrideUserInterfaceStyle = .light

        withSnapshotTesting(record: record, diffTool: .ksdiff) {
            assertSnapshot(of: tagView, as: .image)
        }
    }

    func testTagView_WithLightBackgroundColor() {
        let tagView = configureTagView(color: .systemBackground)

        withSnapshotTesting(record: record, diffTool: .ksdiff) {
            assertSnapshot(of: tagView, as: .image)
        }
    }

    func testTagView_WithDarkBackgroundColor() {
        let tagView = configureTagView(color: .systemBackground)
        tagView.overrideUserInterfaceStyle = .dark

        withSnapshotTesting(record: record, diffTool: .ksdiff) {
            assertSnapshot(of: tagView, as: .image)
        }
    }

    
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

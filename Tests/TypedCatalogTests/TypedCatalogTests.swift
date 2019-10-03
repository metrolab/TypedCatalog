import XCTest
import class Foundation.Bundle

final class TypedCatalogTests: XCTestCase {
    func testFailsWithoutParameters() throws {
        guard #available(macOS 10.13, *) else {
            fatalError("Some of the APIs that we use below are available in macOS 10.13 and above")
        }

        let fooBinary = productsDirectory.appendingPathComponent("TypedCatalog")

        let process = Process()
        process.executableURL = fooBinary

        try process.run()
        process.waitUntilExit()

        XCTAssertEqual(process.terminationReason, .uncaughtSignal)
        XCTAssertEqual(process.terminationStatus, 4)
    }

    /// Returns path to the built products directory.
    var productsDirectory: URL {
      #if os(macOS)
        for bundle in Bundle.allBundles where bundle.bundlePath.hasSuffix(".xctest") {
            return bundle.bundleURL.deletingLastPathComponent()
        }
        fatalError("couldn't find the products directory")
      #else
        return Bundle.main.bundleURL
      #endif
    }

    static var allTests = [
        ("testFailsWithoutParameters", testFailsWithoutParameters),
    ]
}

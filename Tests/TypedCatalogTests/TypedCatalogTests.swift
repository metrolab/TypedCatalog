import XCTest
import class Foundation.Bundle

final class TypedCatalogTests: XCTestCase {
    func testUsage() throws {
        guard #available(macOS 10.13, *) else {
            fatalError("Some of the APIs that we use below are available in macOS 10.13 and above")
        }

        let fooBinary = productsDirectory.appendingPathComponent("TypedCatalog")

        let process = Process()
        process.executableURL = fooBinary

        let pipe = Pipe()
        process.standardOutput = pipe

        try process.run()
        process.waitUntilExit()

        let data = pipe.fileHandleForReading.readDataToEndOfFile()
        guard let output = String(data: data, encoding: .utf8) else { fatalError("output cannot be nil") }

        XCTAssertTrue(output.hasPrefix("\nUsage: "))
        XCTAssertTrue(output.hasSuffix("/TypedCatalog     -path path_to_asset_catalog     -exportPath output_path     -bundleName bundle_asset_catalog_belongs_to     -bundleAssociatedClass some_class_inside_bundle     -enumName generated_enum_name\n\n"))
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
        ("testUsage", testUsage),
    ]
}

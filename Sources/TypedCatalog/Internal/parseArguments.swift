import Foundation

typealias Arguments = (assetPath: String, outputPath: String, enumName: String, bundleName: String, bundleAssociatedClass: String)

func parseArguments(userDefaults: UserDefaults = UserDefaults.standard, command: String = CommandLine.arguments[0]) throws -> Arguments {
    func printUsage() {
        let usage = """
        \nUsage: \(command) \\
            -path path_to_asset_catalog \\
            -exportPath output_path \\
            -bundleName bundle_asset_catalog_belongs_to \\
            -bundleAssociatedClass some_class_inside_bundle \\
            -enumName generated_enum_name\n
        """
        print(usage)
    }

    guard let assetPath = userDefaults.string(forKey: "path") else {
        printUsage()
        throw ParseArgumentsError.missingPath
    }
    guard let outputPath = userDefaults.string(forKey: "exportPath") else {
        printUsage()
        throw ParseArgumentsError.missingExportPath
    }
    guard let bundleName = userDefaults.string(forKey: "bundleName") else {
        printUsage()
        throw ParseArgumentsError.missingBundleName
    }

    // enumName is optional and "ImageAsset" is used for enum as default value.
    let enumName = userDefaults.string(forKey: "enumName") ?? "ImageAsset"

    // bundleAssociatedClass is optional and "_TypedCatalog" is used for enum as default value.
    let bundleAssociatedClass = userDefaults.string(forKey: "bundleAssociatedClass") ?? "_TypedCatalog"

    return Arguments(assetPath: assetPath,
                     outputPath: outputPath,
                     enumName: enumName,
                     bundleName: bundleName,
                     bundleAssociatedClass: bundleAssociatedClass)
}

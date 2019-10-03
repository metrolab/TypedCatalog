import Foundation

extension UserDefaults {
    var arguments: (String, String, String, String, String) {
        guard let assetPath = string(forKey: "path") else {
            fatalError("An asset catalog path must be specified by \"-path\".")
        }
        guard let outputPath = string(forKey: "exportPath") else {
            fatalError("An output path must be specified by \"-exportPath\".")
        }
        guard let bundleName = string(forKey: "bundleName") else {
            fatalError("A bundle name must be specified by \"-bundleName\".")
        }
        guard let bundleAssociatedClass = string(forKey: "bundleAssociatedClass") else {
            fatalError("A bundle associated class must be specified by \"-bundleAssociatedClass\".")
        }
        // enumName is optional and "ImageAsset" is used for enum as default value.
        let enumName = string(forKey: "enumName") ?? "ImageAsset"
        return (assetPath, outputPath, enumName, bundleName, bundleAssociatedClass)
    }
}

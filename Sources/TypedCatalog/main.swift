import Foundation

let (path, exportPath, enumName, bundleName, bundleAssociatedClass) = UserDefaults.standard.arguments

let imagesets = try FileManager.default.imagesets(inAssetsPath: path)
guard !imagesets.isEmpty else {
    fatalError("\n[Error] No imageset is found and failed to export a file...\n")
}

let succeeded = build(imagesets, exportPath, enumName, bundleName, bundleAssociatedClass)
if succeeded {
    print("\nSucceeded to generate enum and UIImage extension file at \(exportPath).\n")
} else {
    fatalError("\n[Error] Failed to generate enum and UIImage extension file at \(exportPath).\n")
}



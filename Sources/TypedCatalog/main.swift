import Foundation

let arguments = try parseArguments()

let imagesets = try FileManager.default.imagesets(inAssetsPath: arguments.assetPath)

guard !imagesets.isEmpty else {
    fatalError("\n[Error] No imageset is found and failed to export a file...\n")
}

let succeeded = build(assets: imagesets,
                      exportPath: arguments.outputPath,
                      enumName: arguments.enumName,
                      bundleName: arguments.bundleName,
                      associatedClass: arguments.bundleAssociatedClass)

if succeeded {
    print("\nSucceeded to generate enum and UIImage extension file at \(arguments.outputPath).\n")
} else {
    fatalError("\n[Error] Failed to generate enum and UIImage extension file at \(arguments.outputPath).\n")
}

import Foundation

func build(_ assets: [String], _ exportPath: String, _ enumName: String, _ bundleName: String, _ associatedClass: String) -> Bool {
    let indent = "    " // indent is 4 spaces
    var cases = ""
    let suffixes = ["driver", "passenger"]
    var suffixedAssetsList = Set<String>()
    let suffix_separator = "_"

    assets.forEach { asset in
        cases += indent + "case \(asset)\n"
        suffixes.forEach { suffix in
            let completeSuffix = "\(suffix_separator)\(suffix)"
            if asset.hasSuffix(completeSuffix) {
                suffixedAssetsList.insert(asset.replacingOccurrences(of: completeSuffix, with: ""))
            }
        }
    }

    var suffixedContent: String = ""
    enum test: String {
        case hereby
        case hoy
    }

    if !suffixedAssetsList.isEmpty {
        let cases = suffixedAssetsList.sorted().joined(separator: ", ")
        suffixedContent =
"""
\n
    // MARK: - Suffixed assets :
    public enum \(enumName)Suffixed: String {
        case \(cases)
    }

    public static func suffixed(_ asset: \(enumName)Suffixed, with suffix: String) -> UIImage! {
        let assetName = asset.rawValue + "\(suffix_separator)" + suffix
        let imageEnum: \(enumName) = \(enumName)(rawValue: assetName)!
        return imageEnum.image
    }
"""
    }

    let file: String =
"""
// Generated with Misen by tasanobu - Modules/CommonUI/Scripts/misen.swift
// DO NOT EDIT

import UIKit

// MARK: - \(enumName) Asset Catalog

public enum \(enumName): String {
\(cases)
    private static let bundle: Bundle? = {
        guard let path = Bundle(for: \(associatedClass).self).path(forResource: "\(bundleName)", ofType: "bundle") else { return nil }
        return Bundle(path: path)
    }()

    private func imageWithRenderingMode(_ mode: UIImage.RenderingMode) -> UIImage? {
        guard let bundle = \(enumName).bundle else { return nil }
        // swiftlint:disable:next image_init
        let image = UIImage(named: self.rawValue, in: bundle, compatibleWith: nil)
        return image?.withRenderingMode(mode)
    }

    public var image: UIImage! {
        return imageWithRenderingMode(.alwaysOriginal)
    }

    public var template: UIImage! {
        return imageWithRenderingMode(.alwaysTemplate)
    }\(suffixedContent)
}

"""
    let data = file.data(using: String.Encoding.utf8, allowLossyConversion: false)
    return FileManager.default.createFile(atPath: exportPath, contents: data, attributes: nil)
}

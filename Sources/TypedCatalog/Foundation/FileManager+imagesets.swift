import Foundation

extension FileManager {
    func imagesets(inAssetsPath path: String) throws -> [String] {
        // let's remove white spaces and dashes from asset name. e.g My Image.imagesets, My-Image.imagesets into My_Image
        let normalize = { (asset: String) -> String in
            if let regex = try? NSRegularExpression(pattern: "\\s|-", options: .caseInsensitive) {
                let range = NSRange(location: 0, length: asset.count)
                return regex.stringByReplacingMatches(in: asset, options: .withTransparentBounds, range: range, withTemplate: "_")
            }
            return asset
        }
        let subpaths = try subpathsOfDirectory(atPath: path)
        return subpaths
            .filter {
                $0.hasSuffix("imageset")
        }
        .map {
            normalize(($0 as NSString).lastPathComponent.components(separatedBy: ".")[0])
        }
    }
}

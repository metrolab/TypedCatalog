import Foundation

func build(assets: [String], exportPath: String, enumName: String, bundleName: String, associatedClass: String) -> Bool {
    let indent = "    " // indent is 4 spaces
    var cases = ""

    assets.forEach { asset in
        cases += indent + "case \(asset)\n"
    }

    let file = template(enumName: enumName,
                        cases: cases,
                        associatedClass: associatedClass,
                        bundleName: bundleName)

    let data = file.data(using: String.Encoding.utf8, allowLossyConversion: false)
    return FileManager.default.createFile(atPath: exportPath, contents: data, attributes: nil)
}

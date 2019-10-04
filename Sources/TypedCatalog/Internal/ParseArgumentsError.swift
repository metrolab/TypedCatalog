import Foundation

enum ParseArgumentsError: Int, Swift.Error, CustomNSError {
    case missingPath
    case missingExportPath
    case missingBundleName

    static var errorDomain: String {
        return (String(#file) as NSString).lastPathComponent
    }

    var errorCode: Int {
        return rawValue
    }

    var errorUserInfo: [String: Any] {
        return [:]
    }

    private var localizedDescription: String {
        switch self {
        case .missingPath: return "An asset catalog path must be specified by \"-path\"."
        case .missingExportPath: return "An output path must be specified by \"-exportPath\"."
        case .missingBundleName: return "A bundle name must be specified by \"-bundleName\"."
        }
    }
}

import Foundation

func template(enumName: String, cases: String, associatedClass: String, bundleName: String) -> String {
    assert(associatedClass.isEmpty == bundleName.isEmpty, "If associated class is empty, bundle name should also be empty.")
    let bundle: String = {
        if associatedClass.isEmpty || bundleName.isEmpty {
            return """
                    return Bundle.main
            """
        } else {
            return """
                    guard let path = Bundle(for: \(associatedClass).self).path(forResource: "\(bundleName)", ofType: "bundle") else {
                        return nil
                    }
                    return Bundle(path: path)
            """
        }
    }()

    let file =
    """
    // Generated with Misen by tasanobu - Modules/CommonUI/Scripts/misen.swift
    // DO NOT EDIT

    import UIKit

    public enum \(enumName): String {
    \(cases)
        private static let bundle: Bundle? = {
    \(bundle)
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
        }
    }

    private final class _TypedCatalog {}

    """
    return file
}

# TypedCatalog

## What?

`TypedCatalog` is a CLI to support using Xcode Asset Catalog in Swift.

TypedCatalog development started as a fork of [Misen](https://github.com/tasanobu/Misen).

## Why?

It makes your assets code:

- compile time checked,
- strong typed,
- autocompletable by Xcode.

## How?

### Installation

There are several methods to install Unstringify:

- Via [CocoaPods](https://cocoapods.org)
- Via [Swift Package Manager](https://swift.org/package-manager)
- Others:
    - Download the ZIP for the [latest release](https://github.com/metrolab/Unstringify/releases/latest)
    - Via [Mint](https://github.com/yonaskolb/Mint) (system-wide installation)
    - Compile from [source](https://github.com/metrolab/TypedCatalog.git) (only recommended if you need features from master or want to test a PR)

## Usage

### Example

Given a project where all the asset catalogs are contained in a development pod called `Assets`. 

- Place your asset catalogs in the directory `Modules/Assets/Resources/`.

- Add the following to your `Modules/Assets/Assets.podspec` file:

```
s.resource_bundles = {
    'CommonsUI' => ['Resources/*.xcassets']
}

s.script_phase = { :name => 'Generate Images Enums', :script => 'eval "${SRCROOT}/../Modules/Assets/Scripts/generate_images_enums.sh Assets ${SRCROOT}/../Modules/Assets/Resources ${SRCROOT}/../Modules/Assets/Sources"', :execution_position => :before_compile }

s.prepare_command = <<-CMD
Scripts/generate_images_enums.sh 'Resources' 'Classes/Images'
CMD

s.source_files = 'Sources/**/*'
```

- Copy `generate_images_enums.sh` to  `Modules/Assets/Scripts/`.

- Add `Assets` dependency to podspecs of all modules that will use the assets:

```
s.dependency 'Assets'
```

- Add the `Assets` module to the application's `Podfile`:

```
pod 'Assets', :path => './Modules/Assets'
```

## License

TypedCatalog is released under the MIT license. See `LICENSE` for details.

# Alternatives

- <https://github.com/tasanobu/Misen>
- <https://github.com/mac-cain13/R.swift>
- <https://github.com/bannzai/ResourceKit>
- <https://github.com/kaandedeoglu/Shark>
- <https://github.com/SwiftGen/SwiftGen>

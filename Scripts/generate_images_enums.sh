#!/bin/sh

################################################################################
#
# Generates enums for all assets catalogs.
#
# Preconditions:
# TypedCatalog is located in the same folder than this script
#
# Usage:
# generate_images_enums.sh <bundle name> <catalogs path> <output path>
#
################################################################################

## Script phases
#

function create_output_folder() {
    local -r output_path="${1}"

    mkdir -p "${output_path}"
}

function generate_enums() {
    local -r scripts_path="${1}"
    local -r bundle_name="${2}"
    local -r input_path="${3}"
    local -r output_path="${4}"

	local dirname=""
	local catalog=""
        for dirname in $(ls "${input_path}"); do
		if [ ${dirname: -9} == '.xcassets' ]; then
			catalog="${dirname%.xcassets}"
            "${scripts_path}"/TypedCatalog -path "${input_path}/${dirname}" -exportPath "${output_path}/${catalog}.swift" -enumName "${catalog}" -bundleName 'CommonsUI' -bundleAssociatedClass 'View'
		fi
	done
}

## Script entry point
#

function main() {
    local -r bundle_name="${1}"
    local -r input_path="${2}"
    local -r output_path="${3}"

    local -r scripts_path="$( cd "$(dirname "$0")" ; pwd -P )"
    create_output_folder "${output_path}"
    generate_enums "${scripts_path}" "${bundle_name}" "${input_path}" "${output_path}"
}
main "${1}" "${2}" "${3}"

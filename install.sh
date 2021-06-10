#!/bin/bash

themeInstallDir=$HOME/.local/share/icons
themeName="Skeuo-icon-theme"

function show_help {
	cat << EOF
Usage : ./install.sh [-grh]
Install the icon theme, locally or globally.
Default behavior is locally (only for the current user).
Note that if a version icons exist in the install directory, it will first be removed.

-h	Display this help
-g	Install globally (needs root privileges)
-r	Uninstall rather than installing

Exit status:
 0	if OK,
 1	if write permissions to install directory are missing
 2	if invalid usage occurs 
EOF
}

mode="install"

# Parsing options
while getopts ":hrg:" opt; do
	case ${opt} in
		h )
			# Display help and exit
			show_help
			exit 0
			;;
		g ) 
			# Install globally
			themeInstallDir=/usr/share/icons
			;;
		r )
			# Uninstall mode
			mode="remove"
			;;
		? )
			# Wrong usage (unused at the moment)
			echo "Invalid option -$OPTARG"
			echo
			show_help
			exit 2
			;;
	esac
done

# Check write permissions
if [[ ! -w $themeInstallDir ]]; then
	echo "Can't write to $themeInstallDir"
	exit 1
fi


# Remove existing icons
echo "Removing existing versions of the icons in $themeInstallDir"
rm -rf "${themeInstallDir}/${themeName}"
if [[ $mode = "remove" ]]; then
	exit 0
fi


# Install icons
echo "Installing icons into $themeInstallDir"
cp -r $themeName $themeInstallDir
exit 0

#!/bin/bash
#
set -euo pipefail

echo "$0"
full_path=$(realpath "$0")
dir_path=${full_path%/*}

bold=$(tput bold setaf 2)
cleanse=$(tput sgr0)

readarray -t packages <<< "$(find x86_64/ -type f -name PKGBUILD | awk -F / '{print $2}')"

echo -e "${bold} building packages...${cleanse}"

cd x86_64

for x in "${packages[@]}"
do
     echo -e "\n\t ${bold} +++ Building package ${x}.${cleanse}\n"
     cd "${dir_path}"/x86_64/"${x}" &> /dev/null
     makepkg -rs --noconfirm #&> /dev/null
     rm -rf "${dir_path}"/x86_64/"${x}"/"${x}" &> /dev/null
done

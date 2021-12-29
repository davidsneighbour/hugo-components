#!/usr/bin/env bash

REQUIRED_TOOLS=(
  git
)

# check for tools
for tool in "${REQUIRED_TOOLS[@]}"; do
  if ! command -v "${tool}" >/dev/null; then
    echo "Tool ${tool} is required. Exiting"; exit 1
  fi
done

# iterate over subdirectories
for dir in dnb-hugo*
do
  cd "${dir}" > /dev/null || return
  if [ "$(git status --porcelain | wc -l)" -eq "0" ]; then
    continue
  else
    echo -e  "\e[1;36m[================== ${dir} ==================]\e[m"
    cd "${dir}" > /dev/null || return
    if [ -d .git ]; then
      git status -s
    fi
  fi
  cd ..
done
cd ..

# list changed repositories
echo -e  "\e[1;36m[================== Changed Repositories ==================]\e[m"
for dir in dnb-hugo*
do
  cd "${dir}" > /dev/null || return
  if [ "$(git status --porcelain | wc -l)" -eq "0" ]; then
    continue
  else
    echo "🔴 ${dir}"
  fi
  cd ..
done

# ending
echo "Completed in ${SECONDS}s"

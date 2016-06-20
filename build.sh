#!/bin/sh

set -ux

rm -rf app
flatpak-builder --ccache --require-changes --repo=repo --subject="Nightly build of Electron, `date`" app com.github.electron.json

flatpak build-update-repo --prune --prune-depth=20 repo

# The following commands should be performed once
flatpak --user remote-add --no-gpg-verify nightly-electron ./repo || true
flatpak --user -v install nightly-electron com.github.electron || true

flatpak update --user com.github.electron

#!/usr/bin/env bash
# Run a command inside the vintage Ruby 2.3 / PostgreSQL 11 toolchain this
# Rails 4.1 app needs. Packages come from the 2019-era nixpkgs release, which
# matches the app's gem set.
set -e

export TMPDIR=/tmp
NIXPKGS=https://github.com/NixOS/nixpkgs/archive/refs/tags/19.03.tar.gz

# Gems and PostgreSQL data live outside the repo so they are never committed.
export GEM_HOME=/tmp/ruby23-gems
export GEM_PATH=$GEM_HOME
export BUNDLE_PATH=$GEM_HOME
export BUNDLE_APP_CONFIG=/tmp/ruby23-bundle
mkdir -p "$GEM_HOME" "$BUNDLE_APP_CONFIG"

# Modern loader paths break the old native extensions.
unset LD_LIBRARY_PATH

# Resolve the dev outputs (headers, *-config scripts) up front; nix shell only
# puts the default/bin outputs on PATH.
CACHE=/tmp/ruby23-paths
if [ ! -s "$CACHE" ]; then
  for attr in 'libxml2^dev' 'libxslt^dev' 'zlib^dev' 'libxml2^out' 'libxslt^out' 'tzdata^out'; do
    nix build --no-link --print-out-paths -f "$NIXPKGS" "$attr" 2>/dev/null | tail -1
  done > "$CACHE"
fi
export LIBXML2_DEV=$(sed -n 1p "$CACHE")
export LIBXSLT_DEV=$(sed -n 2p "$CACHE")
export ZLIB_DEV=$(sed -n 3p "$CACHE")
export LIBXML2_OUT=$(sed -n 4p "$CACHE")
export LIBXSLT_OUT=$(sed -n 5p "$CACHE")
export TZDIR=$(sed -n 6p "$CACHE")/share/zoneinfo

exec nix shell -f "$NIXPKGS" \
  ruby_2_3 postgresql_11 libxml2 libxslt zlib openssl tzdata \
  gcc gnumake pkgconfig nodejs-10_x bash coreutils shadow utillinux \
  --command bash -c '
    set -e
    export PATH="$GEM_HOME/bin:$LIBXML2_DEV/bin:$LIBXSLT_DEV/bin:$PATH"
    LIBXML2_LIB=$LIBXML2_OUT/lib
    LIBXSLT_LIB=$LIBXSLT_OUT/lib
    export PKG_CONFIG_PATH="$LIBXML2_DEV/lib/pkgconfig:$LIBXSLT_DEV/lib/pkgconfig:$ZLIB_DEV/lib/pkgconfig"
    export NOKOGIRI_USE_SYSTEM_LIBRARIES=1
    export BUNDLE_BUILD__NOKOGIRI="--use-system-libraries --with-xml2-include=$LIBXML2_DEV/include/libxml2 --with-xml2-lib=$LIBXML2_LIB --with-xslt-include=$LIBXSLT_DEV/include --with-xslt-lib=$LIBXSLT_LIB"
    exec "$@"
  ' bash "$@"

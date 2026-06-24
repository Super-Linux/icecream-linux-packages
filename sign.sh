#!/bin/bash
set -e

KEY="B0C6C7BBAC380C16230AAEF6AE8F9B8B1E4B6F4D"

echo "[1/3] Updating Packages..."

dpkg-scanpackages --arch amd64 pool > dists/stable/main/binary-amd64/Packages
gzip -kf dists/stable/main/binary-amd64/Packages

echo "[2/3] Creating Release..."

apt-ftparchive -c apt-ftparchive.conf \
release dists/stable > dists/stable/Release

echo "[3/3] Signing Release..."

gpg --default-key "$KEY" \
--clearsign \
--digest-algo SHA512 \
-o dists/stable/InRelease \
dists/stable/Release

echo "Done!"

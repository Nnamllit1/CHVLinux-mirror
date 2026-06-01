#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
signing_key="${CHV_SIGNING_KEY:-38EA304A9ACA010CC01EF98532CABC763A4684FA}"

cd "$repo_root"

while IFS= read -r -d '' index; do
  hash="$(sha256sum "$index" | awk '{print $1}')"
  hash_dir="$(dirname "$index")/by-hash/SHA256"
  mkdir -p "$hash_dir"
  cp "$index" "$hash_dir/$hash"
done < <(find dists -type f \( -name Packages -o -name Packages.gz \) -print0)

while IFS= read -r -d '' release; do
  if ! grep -q '^Acquire-By-Hash: yes$' "$release"; then
    tmp="$(mktemp)"
    awk 'NR == 1 { print "Acquire-By-Hash: yes" } { print }' "$release" > "$tmp"
    mv "$tmp" "$release"
  fi

  suite_dir="$(dirname "$release")"
  gpg --batch --yes --local-user "$signing_key" --digest-algo SHA256 \
    --clearsign --output "$suite_dir/InRelease" "$release"
  gpg --batch --yes --local-user "$signing_key" --digest-algo SHA256 \
    --armor --detach-sign --output "$suite_dir/Release.gpg" "$release"
done < <(find dists -mindepth 2 -maxdepth 2 -type f -name Release -print0)

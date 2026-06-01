# CHVLinux APT Mirror

Static APT repository for CHVLinux packages.

- URL: `https://chvlinux-mirror.nnamllit.de/`
- Suite: `stable`
- Component: `main`
- Architecture: `amd64`
- Public key: `public-key.asc`

Deb822 source:

```text
Types: deb
URIs: https://chvlinux-mirror.nnamllit.de/
Suites: stable
Components: main
Architectures: amd64
Signed-By: /usr/share/keyrings/chvlinux-archive-keyring.gpg
```

After publishing packages with `reprepro`, run:

```sh
scripts/finalize-apt-metadata.sh
```

This adds `Acquire-By-Hash` index paths and re-signs the release metadata so CDN caches cannot mix old and new package indexes during updates.

# CHVLinux Mirror

This repository serves the CHVLinux static APT mirror.

It is intended to be published through GitHub Pages or a custom domain. The repository is static: APT clients read `dists/`, `pool/`, and the archive public key directly over HTTPS.

## Current Channel

- Suite/codename: `stable`
- Component: `main`
- Architecture: `amd64`
- Metadata generator: `reprepro`
- Archive public key: `public-key.asc`

## Client Source Template

After the final Pages/custom-domain URL is known, installed systems should use a Deb822 source like this:

```text
Types: deb
URIs: https://REPLACE-WITH-MIRROR-DOMAIN/
Suites: stable
Components: main
Architectures: amd64
Signed-By: /usr/share/keyrings/chvlinux-archive-keyring.gpg
```

The implementation repository should install `public-key.asc` as `/usr/share/keyrings/chvlinux-archive-keyring.gpg` before enabling this source.

## Publishing

Enable GitHub Pages for this repository from the `main` branch at the repository root, or configure a custom domain to serve the same root. After the final URL is available, update the implementation repository to write the real mirror URL during setup/bootstrap.

Do not commit the private archive signing key here. Only the exported public key belongs in this repository.

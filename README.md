# octave_action

A GitHub Action to install [GNU Octave](https://octave.org/download) on all platforms.

## Usage

```yaml
- uses: calysto/octave_action@v1
  with:
    install-type: ubuntu  # ubuntu | macos | windows | ubuntu-flatpak | ubuntu-snap
```

### Install types

| Value | Runner | Method |
|---|---|---|
| `ubuntu` | `ubuntu-*` | apt |
| `macos` | `macos-*` | Homebrew |
| `windows` | `windows-*` | winget |
| `ubuntu-flatpak` | `ubuntu-*` | Flatpak (flathub) |
| `ubuntu-snap` | `ubuntu-*` | snap (edge) |

## Example workflow

```yaml
jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v7
      - uses: calysto/octave_action@v1
        with:
          install-type: ubuntu
      - run: octave --eval "disp('hello')"
```

## Contributing

Install [just](https://github.com/casey/just) and [pre-commit](https://pre-commit.com), then run:

```shell
just pre-commit
```

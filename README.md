# Marble Shell and Matugen

Color your GNOME Shell with [Marble Shell](https://github.com/imarkoff/Marble-shell-theme) + [Matugen](https://github.com/InioX/matugen).

## Usage Steps

- Download the Marble Shell binary [here](https://github.com/oscar370/marble-shell-matugen/releases).
- Save it wherever you prefer; I usually use `~/.local/bin/`.
- In your Matugen template, or using [Matuda](https://github.com/oscar370/Matuda), configure the prehook as follows:

```bash
~/.local/bin/marble-shell -O --hue {{colors.primary.default.hue}} --sat {{colors.primary.default.saturation}} --mode dark --name matugen --filled
```

> Replace the binary path with yours if it differs.

> Adjust the arguments to your liking.

> It is advisable to define the name so that a new theme is not generated each time Matugen run.

> You can use a template pointing to a file that only has `{{ palettes }}`, or add the hook to a template you already have. _It will not affect your template_.

> **Functionality with GDM has not yet been tested.**

- Now activate the theme. You have to reload the extension every time the theme is replaced. You can use the following script to automate this:

```bash
#!/bin/sh

CANDIDATES="
/run/current-system/sw/bin/gnome-extensions
/usr/bin/gnome-extensions
/bin/gnome-extensions
/usr/local/bin/gnome-extensions
"

if command -v gnome-extensions >/dev/null 2>&1; then
    EXT_BIN="$(command -v gnome-extensions)"
else
    for p in $CANDIDATES; do
        if [ -x "$p" ]; then
            EXT_BIN="$p"
            break
        fi
    done
fi

if [ -z "$EXT_BIN" ]; then
    echo "gnome-extensions not found"
    exit 1
fi

"$EXT_BIN" disable user-theme@gnome-shell-extensions.gcampax.github.com
"$EXT_BIN" enable  user-theme@gnome-shell-extensions.gcampax.github.com
```

- And add its execution to the hook by adding this at the end:

```bash
&& ~/.config/templates/reload-user-extension.sh
```

> Replace the path with the location of your script.

> You cannot run marble-shell within the script because Matugen does not replace the color arguments. That is why they are not in a single script.

- The final hook would look like this:

```bash
~/.local/bin/marble-shell -O --hue {{colors.primary.default.hue}} --sat {{colors.primary.default.saturation}} --mode dark --name matugen --filled && ~/.config/templates/reload-user-extension.sh
```

## Development

These instructions are for building the Marble Shell binary.

### Requirements

- pyinstaller

### Python dependencies

```bash
pip install pyinstaller
# or
pip install -r requirements.txt
```

### Building

Run the `build.sh` script.

## Acknowledgments

- [Matugen](https://github.com/InioX/matugen) - Color palette generation.
- [Marble Shell Theme](https://github.com/imarkoff/Marble-shell-theme) - Shell theme for GNOME
- [Matuda](https://github.com/oscar370/Matuda) - Control panel for Matugen.

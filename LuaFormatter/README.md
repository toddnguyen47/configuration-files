# Lua Setup

The setup that we are currently using for Lua. These scripts will compile [LuaFormatter](https://github.com/Koihik/LuaFormatter) and use it as our main Lua autoformatter in [Visual Studio Code](https://code.visualstudio.com/).

# Compile LuaFormatter

## Ubuntu/Debian only: Install gcc that is compatible with C++ 17

- Run the script `00_ubuntuInstallGcc9.sh` with `sudo -E`, which preserves the environment variables

```
$ chmod +x 00_ubuntuInstallGcc9.sh
$ sudo -E ./00_ubuntuInstallGcc9.sh
```

## Time to compile LuaFormatter

- Run the script `01_installLuaFormatter.sh` to clone and install [LuaFormatter](https://github.com/Koihik/LuaFormatter).
- `LuaFormatter`, along with the configuration file `config.luaformatter` found in this directory,
  will be installed to `$HOME/opt/LuaFormatter`

```
$ chmod +x 01_installLuaFormatter.sh
$ ./01_installLuaFormatter.sh
```

# Extensions

The extensions we are using:

- `Lua` by `sumneko`. Link: https://marketplace.visualstudio.com/items?itemName=sumneko.lua
- `vscode-lua-format` by `Koihik`. Link: https://github.com/Koihik/vscode-lua-format

## Extension Configuration

- Open `settings_to_append.json` in our current directory and copy everything between the two braces, '{' on line 1 and its matching '}'. 
- In Visual Studio Code, type in the keyboard shortcut `Ctrl + Shift + P` to open
  the Command Palette.
- In the Command Palette, type in `>Preferences: Open Settings (JSON)` and press Enter. The `>`
  (right arrow) is important!
- Paste in what we copied from `settings_to_append.json` and append it to the end of the User
  `settings.json` file.
- You should be set!

# Questions? Concerns?

Email me at todd.nguyen47@gmail.com !

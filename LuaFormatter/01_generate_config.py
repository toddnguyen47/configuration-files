import argparse
import json
import sys

config_dict = {
    "editor.formatOnSave": True,
    "vscode-lua-format.binaryPath": "",
    "vscode-lua-format.configPath": ""
}



class GenerateConfig:
    def __init__(self, luaformat_dir: str):
        self._luaformat_dir = luaformat_dir

    def output(self):
        json_filename = "settings_to_append.json"
        with open(json_filename, "w") as file:
            config_dict["vscode-lua-format.binaryPath"] =\
                "{}/bin/lua-format".format(self._luaformat_dir)
            config_dict["vscode-lua-format.configPath"] =\
                "{}/config.luaformatter".format(self._luaformat_dir)
            json.dump(config_dict, file, indent=2)
        print("Finished exporting to {}".format(json_filename))


if __name__ == "__main__":
    # Ref: https://stackoverflow.com/a/3853776#comment36687355_3853776
    parser = argparse.ArgumentParser(
        description="Generate a LuaFormatter configuration file. Example usage:\n" +
        "$ python3 markdown_toc.py /path/to/markdown/file\n\n"
        "Configuration options can be found at https://github.com/Koihik/LuaFormatter",
        formatter_class=argparse.RawDescriptionHelpFormatter
    )
    parser.add_argument("lua_formatter_dir", help="The path to LuaFormatter's installed directory",
                        type=str)

    # If the user does not supply any command line args
    if len(sys.argv) < 2:
        print("ERROR: Please supply a filepath.")
        parser.print_help()
        exit(-1)

    args = parser.parse_args()

    generate_config = GenerateConfig(args.lua_formatter_dir)
    generate_config.output()

{ pkgs, ... }:

{
  programs.helix = {
    enable = true;
    defaultEditor = true;
    extraConfig = "${builtins.readFile ./config.toml}";
    extraPackages = with pkgs; [
      nixd
      nixfmt
      netcat-gnu
    ];
    settings = {
      theme = "default";
      editor = {
        line-number = "relative";
        cursor-shape = {
          normal = "block";
          insert = "bar";
          select = "underline";
        };
      };
    };
    languages = {
      language-server = {
        godot = {
          command = "nc";
          args = [
            "127.0.0.1"
            "6005"
          ];
        };

        nixd = {
          command = "nixd";
          args = [ "--semantic-tokens=true" ];
          config.nixd = {
            formatting.command = [ "nixfmt" ];
          };
        };
      };
      language = [
        {
          name = "gdscript";
          language-servers = [ "godot" ];
          auto-format = false;
        }
        {
          name = "nix";
          language-servers = [ "nixd" ];
          auto-format = true;
          formatter = {
            command = "nixfmt";
          };
        }
        {
          name = "markdown";
          language-servers = [ "marksman" ];
          formatter = {
            command = "prettier";
            args = [
              "--parser"
              "markdown"
              "--prose-wrap"
              "never"
            ];
            auto-format = true;
          };
        }
      ];
    };
  };
}

{ pkgs, ... }:

{
  programs.helix = {
    enable = true;
    defaultEditor = true;
    extraConfig = "${builtins.readFile ./config.toml}";
    extraPackages = with pkgs; [
      gopls
      nixd
      nixfmt
      netcat-gnu
      prettier
    ];
    languages = {
      language-server = {
        gopls = {
          command = "gopls";
          args = [
            "-logfile=/tmp/gopls.log"
            "serve"
          ];
          config = {
            "ui.diagnostic.staticcheck" = true;
          };
        };
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
          name = "rust";
          indent = {
            tab-width = 4;
            unit = " ";
          };
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

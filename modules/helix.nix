{ pkgs, ... }:

{
  programs.helix = {
    enable = true;
    defaultEditor = false;
    extraPackages = with pkgs; [
      nixd
      nixfmt
      netcat-gnu
    ];
    settings = {
      theme = "ayu_dark";
      editor = {
        line-number = "relative";
        cursor-shape = {
          normal = "block";
          insert = "bar";
          select = "underline";
        };
      };
      keys.insert = {
        "C-[" = "normal_mode";
      };
      keys.select = {
        "C-[" = "normal_mode";
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
      ];
    };
  };
}

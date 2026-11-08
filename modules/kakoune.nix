{ ... }:

{
  let
    myKakoune =
    let
    config = pkgs.writeTextFile (rec {
      name = "kakrc.kak";
      destination = "/share/kak/autoload${name}";
      text = ''
          colorscheme default
set-option global indentwidth 2
set-option global tabstop 2
set-option global scrolloff 8,3
set-option global autocomplete prompt|insert
add-highlighter global/ number-lines -relative -hlcursor
add-highlighter global/ show-matching

source "%val{config}/plugins/plug.kak/rc/plug.kak"
plug "andreyorst/plug.kak" noload

plug "alexherbo2/auto-pairs.kak" %config {
  enable-auto-pairs
}

plug "delapouite/kakoune-text-objects"
        '';
    });
  in
  kakoune.override {
    plugins = with kakounePlugins; [ config parinfer-rust ];
  };
in
}

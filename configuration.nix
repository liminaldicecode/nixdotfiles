{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    ./hardware-configuration.nix
    ./maintenance.nix
  ];

  # Bootloader
  boot.loader.systemd-boot.enable = false;
  boot.loader.grub = {
    enable = true;
    device = "nodev";
    efiSupport = true;
    useOSProber = true;
  };
  boot.loader.efi.canTouchEfiVariables = true;
  boot.supportedFilesystems = [ "ntfs" ];

  # Networking
  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  # Syncthing
  services.syncthing = {
    enable = true;
    openDefaultPorts = true;
    user = "nix";
    group = "users";
    dataDir = "/home/nix/.local/state/syncthing";
    configDir = "/home/nix/.config/syncthing";
  };

  # Time
  time.timeZone = "America/Argentina/Buenos_Aires";
  time.hardwareClockInLocalTime = true;

  # Hardware
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  # Desktop
  services.xserver = {
    enable = true;
    autoRepeatDelay = 200;
    autoRepeatInterval = 35;
    videoDrivers = [ "amdgpu" ];
  };

  services.displayManager = {
    sddm = {
      enable = true;
      wayland.enable = true;
    };
    # gdm.enable = true;
    # defaultSession = "gnome";
  };

  services.desktopManager.plasma6.enable = true;
  # services.desktopManager.gnome.enable = true;

  # services.gnome = {
  #   tinysparql.enable = true;
  #   core-apps.enable = true;
  #   core-developer-tools.enable = true;
  #   games.enable = false;
  # };

  # programs.gnome-terminal.enable = true;

  # xdg.portal = {
  #   enable = true;
  #   extraPortals = [ pkgs.xdg-desktop-portal-gnome ];
  #   config.common.default = "*";
  # };

  environment.variables.XCURSOR_SIZE = "32";

  # Input
  services.keyd.enable = true;

  environment.etc."libinput/local-overrides.quirks".text = ''
    [Serial Keyboards]
    MatchUdevType=keyboard
    MatchName=keyd virtual keyboard
    AttrKeyboardIntegration=internal
  '';

  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";
    fcitx5.addons = with pkgs; [
      fcitx5-mozc
      fcitx5-gtk
      qt6Packages.fcitx5-chinese-addons
    ];
  };

  # Audio
  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

  # Virtualisation
  # virtualisation.virtualbox = {
  #   host = {
  #     enable = true;
  #     enableExtensionPack = true;
  #   };
  #   guest = {
  #     enable = true;
  #     dragAndDrop = true;
  #   };
  # };
  # users.extraGroups.vboxusers.members = [ "nix" ];

  # Users
  users.users.nix = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    packages = with pkgs; [
      tree
    ];
  };

  # Nix
  nixpkgs.config.allowUnfree = true;

  nix.settings = {
    experimental-features = [
      "nix-command"
      "flakes"
    ];
  };

  # Programs
  programs.kdeconnect.enable = true;
  programs.nix-ld.enable = true;
  programs.firefox.enable = true;
  programs.appimage = {
    enable = true;
    binfmt = true;
  };

  programs.vim = {
    enable = true;
    defaultEditor = true;
    package = (pkgs.vim-full.override { }).customize{
      name = "vim";
      # Install plugins for example for syntax highlighting of nix files
      vimrcConfig.packages.myplugins = with pkgs.vimPlugins; {
        start = [ vim-nix vim-lastplace vim-airline ];
        opt = [];
      };
      vimrcConfig.customRC = ''
        let g:mapleader = " "
        nnoremap <leader>e :Ex<CR>
        nnoremap <leader>h :set hlsearch!<CR>
        set nocompatible
        set backspace=indent,eol,start
        syntax on
        colorscheme habamax
        set noshowmode
        set number
        set relativenumber
        set undofile
        set ignorecase
        set nosmartcase
        set hlsearch
        set scrolloff=8
        set termguicolors
        set confirm
        set tabstop=2
        set shiftwidth=2
        set smarttab
        set autoindent
        set smartindent
      '';
    };
  };
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
  };

  services.flatpak.enable = true;
  services.qbittorrent.enable = true;

  # Fonts
  fonts.packages = with pkgs; [
    jost
    liberation_ttf
    nerd-fonts.jetbrains-mono
    noto-fonts-cjk-sans
    nerd-fonts.caskaydia-cove
    iosevka
    iosevka-comfy.comfy
    roboto
  ];

  # System Packages
  environment.systemPackages = with pkgs; [
    # adwaita-icon-theme
    alacritty
    blender
    emacs
    git
    # gnomeExtensions.appindicator
    # gnomeExtensions.arc-menu
    # gnomeExtensions.blur-my-shell
    # gnomeExtensions.just-perfection
    gnumake
    libwacom
    mg
    nixfmt
    pavucontrol
    pciutils
    st
    thunar-archive-plugin
    thunar-volman
    vlc
    webtorrent_desktop
    wget
    wineWow64Packages.stable
    winetricks
    xclip
    yt-dlp
    nh
    (llama-cpp.override { vulkanSupport = true; })
  ];

  # SSH
  services.openssh = {
    enable = true;
    openFirewall = true;
    settings = {
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
      PermitRootLogin = "no";
      AllowUsers = [ "nix" ];
      MaxAuthTries = 3;
      PerSourcePenalties = "crash:3600s authfail:3600s max:86400s";
    };
  };

  programs.ssh.startAgent = true;

  # System
  system.stateVersion = "26.05";
}

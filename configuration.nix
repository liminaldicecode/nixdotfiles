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
    gdm = {
      enable = true;
    };
  };

  services.desktopManager.gnome.enable = true;
  services.gnome = {
    core-apps.enable = true;
    core-developer-tools.enable = true;
    games.enable = true;
  };

  qt = {
    enable = true;
    platformTheme = "gnome";
    style = "adwaita-dark";
  };

  environment.variables.XCURSOR_SIZE = "32";

  virtualisation.libvirtd.enable = true;
  programs.virt-manager.enable = true;

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
    fcitx5.waylandFrontend = true;
  };

  # Audio
  security.rtkit.enable = true;
  services.pulseaudio.enable = false;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    wireplumber.enable = true;
    pulse.enable = true;
  };

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
    adwaita-fonts
    jost
    liberation_ttf
    nerd-fonts.jetbrains-mono
    noto-fonts-cjk-sans
    nerd-fonts.caskaydia-cove
    iosevka
    iosevka-comfy.comfy
    roboto
    hermit
    plemoljp
  ];

  fonts.fontDir.enable = true;

  # System Packages
  environment.systemPackages = with pkgs; [
    blender
    file
    git
    gnome-boxes
    gnome-console
    gnomeExtensions.appindicator
    gnomeExtensions.gsconnect
    gnome-terminal
    gnome-tweaks
    gnumake
    kakoune
    kakoune-lsp
    libwacom
    mg
    nh
    nixfmt
    pavucontrol
    pciutils
    qadwaitadecorations
    qadwaitadecorations-qt6
    qgnomeplatform
    qgnomeplatform-qt6
    st
    thunar-archive-plugin
    thunar-volman
    vim-full
    vlc
    webtorrent_desktop
    wget
    winetricks
    wineWow64Packages.stable
    xclip
    yt-dlp
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

  # System
  system.stateVersion = "26.05";
}

{ config, inputs, pkgs, ... }:

let user = "michaelklug";
    keys = [ "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDdS3YtldeyA67cQh5r3rAa3GHJEMXgs824PDA7zoUHa8FN4UPFN5L9ZCriq2IsXG6FJrYZfB31Fj9YyBfjt7lwcuOH8q4tYCG3li551HvOZrIv9a2zN6lKbSWYYPhGMQtBA7vOalHA/rDSYGiljIZe8hQNRuh6KtdCosfrufaOGmGH1Wl+tgpb0TUW6MdfMhcFmlLYvz06jdVgq/IskLcAwzy345sx3BkPWEg3xWF/GFd5eIUlsVDfwgvdCIli+q3Bis8rDfQH9VoCChitdKk9Dfo5+xUad1R1cSw5bJd8WzCPA2uVU1QTUz9ZpDMFqgrVRot1j1REpLNF4Jthh7MhCNNz+9tyCPmTlejxGpznRkINbTCrK5b4WNdt4XgwpP+O1t4b1RSJyDiysd9eeN2kDtiNIxstVzleE9AFRrxnKhKjcOJXBAVycpJLPSEepm9iwGI5ZR36mA2TZfeFRyKru2b6k1Wz4hpm77feAHYDtcRDHXwn3NSPryABFyUr73M=" ]; in
{
  imports = [
    ../../modules/nixos/disk-config.nix
    ../../modules/shared
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Set your time zone.
  time.timeZone = "Europe/Vienna";

  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "de_AT.UTF-8";
    LC_IDENTIFICATION = "de_AT.UTF-8";
    LC_MEASUREMENT = "de_AT.UTF-8";
    LC_MONETARY = "de_AT.UTF-8";
    LC_NAME = "de_AT.UTF-8";
    LC_NUMERIC = "de_AT.UTF-8";
    LC_PAPER = "de_AT.UTF-8";
    LC_TELEPHONE = "de_AT.UTF-8";
    LC_TIME = "de_AT.UTF-8";
  };

  # Enable the X11 windowing system.
  # You can disable this if you're only using the Wayland session.
  services.xserver.enable = true;

  # Enable the KDE Plasma Desktop Environment.
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Turn on flag for proprietary software
  nix = {
    nixPath = [ "nixos-config=/home/${user}/.local/share/src/nixos-config:/etc/nixos" ];
    settings = {
      allowed-users = [ "${user}" ];
      trusted-users = [ "@admin" "${user}" ];
      substituters = [ "https://nix-community.cachix.org" "https://cache.nixos.org" ];
      trusted-public-keys = [ "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY=" ];
    };

    package = pkgs.nix;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
   };

  services = {

    # Let's be able to SSH into this machine
    openssh.enable = true;
    openssh.settings.PermitRootLogin = "yes";

  };

  # It's me, it's you, it's everyone
  users.users = {
    ${user} = {
      isNormalUser = true;
      extraGroups = [
        "wheel" # Enable ‘sudo’ for the user.
        "networkmanager"
      ];
      packages = with pkgs; [
            kdePackages.kate
      ];
      shell = pkgs.zsh;
      openssh.authorizedKeys.keys = keys;
    };

    root = {
      openssh.authorizedKeys.keys = keys;
    };
  };

  programs.firefox.enable = true;
  programs.zsh.enable = true;

  environment.systemPackages = with pkgs; [
    gitAndTools.gitFull
    inetutils
  ];

  system.stateVersion = "21.05"; # Don't change this

  virtualisation.vmware.guest.enable = true;

}

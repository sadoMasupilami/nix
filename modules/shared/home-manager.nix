{ config, pkgs, lib, ... }:

let name = "Michael Klug";
    user = "michaelklug";
    email = "michiklug85@gmail.com"; in
{
  # Shared shell configuration
  zsh = {
    enable = true;
    autocd = false;
    plugins = [
      {
        name = "powerlevel10k";
        src = pkgs.zsh-powerlevel10k;
        file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
      }
      {
        name = "powerlevel10k-config";
        src = lib.cleanSource ./config;
        file = "p10k.zsh";
      }
    ];

    initExtraFirst = ''
      if [[ -f /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh ]]; then
        . /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
        . /nix/var/nix/profiles/default/etc/profile.d/nix.sh
      fi

      # Define variables for directories
      export PATH=$HOME/.pnpm-packages/bin:$HOME/.pnpm-packages:$PATH
      export PATH=$HOME/.npm-packages/bin:$HOME/bin:$PATH
      export PATH=$HOME/.local/share/bin:$PATH

      # Remove history data we don't want to see
      export HISTIGNORE="pwd:ls:cd"

      # Emacs is my editor
      export ALTERNATE_EDITOR=""
      export EDITOR="emacsclient -t"
      export VISUAL="emacsclient -c -a emacs"

      e() {
          emacsclient -t "$@"
      }

      # nix shortcuts
      shell() {
          nix-shell '<nixpkgs>' -A "$1"
      }

      # Use difftastic, syntax-aware diffing
      alias diff=difft

      # Always color ls and group directories
      alias -- h=helm
      alias -- k=kubectl
      alias -- l='ls -lah'
      alias -- la='ls -lah -a'
      alias -- ll='ls -lh'
      alias -- ls='eza --icons --classify --group-directories-first'
      alias -- t=terraform
    '';
  };

  git = {
    enable = true;
    userName = name;
    userEmail = email;
    lfs = {
      enable = true;
    };
    extraConfig = {
      init.defaultBranch = "main";
      core = {
	    editor = "nano";
        autocrlf = "input";
      };
    };
  };

#  alacritty = {
#    enable = true;
#    settings = {
#      cursor = {
#        style = "Block";
#      };
#
#      window = {
#        opacity = 1.0;
#        padding = {
#          x = 24;
#          y = 24;
#        };
#      };
#
#      font = {
#        normal = {
#          family = "MesloLGS NF";
#          style = "Regular";
#        };
#        size = lib.mkMerge [
#          (lib.mkIf pkgs.stdenv.hostPlatform.isLinux 10)
#          (lib.mkIf pkgs.stdenv.hostPlatform.isDarwin 14)
#        ];
#      };
#
#      dynamic_padding = true;
#      decorations = "full";
#      title = "Terminal";
#      class = {
#        instance = "Alacritty";
#        general = "Alacritty";
#      };
#
#      colors = {
#        primary = {
#          background = "0x1f2528";
#          foreground = "0xc0c5ce";
#        };
#
#        normal = {
#          black = "0x1f2528";
#          red = "0xec5f67";
#          green = "0x99c794";
#          yellow = "0xfac863";
#          blue = "0x6699cc";
#          magenta = "0xc594c5";
#          cyan = "0x5fb3b3";
#          white = "0xc0c5ce";
#        };
#
#        bright = {
#          black = "0x65737e";
#          red = "0xec5f67";
#          green = "0x99c794";
#          yellow = "0xfac863";
#          blue = "0x6699cc";
#          magenta = "0xc594c5";
#          cyan = "0x5fb3b3";
#          white = "0xd8dee9";
#        };
#      };
#    };
#  };
}

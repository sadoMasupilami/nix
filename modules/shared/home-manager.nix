{ config, pkgs, lib, ... }:

let name = "Michael Klug";
    user = "michaelklug";
    email = "michiklug85@gmail.com"; in
{
  # Shared shell configuration
  zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    history = {
      ignoreDups = true;
      ignoreSpace = false;
      save = 100000;
      share = false;
      size = 100000;
    };
    syntaxHighlighting.enable = true;
    autocd = true;
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

      # fzf tab completion
      source ${pkgs.zsh-fzf-tab}/share/fzf-tab/fzf-tab.plugin.zsh

      # nix shortcuts
      shell() {
          nix-shell '<nixpkgs>' -A "$1"
      }
      # autocomplete short cuts
      compdef  __start_kubectl k
      compdef __start_helm h
      compdef __start_terraform t

      # ctrl + left/right for linux
      bindkey "^[[1;5C" forward-word
      bindkey "^[[1;5D" backward-word
    '';
    shellAliases = {
      ls="eza --icons --classify --group-directories-first";
      ll="ls -lh";
      l="ls -lah";
      la="ls -lah -a";
      k="kubectl";
      h="helm";
      t="terraform";
        };
  };

  fzf = {
    enable = true;
    enableZshIntegration = true;
  };

  direnv = {
    enable = true;
    nix-direnv.enable = true;
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

  alacritty = {
    enable = true;
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
  };
}

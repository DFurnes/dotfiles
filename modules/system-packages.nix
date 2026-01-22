{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
        # git/gpg:
        gnupg
        hub

        # shell/editor:
        fzf
        git
        jq
        vim
        neovim
        silver-searcher
        starship

        # utility
        doctl
        squashfsTools
        wget
        tree
        yt-dlp
        unzip

        # languages
        nodejs
        nodenv
        rustc
        cargo
        pnpm

        # nix
        nix-prefetch-github
  ];

  # Allow mutable npm global installs:
  programs.npm.enable = true;
  programs.npm.npmrc = ''
    prefix = ''${HOME}/.npm
  '';
}

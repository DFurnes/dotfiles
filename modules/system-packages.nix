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
        neovim
        silver-searcher
        starship

        # utility
        doctl
        squashfsTools
        wget
        tree
        yt-dlp

        # languages
        nodejs
        nodenv
        rustc
        cargo
        pnpm

        # nix
        nix-prefetch-github
  ];
}

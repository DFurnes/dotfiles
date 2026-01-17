{ pkgs, ... }:
{
    fonts.packages = with pkgs; [
        nerd-fonts.jetbrains-mono
        nerd-fonts.symbols-only
        jetbrains-mono
    ];
}

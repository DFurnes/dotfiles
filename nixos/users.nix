{config, pkgs, ...}:

{
  # Disable password login for root user:
  users.users.root.hashedPassword = "!";

  # User accounts:
  users.mutableUsers = false;
  users.users.dfurnes = {
    isNormalUser = true;
    description = "David Furnes";
    extraGroups = [ "networkmanager" "wheel" ];
    hashedPasswordFile = "/persist/secrets/dfurnes.hash";
    shell = pkgs.zsh; 
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPT03WzkjZo7eQlGCgP+kuvs3f4A/s6MoEbITrIChOv+ david@dfurnes.com"
    ];
    packages = with pkgs; [
      # ...
    ];
  };
}

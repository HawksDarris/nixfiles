{ ... }:

{
  programs.emacs = {
    enable = true;
    extraPackages = epkgs: [
      evil
      evil-collection
      evil-commentary
      evil-surround
      evil-numbers
      company
      company-org-block
      company-nixos-options
      corfu
      flycheck
      flycheck-popup-tip
      org-re-reveal
      nix-mode
      nix-buffer
    ]
  };
}

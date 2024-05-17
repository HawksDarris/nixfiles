{ ... }:

# To view all emacs nix packages, 
# nix-env -f '<nixpkgs>' -qaP -A emacsPackages
{
  programs.emacs = {
    enable = true;
    extraPackages = epkgs: [
      epkgs.evil
      epkgs.evil-collection
      epkgs.evil-commentary
      epkgs.evil-surround
      epkgs.evil-numbers
      epkgs.company
      epkgs.company-org-block
      epkgs.company-nixos-options
      epkgs.corfu
      epkgs.flycheck
      epkgs.flycheck-popup-tip
      epkgs.org-re-reveal
      epkgs.nix-mode
      epkgs.nix-buffer
      epkgs.gruvbox-theme
      epkgs.org-modern
    ];
  };
}

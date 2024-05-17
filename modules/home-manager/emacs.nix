{ ... }:

# To view all emacs nix packages, 
# nix-env -f '<nixpkgs>' -qaP -A emacsPackages
{
  imports = [
#    ./emacs-extraConfig.nix
  ];
  programs.emacs = {
    enable = true;
    extraPackages = epkgs: [
      epkgs.evil
      epkgs.evil-collection
      epkgs.evil-commentary
      epkgs.evil-surround
      epkgs.evil-numbers
      epkgs.company
      epkgs.company-nixos-options
      epkgs.company-org-block
      epkgs.company-emojify
      epkgs.company-shell
      epkgs.company-spell
      epkgs.company-suggest
      epkgs.company-web
      epkgs.corfu
      epkgs.flycheck
      epkgs.flycheck-popup-tip
      epkgs.gruvbox-theme
      epkgs.nix-buffer
      epkgs.nix-mode
      epkgs.org-auto-tangle
      epkgs.org-modern
      epkgs.org-re-reveal
    ];
  };
  programs.emacs.extraConfig = ''
    (setq org-auto-tangle-default t)
  '';
}

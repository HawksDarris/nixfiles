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
      corfu
      flycheck
      flycheck-popup-tip
      org-re-reveal
    ]
  };
}

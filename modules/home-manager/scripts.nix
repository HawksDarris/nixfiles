{ pkgs, ...}:
{
home.packages = with pkgs; [
(pkgs.writeShellScriptBin "example"
  ''
    #!/bin/sh
echo "This is an example"

'')
    ];
}

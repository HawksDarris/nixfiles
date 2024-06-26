# [[file:../../README.org::*Shell Scripts][Shell Scripts:1]]
{ pkgs, ... }:
{
  home.packages = with pkgs; [
# Shell Scripts:1 ends here

# [[file:../../README.org::*compiler script][compiler script:1]]
(pkgs.writeShellScriptBin "compiler"
  ''
#!/bin/sh

file=$(readlink -f "$1")
dir=''${file%/*}
base="''${file%.*}"
ext="''${file##*.}"

cd "$dir" || exit 1

textype() { \
textarget="$(getcomproot "$file" || echo "$file")"
echo "$textarget"
command="pdflatex"
( head -n5 "$textarget" | grep -qi 'xelatex' ) && command="xelatex"
$command --output-directory="''${textarget%/*}" "''${textarget%.*}"
grep -qi addbibresource "$textarget" &&
biber --input-directory "''${textarget%/*}" "''${textarget%.*}" &&
$command --output-directory="''${textarget%/*}" "''${textarget%.*}" &&
$command --output-directory="''${textarget%/*}" "''${textarget%.*}"
}

case "$ext" in
        # Try to keep these cases in alphabetical order.
        [0-9]) preconv "$file" | refer -S -e | groff -mandoc -T pdf > "$base".pdf ;;
        c) cc "$file" -o "$base" && "$base" ;;
        cpp) g++ "$file" -o "$base" && "$base" ;;
        cs) mcs "$file" && mono "$base".exe ;;
        go) go run "$file" ;;
        h) sudo make install ;;
        java) javac -d classes "$file" && java -cp classes "''${1%.*}" ;;
        m) octave "$file" ;;
        md)	if  [ -x "$(command -v lowdown)" ]; then
        lowdown --parse-no-intraemph "$file" -Tms | groff -mpdfmark -ms -kept -T pdf > "$base".pdf
        elif [ -x "$(command -v groffdown)" ]; then
        groffdown -i "$file" | groff -T pdf > "$base".pdf
        else
        pandoc -t ms --highlight-style=kate -s -o "$base".pdf "$file"
        fi ; ;;
        mom) preconv "$file" | refer -S -e | groff -mom -kept -T pdf > "$base".pdf ;;
        ms) preconv "$file" | refer -S -e | groff -me -ms -kept -T pdf > "$base".pdf ;;
        org) emacs "$file" --batch -u "$USER" -f org-latex-export-to-pdf ;;
        py) python "$file" ;;
        [rR]md) Rscript -e "rmarkdown::render('$file', quiet=TRUE)" ;;
        rs) cargo build ;;
        sass) sassc -a "$file" "$base".css ;;
        scad) openscad -o "$base".stl "$file" ;;
        sent) setsid -f sent "$file" 2>/dev/null ;;
        tex) textype "$file" ;;
        typ) typst compile "$file" ;;
        *) sed -n '/^#!/s/^#!//p; q' "$file" | xargs -r -I % "$file" ;;
        esac
        '')
# compiler script:1 ends here

# [[file:../../README.org::*Closing][Closing:1]]
];
}
# Closing:1 ends here

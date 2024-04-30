#!/usr/bin/bash

# initial compile workflow should be one of:
# - texify biber texify 
# - pdflatex biber pdflatex pdflatex
# but miktex doesn't use biber even when the .tex specifies it 
# this script creates a skeleton .tex then runs the initial compile 
# so using the TexlabBuild command in neovim will work without error 

SKELETON_TEX="$HOME/AppData/Local/nvim/tools/tex_skeletons/skeleton.tex"
SKELETON_BIB="$HOME/AppData/Local/nvim/tools/tex_skeletons/skeleton.bib"
SKELETON_BASENAME=`basename "$SKELETON_BIB"`

texname="$1"
texname_no_ext=`basename "$1" .tex`
bibname="${texname_no_ext}.bib"

echo $texname 
echo $texname_no_ext
echo $bibname

touch "$texname"
touch "$bibname"
cat "$SKELETON_TEX" >> "$texname"
cat "$SKELETON_BIB" >> "$bibname"

sed -i "s/${SKELETON_BASENAME}/${bibname}/g" "$texname"

texify "${pwd}/${texname} --pdf" 
#biber "$texname_no_ext"
#texify "${texname} --pdf"


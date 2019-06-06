#!/bin/sh
set -e


echo "Generating Static fonts"
mkdir -p ../Exports
for glyphs_file in $(ls *.glyphs)
do
  fontmake -g $glyphs_file -i -o ttf --output-dir ../Exports/
done

rm -rf master_ufo/ instance_ufo/


echo "Post processing"
ttfs=$(ls ../Exports/*.ttf)
for ttf in $ttfs
do
	gftools fix-dsig -f $ttf;
	ttfautohint $ttf $ttf.fix
	mv "$ttf.fix" $ttf;
	gftools fix-hinting $ttf
	mv "$ttf.fix" $ttf;
done


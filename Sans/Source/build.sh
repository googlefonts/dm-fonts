#!/bin/sh
set -e


echo "Generating Static fonts"
mkdir -p ../Exports
fontmake -g DeepMindSans-Roman.glyphs -i -o ttf --output-dir ../Exports/
fontmake -g DeepMindSans-Italic.glyphs -i -o ttf --output-dir ../Exports/

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


#!/bin/sh
set -e

mkdir -p ../fonts/otf ../fonts/ttf  ../fonts/webfonts

echo "Generating static TTFs"
fontmake -g Adamina.glyphs -o ttf --output-dir ../fonts/ttf/ -a

echo "Post processing static TTFs"
ttfs=$(ls ../fonts/ttf/*.ttf)
for ttf in $ttfs
do
	gftools fix-hinting $ttf
	mv "$ttf.fix" $ttf
	fonttools ttLib.woff2 compress $ttf
done

echo "Generating static OTFs"
fontmake -g Adamina.glyphs -o otf --output-dir ../fonts/otf/ -a


echo "Woff2"

mv ../fonts/ttf/*.woff2 ../fonts/webfonts

rm -rf master_ufo/ instance_ufo/ ../fonts/ttf/*backup*.ttf *.ufo ../instance_ufo Alike-Regular.designspace

echo "Done."
cd ..
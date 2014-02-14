#!/bin/sh

# Javascripts
for file in `find _site/assets/. -name "*.js"`
do
echo "Compressing $file …"
yui-compressor -o $file $file
done

# css 
for file in `find _site/assets/. -name "*.css"`
do
echo "Compressing $file …"
yui-compressor -o $file $file
done

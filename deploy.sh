#!/bin/bash
# Script for deploying a jekyll build to AWS

# override cache
if [ "$environment" != "production" ]; then
  echo "Overriding robots.txt for a $environment environment"
  rm _site/robots.txt
  echo "User-agent: * \nDisallow: /" > _site/robots.txt
fi

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

# Push the build using the s3_website.yml settings
bundle exec s3_website push --headless

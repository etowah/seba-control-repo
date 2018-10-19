ls install-*.list | xargs cat | xargs apt download 
dpkg-scanpackages -m . /dev/null | gzip -9c >  Packages.gz

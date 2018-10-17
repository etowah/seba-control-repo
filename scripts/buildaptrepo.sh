# Copy this file and the 2 list files into their own directory and run it to build an apt repo

xargs apt download < install-virtinst.list
xargs apt download < install-docker.list
dpkg-scanpackages -m . /dev/null | gzip -9c >  Packages.gz

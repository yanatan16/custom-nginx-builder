Download any custom modules you want like so:

```
cd /app/nginx-$VERSION/debian/modules
git clone https://github.com/zebrafishlabs/nginx-statsd nginx-statsd
```

Then add it to the rules

```
vim /app/nginx-$VERSION/debian/rules

--add-module=$(MODULESDIR)/nginx-statsd \
```

Then update the changelog at /app/nginx-$VERSION/debian/changelog

Then build

```
cd /app/nginx-$VERSION
dpkg-buildpackage -b
```

Then upload to your favorite host!

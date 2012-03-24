# About

This is the site that powers http://drug.org.pl. Feel free to improve it or adapt to your needs.

## How to start developing on Linux

```
  sudo apt-get install postgres libpq-dev     # install postgres server and client headers
  sudo su - postgres -c "createuser -s drug"  # create drug database superuser
  rake setup                                  # copy example config files, may need some tweaking
```

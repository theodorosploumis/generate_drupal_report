# Generate drupal report script

A bash script that generates basic Drupal 8.x packages and modules report in txt files. I use this for Maintenance & Updates Reports for Drupal sites.

It generates only **2 txt files**:

```
(prefix)_drupal_modules.txt
(prefix)_php_packages.txt
```

## Requirements
- composer
- drush
- Drupal site with database (because need to bootstrap site)

## Download and install

```
wget https://raw.githubusercontent.com/theodorosploumis/generate_drupal_report/master/generate_drupal_report.sh --no-check-certificate && chmod +x generate_drupal_report.sh && mv -f generate_drupal_report.sh /usr/local/bin/drupal-report
```

## Execute

```
cd [MY-DRUPAL-ROOT]
drupal-report
```


## Similar projects
- https://gist.github.com/theodorosploumis/02b4e4df8989cb0072dfbbbdf89922bd

## License
[MIT 2020](LICENSE)
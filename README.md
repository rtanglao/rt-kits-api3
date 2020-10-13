# rt-kits-api3
 Roland's Kitsune API scripts version 3
## 13October2020 Quoting rules
* You have to escape ```%``` but not ```+```. Complete list of characters have to escape can be found in the [YAML primer](https://docs.octoprint.org/en/master/configuration/yaml.html) and [Using Quotes with YAML Special Characters)](https://support.asg.com/mob/mvw/10_0/mv_ag/using_quotes_with_yaml_special_characters.htm) (tl;dr ```As simple rule of thumb, if your data contains any of these characters ```:-{}[]!#|>&%@``` better quote it. ``` and ```Use quotes in YAML if your value includes special characters. For example, these special characters may require quotes: {, }, [, ], ,, &, :, *, #, ?, |. -, <. >, =, !, %, @, \.``` ) 
* You need the quotation marks just like if you were doing it from bash or zsh

```bash
year=$(date -d "${timestamp}" +\%Y)
```
## 12October2020
* 1\. create Gemfile and ```bundler init```

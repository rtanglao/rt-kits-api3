# rt-kits-api3
 Roland's Kitsune API scripts version 3
## Status:

![get latest Firefox desktop questions](https://github.com/rtanglao/rt-kits-api3/workflows/get%20latest%20Firefox%20desktop%20questions/badge.svg)

## 27march2022 get by month sample SQL query
* using sql query from stack overflow: [How to select rows by date in sqlite](https://stackoverflow.com/questions/13020611/how-to-select-rows-by-date-in-sqlite) (the pacific time zone offset "-0800" appears ok?!?)

```sql
SELECT id, created from  "2021-yearly-ff-questions-en-us"  WHERE
 created >= date('2021-01-01') AND created  <  date('2021-02-01');
 Execution finished without errors.
```


Result: 2184 rows returned in 41ms
At line 1:
SELECT id, created, tags from  "2021-yearly-ff-questions-en-us"  WHERE
 created >= date('2021-01-01') AND created  <  date('2021-02-01');
```

## 27march2022 create sqlite file

```bash
roland@Rolands-MacBook-Air YEARLY_CSV_FILES % csvs-to-sqlite *.csv -dt created \ 
-dt updated 2021-firefox-sumo-questions.db
```
## 27march2022 get yearly CSV files

```bash
mkdir YEARLY_CSV_FILES
cd YEARLY_CSV_FILES
csvstack ../2021/*.csv > 2021-yearly-ff-questions-en-us.csv
```

## 13October2020 Quoting rules
* You have to escape ```%``` but not ```+```. Complete list of characters have to escape can be found in the [YAML primer](https://docs.octoprint.org/en/master/configuration/yaml.html) and [Using Quotes with YAML Special Characters)](https://support.asg.com/mob/mvw/10_0/mv_ag/using_quotes_with_yaml_special_characters.htm) (tl;dr ```As simple rule of thumb, if your data contains any of these characters ```:-{}[]!#|>&%@``` better quote it. ``` and ```Use quotes in YAML if your value includes special characters. For example, these special characters may require quotes: {, }, [, ], ,, &, :, *, #, ?, |. -, <. >, =, !, %, @, \.``` ) 
* You need the quotation marks just like if you were doing it from bash or zsh and ```%``` needs to be escaped but not ```+```

```bash
year=$(date -d "${timestamp}" +\%Y)
```
## 12October2020
* 1\. create Gemfile and ```bundler init```

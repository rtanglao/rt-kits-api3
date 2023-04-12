# rt-kits-api3
 Roland's Kitsune API scripts version 3
## Status:

![get latest Firefox desktop questions](https://github.com/rtanglao/rt-kits-api3/workflows/get%20latest%20Firefox%20desktop%20questions/badge.svg)

## 10april2023 issue 3686 still fails
* `./testAPI-issue-3686.rb`  still fails i.e. the time on the website is pacific but the time returned from the API says `Z` i.e. ``UTC`` but is actually ``PST`` (see [gist](https://gist.github.com/rtanglao/78d840c3f0b1f80312e895a5fd054ce3) for full details). IIRC this is because the timestamps are in the database and hard to change because of the database migration required.
## 02april2022 add a column to a CSV file
```bash
roland@Rolands-MacBook-Air YEARLY_CSV_FILES % csvjoin -c "id,id,id" csv1.csv csv2.csv csv3.csv 
id,stuff,stuff2,stuff3
1,22,stuff21,stuff31
2,44,stuff22,stuff32
```
## 27march2022 get by day of the year SQL query

```sql
SELECT strftime('%Y-%m-%d', created) AS yyyymmdd, count (*) as 'num_SUMO_questions'
FROM "2021-yearly-ff-questions-en-us"  
WHERE created >= date('2021-01-01', 'localtime') 
AND created  <  date('2022-01-01', 'localtime')
GROUP BY yyyymmdd
```
## 27march2022 get by month example SQL query

```sql
SELECT count (*) as 'number of questions by day'
FROM "2021-yearly-ff-questions-en-us"  
WHERE created >= date('2021-01-01', 'localtime') 
AND created  <  date('2021-02-01', 'localtime')
GROUP by strftime('%j', created);
```
## Sort CSV file by column 1: id

* `-c` which column to sort <-- column 1 is the `id` column, `-d ,` <-- sets the delimiter to comma

```bash
csvsort -c 1 -d , 2021-yearly-ff-questions-en-us.csv \ 
> sorted-by-id-2021-yearly-ff-questions-en-us.csv
```

### Better query to order by date

```sql
 created >= date('2021-01-01') AND created  <  date('2021-02-01')
 ORDER BY created ASC;
 ```
 
### Query
* using sql query from stack overflow: [How to select rows by date in sqlite](https://stackoverflow.com/questions/13020611/how-to-select-rows-by-date-in-sqlite) (the pacific time zone offset "-0800" appears ok?!?)

```sql
SELECT id, created from  "2021-yearly-ff-questions-en-us"  WHERE
 created >= date('2021-01-01') AND created  <  date('2021-02-01');
 Execution finished without errors.
```
### Output:
```
Result: 2184 rows returned in 41ms
At line 1:
SELECT id, created, tags from  "2021-yearly-ff-questions-en-us"  WHERE
 created >= date('2021-01-01') AND created  <  date('2021-02-01');
```

### Output as SQL

* 1 line of the output

```sql
INSERT INTO "main"."" ("id", "created", "tags") VALUES ('1320202', '2021-01-01T14:40:25-08:00', 
'desktop;other;windows-10;firefox-840;firefox-8401;');
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

# rt-kits-api3
 Roland's Kitsune API scripts version 3
## Status:

![get latest Firefox desktop questions](https://github.com/rtanglao/rt-kits-api3/workflows/get%20latest%20Firefox%20desktop%20questions/badge.svg)

## 2024-03-06 issue 3686 still fails

* `https://support.mozilla.org/api/2/question/1441694/` still returns `created:	"2024-03-06T14:48:31.939449Z"` the bug is that it should be `created:	"2024-03-06T22:48:31.939449Z"`

## 2023-09-19 issue 3686 still fails :-)
```bash
roland@Rolands-MacBook-Pro rt-kits-api3 % ./testAPI-issue-3686.rb  
{
                "answers" => [
        [ 0] 1222018,
        [ 1] 1222044,
        [ 2] 1222056,
        [ 3] 1222067,
        [ 4] 1222070,
        [ 5] 1222071,
        [ 6] 1222125,
        [ 7] 1222128,
        [ 8] 1222302,
        [ 9] 1222414,
        [10] 1222423,
        [11] 1225628
    ],
                "content" => "<p>Morning,\n</p><p>I've recently switched back to Firefox (for Mac) after being away from Ff for a long time, and have been tinkering with my settings and whatnot to try and get things the way I would like them. I suspect, like most things, that I'm just missing something.&nbsp;;-)\n</p><p>Basically, I don't want Ff to remember any autofill//form information, and I've got that working, but I would like it to be able to respect when a website allows you to click a radio button for \"Remember &lt;Me//This//Etc&gt;\". It does not seem to be doing that at the moment.\n</p><p>Does Ff have a setting that will let websites that you specifically click \"Remember Me\" be remembered, or is it an all or nothing?\n</p><p>Thanks!\n</p>",
                "created" => "2019-05-13T07:53:40Z",
                "creator" => {
            "username" => "mattagc",
        "display_name" => "Matt Campbell",
              "avatar" => "https://firefoxusercontent.com/a6acb0932f1dcc47ef32212bc9ad9394"
    },
                     "id" => 1259114,
               "involved" => [
        [0] {
                "username" => "jscher2000",
            "display_name" => "jscher2000 - Support Volunteer",
                  "avatar" => "https://firefoxusercontent.com/4c7c89d3462af52bac94074246fd5e98"
        },
        [1] {
                "username" => "mattagc",
            "display_name" => "Matt Campbell",
                  "avatar" => "https://firefoxusercontent.com/a6acb0932f1dcc47ef32212bc9ad9394"
        },
        [2] {
                "username" => "cor-el",
            "display_name" => "",
                  "avatar" => "https://firefoxusercontent.com/f369028d14003acbf4f1a9ed0debb2c8"
        }
    ],
            "is_archived" => true,
              "is_locked" => false,
              "is_solved" => false,
                "is_spam" => false,
               "is_taken" => false,
            "last_answer" => 1225628,
                 "locale" => "en-US",
               "metadata" => [
        [0] {
             "name" => "category",
            "value" => "privacy-and-security"
        },
        [1] {
             "name" => "ff_version",
            "value" => "66.0"
        },
        [2] {
             "name" => "os",
            "value" => "Mac OS"
        },
        [3] {
             "name" => "plugins",
            "value" => "* Shockwave Flash 32.0 r0"
        },
        [4] {
             "name" => "product",
            "value" => "desktop"
        },
        [5] {
             "name" => "useragent",
            "value" => "Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:66.0) Gecko/20100101 Firefox/66.0"
        }
    ],
                   "tags" => [
        [0] {
            "name" => "Mac OS",
            "slug" => "mac-os"
        },
        [1] {
            "name" => "desktop",
            "slug" => "desktop"
        },
        [2] {
            "name" => "privacy-and-security",
            "slug" => "privacy-and-security_1"
        },
        [3] {
            "name" => "Firefox 66.0",
            "slug" => "firefox-660"
        }
    ],
            "num_answers" => 12,
    "num_votes_past_week" => 0,
              "num_votes" => 1,
                "product" => "firefox",
               "solution" => nil,
              "solved_by" => nil,
            "taken_until" => nil,
               "taken_by" => nil,
                  "title" => "Firefox doesn't seem to be allowing websites to \"remember <random thing>\".",
                  "topic" => "privacy-and-security",
             "updated_by" => nil,
                "updated" => "2019-05-27T19:18:25Z"
}
"2019-05-13T07:53:40Z"
integer time in API:1557734020
integer time in SUMO website:1557759220
TEST FAILED! Difference in seconds sumo time - api time:25200
TEST FAILED! Difference in hours:7
roland@Rolands-MacBook-Pro rt-kits-api3 % 
```
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

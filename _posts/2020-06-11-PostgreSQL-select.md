---
layout: post
title:  "PostgeSQL Select Query"
date:   2020-06-11
edit:   2020-06-12
categories: [SQL, Note]
tags: [Language]
author: Q
---

`SELECT` retrieves rows from zero or more tables.

## Syntax

{% highlight sql %}
[ WITH [ RECURSIVE ] with_query [, ...] ]
SELECT [ ALL | DISTINCT [ ON ( expression [, ...] ) ] ]
    [ * | expression [ [ AS ] output_name ] [, ...] ]
    [ FROM from_item [, ...] ]
    [ WHERE condition ]
    [ GROUP BY grouping_element [, ...] ]
    [ HAVING condition [, ...] ]
    [ WINDOW window_name AS ( window_definition ) [, ...] ]
    [ { UNION | INTERSECT | EXCEPT } [ ALL | DISTINCT ] select ]
    [ ORDER BY expression [ ASC | DESC | USING operator ] [ NULLS { FIRST | LAST } ] [, ...] ]
    [ LIMIT { count | ALL } ]
    [ OFFSET start [ ROW | ROWS ] ]
    [ FETCH { FIRST | NEXT } [ count ] { ROW | ROWS } ONLY ]
    [ FOR { UPDATE | NO KEY UPDATE | SHARE | KEY SHARE } [ OF table_name [, ...] ] [ NOWAIT | SKIP LOCKED ] [...] ]

where from_item can be one of:

    [ ONLY ] table_name [ * ] [ [ AS ] alias [ ( column_alias [, ...] ) ] ]
                [ TABLESAMPLE sampling_method ( argument [, ...] ) [ REPEATABLE ( seed ) ] ]
    [ LATERAL ] ( select ) [ AS ] alias [ ( column_alias [, ...] ) ]
    with_query_name [ [ AS ] alias [ ( column_alias [, ...] ) ] ]
    [ LATERAL ] function_name ( [ argument [, ...] ] )
                [ WITH ORDINALITY ] [ [ AS ] alias [ ( column_alias [, ...] ) ] ]
    [ LATERAL ] function_name ( [ argument [, ...] ] ) [ AS ] alias ( column_definition [, ...] )
    [ LATERAL ] function_name ( [ argument [, ...] ] ) AS ( column_definition [, ...] )
    [ LATERAL ] ROWS FROM( function_name ( [ argument [, ...] ] ) [ AS ( column_definition [, ...] ) ] [, ...] )
                [ WITH ORDINALITY ] [ [ AS ] alias [ ( column_alias [, ...] ) ] ]
    from_item [ NATURAL ] join_type from_item [ ON join_condition | USING ( join_column [, ...] ) ]

and grouping_element can be one of:

    ( )
    expression
    ( expression [, ...] )
    ROLLUP ( { expression | ( expression [, ...] ) } [, ...] )
    CUBE ( { expression | ( expression [, ...] ) } [, ...] )
    GROUPING SETS ( grouping_element [, ...] )

and with_query is:

    with_query_name [ ( column_name [, ...] ) ] AS ( select | values | insert | update | delete )

TABLE [ ONLY ] table_name [ * ]
{% endhighlight %}

## Process Order

1. `WITH`
    All queries will be computed and serve as temporary tables that can be referenced in the `FROM` list. A `WITH` query can be referenced more than once while computed only once.

2. `FROM`
    If more than one element is specified, they are cross-joined together.

3. `WHERE`
    All rows do not satisfy the condition are eliminated from the output.

4. `GROUP BY`/aggregate function calls/`Having`
    The output will be combined into groups of rows then aggregated. If the `Having` clause is present, it eliminates groups that do not satisfy the given condition.

5. `SELECT`

6. `SELECT DISTINCT`/`SELECT DISTINCT ON`/`SELECT ALL`
    - `SELECT DISTINCT` eliminates duplicate rows from the result.
    - `SELECT DISTINCT ON` eliminates duplicate rows that match on all the specified expressions
    - `SELECT ALL` returns all candidate rows, including duplicates. It is the default behavior

7. `UNION`/`INTERSECT`/`EXCEPT`
    - `UNION` returns all rows that are in one or both of the result sets
    - `INTERSECT` returns all rows that are strictly in both result sets
    - `EXCEPT` returns the rows that are in the fist result but not in the second

    In all three cases, duplicate rows are eliminated unless `ALL` is specified

8. `ORDER BY`
    The returned rows are sorted in the specified order

9. `LIMIT`
    The `SELECT` statement only returns a subset of the result rows

10. `FOR UPDATE`/`FOR NO KEY UPDATE`/`FOR SHARE`/`FOR KEY SHARE`
    The `SELECT` statement locks the selected rows against concurrent updates

## Example

To join the table `flights` with the table `logs`:

{% highlight sql %}
SELECT
    f.code, f.company
FROM
    flights f, logs l
WHERE
    f.date = l.date;
{% endhighlight %}

To retrieve from the table `flights` with some constraints:

{% highlight sql %}
SELECT
    f.code, f.company
FROM
    flights f
WHERE
    f.date = '2009-02-03';

--

SELECT
    f.code, f.company
FROM
    flights f
LIMIT 10;

--

SELECT
    code, company
FROM
    flights
ORDER BY
    capacity;
{% endhighlight %}

To obtain the union of the tables `flights` with `logs`:

{% highlight sql %}
SELECT
    flights.date
FROM
    flights
WHERE
    flights.code LIKE '%A%'
UNION
SELECT
    logs.date
FROM
    logs;
{% endhighlight %}

References:

- <https://www.postgresql.org/docs/9.5/sql-select.html>

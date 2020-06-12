---
layout: post
title:  "PostgeSQL Delete Query"
date:   2020-06-12
edit:   2020-06-12
categories: [SQL, Note]
tags: [Language]
author: Q
---

`DELETE` removes rows that satisfy the `WHERE` clause from the specified table. If the `WHERE` clause is not specified, all rows will be moved.

## Syntax

{% highlight sql %}

[ WITH [ RECURSIVE ] with_query [, ...] ]
DELETE FROM [ ONLY ] table_name [ * ] [ [ AS ] alias ]
    [ USING from_item [, ...] ]
    [ WHERE condition | WHERE CURRENT OF cursor_name ]
    [ RETURNING * | output_expression [ [ AS ] output_name ] [, ...] ]

{% endhighlight %}

## Example

Delete all logs but the ones on 2009/06/01:

{% highlight sql %}

DELETE FROM
    logs
WHERE
    date <> '2009-06-01';
{% endhighlight %}

Clear the table `logs`:

{% highlight sql %}

DELETE FROM logs;

{% endhighlight %}

References:

- <https://www.postgresql.org/docs/9.5/sql-delete.html>

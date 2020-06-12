---
layout: post
title:  "PostgeSQL Insert Query"
date:   2020-06-09
edit:   2020-06-12
categories: [SQL, Note]
tags: [Language]
author: Q
---

Query `INSERT` is used to create new rows in a table. In other words, it creates new data. In PostgreSQL, insertion can be one or more rows of data resulting zero or more rows of creation.

## Syntax

{% highlight sql %}
[ WITH [ RECURSIVE ] with_query [, ...] ]
INSERT INTO table_name [ AS alias ] [ ( column_name [, ...] ) ]
    { DEFAULT VALUES | VALUES ( { expression | DEFAULT } [, ...] ) [, ...] | query }
    [ ON CONFLICT [ conflict_target ] conflict_action ]
    [ RETURNING * | output_expression [ [ AS ] output_name ] [, ...] ]

where conflict_target can be one of:

    ( { index_column_name | ( index_expression ) } [ COLLATE collation ] [ opclass ] [, ...] ) [ WHERE index_predicate ]
    ON CONSTRAINT constraint_name

and conflict_action is one of:

    DO NOTHING
    DO UPDATE SET { column_name = { expression | DEFAULT } |
                    ( column_name [, ...] ) = ( { expression | DEFAULT } [, ...] ) |
                    ( column_name [, ...] ) = ( sub-SELECT )
                  } [, ...]
              [ WHERE condition ]
{% endhighlight %}

## Example

Insert a single row into table `flights`:

{% highlight sql %}
INSERT INTO flights VALUES
    ('UA5502', 'United Airline', 200, '2009-02-03');

INSERT INTO flights (code, company, capacity, date) VALUES
    ('UA5502', 'United Airline', 200, '2009-02-03');

INSERT INTO flights (code, company, capacity, date) VALUES
    ('UA5502', 'United Airline', 200, DEFAULT);

INSERT INTO flights DEFAULT VALUES;
{% endhighlight %}

Insert multiple rows into table `flights`:

{% highlight sql %}
INSERT INTO flights (code, company, capacity, date) VALUES
    ('UA5502', 'United Airline', 200, '2009-02-03')
    ('JB2245', 'Jet Blue', 150, '2009-04-03');

INSERT INTO flights SELECT * FROM current_flights WHERE company == 'United Airline';
{% endhighlight %}

Return information:

{% highlight sql %}
INSERT INTO flights VALUES
    ('UA5502', 'United Airline', 200, '2009-02-03')
RETURNING id;

INSERT INTO flights VALUES
    ('UA5502', 'United Airline', 200, '2009-02-03')
RETURNING *;
{% endhighlight %}

On conflict:

{% highlight sql %}
INSERT INTO flights (code, company, capacity, date) VALUES
    ('UA5502', 'United Airline', 200, '2009-02-03')
ON CONFLICT (code, date) DO NOTHING;

-- Update capacity and company
INSERT INTO flights (code, company, capacity, date) VALUES
    ('UA5502', 'United Airline', 200, '2009-02-03')
ON CONFLICT (code, date) DO UPDATE SET
    capacity = EXCLUDED.capacity
AND company = EXCLUDED.company;
{% endhighlight %}

References:

- <https://www.postgresql.org/docs/9.5/sql-insert.html>
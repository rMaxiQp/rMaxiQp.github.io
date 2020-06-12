---
layout: post
title:  "PostgeSQL Update Query"
date:   2020-06-11
edit:   2020-06-12
categories: [SQL, Note]
tags: [Language]
author: Q
---

`UPDATE` changes the values of the specified columns in all rows that meet the condition.

## Syntax

```.txt
[ WITH [ RECURSIVE ] with_query [, ...] ]
UPDATE [ ONLY ] table_name [ * ] [ [ AS ] alias ]
    SET { column_name = { expression | DEFAULT } |
          ( column_name [, ...] ) = ( { expression | DEFAULT } [, ...] ) |
          ( column_name [, ...] ) = ( sub-SELECT )
        } [, ...]
    [ FROM from_item [, ...] ]
    [ WHERE condition | WHERE CURRENT OF cursor_name ]
    [ RETURNING * | output_expression [ [ AS ] output_name ] [, ...] ]
```

## Example

Update the column `capacity` of the table `flights`:

```.sql
UPDATE
    flights
SET
    capacity = 300
WHERE
    code = 'UA5502'
AND date = '2009-02-03';

--

UPDATE
    flights
SET
    capacity = DEFAULT
WHERE
    code = 'UA5502'
AND date = '2009-02-03';

--

UPDATE
    flights
SET
    capacity = capacity + 1
WHERE
    code = 'UA5502'
AND date = '2009-02-03';
```

Update the table `flights` using the table `logs`'s information:

{% highlight sql %}
UPDATE
    flights
SET
    capacity = DEFAULT
FROM
    logs
WHERE
    logs.event = 'Arrival'
AND flights.date = '2009-02-03';

--

UPDATE
    flights
SET
    capacity = DEFAULT
WHERE
    date = (
    SELECT
        date
     FROM
        logs
     WHERE
        log.event = 'Arrival'
     AND log.id = 55021
    );
{% endhighlight %}

References:

- <https://www.postgresql.org/docs/9.5/sql-update.html>

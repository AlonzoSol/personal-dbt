{% test primary_key(model, column) %}

with validation as (
    select {{ column }} as primary_key
    from {{ model }}
),

null_errors as (
    select *
    from  validation
    where primary_key is null
),

unique_errors as (
    select
        primary_key,
        count(*) as n
    from validation
    where primary_key is not null
    group by primary_key
    having count(*) > 1
),

joined_errors as (
	select primary_key
	from null_errors
		full join unique_errors using(primary_key) 
)

select *
from joined_errors

{% endtest %}
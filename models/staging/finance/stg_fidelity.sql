with source as (
    select * from {{ ref('fidelity') }}
),

final as (
    select
        "Run Date"::timestamptz as timestamp_utc,
        "Action" as transaction,
        "Amount ($)"::numeric as amount,
        "Cash Balance ($)" as balance
    
    from source
)

select * from final
with source as (
    select * from {{ ref('fidelity') }}
),

final as (
    select
        "Run Date" as date,
        "Action" as transaction,
        "Amount ($)" as amount,
        "Cash Balance ($)" as balance
    
    from source
)

select * from final
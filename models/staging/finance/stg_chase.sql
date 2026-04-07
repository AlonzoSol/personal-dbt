with source as (
    select * from {{ ref('chase') }}
),

final as (
    select
        "Transaction Date" as transaction_date,
        "Post Date" as post_date,
        "Description" as description,
        "Category" as category,
        "Type" as type,
        "Amount" as amount,
        "Memo" as memo
        
    from source
)

select * from final
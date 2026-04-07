with source as (
    select * from {{ ref('chase') }}
),

final as (
    select
        "Transaction Date"::date as transaction_date,
        "Post Date"::date as post_date,
        "Description" as description,
        "Category" as category,
        "Type" as type,
        "Amount"::numeric as amount,
        "Memo" as memo

    from source
)

select * from final
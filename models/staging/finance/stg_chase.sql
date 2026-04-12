with source as (
    select * from {{ ref('chase') }}
),

typed as (
    select
        "Transaction Date"::date as transaction_date,
        "Post Date"::date as post_date,
        "Description" as description,
        "Category" as category,
        "Type" as type,
        "Amount"::numeric as amount,
        "Memo" as memo

    from source
),

indexed as (
    select
        *,
        row_number(transaction_date, description, amount) as index
    from typed
),

final as (
    select
        {{ dbt_utils.generate_surrogate_key(['transaction_date', 'description', 'amount']) }} as primary_key,
        *
    from indexed
)

select * from final
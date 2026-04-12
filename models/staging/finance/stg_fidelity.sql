with source as (
    select * from {{ ref('fidelity') }}
),

typed as (
    select
        "Run Date"::date as transaction_date,
        "Action" as transaction,
        "Amount ($)"::numeric as amount,
        "Cash Balance ($)" as balance
    
    from source
),

indexed as (
    select
        *,
        row_number() OVER (partition by transaction_date, transaction, amount) as index
    from typed
),

final as (
    select
        {{ dbt_utils.generate_surrogate_key(['transaction_date', 'transaction', 'amount', 'index']) }} as primary_key,
        *
    from indexed
)

select * from final
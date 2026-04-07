with source as (
    select * from {{ ref('fidelity') }}
)


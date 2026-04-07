with source as (
    select * from {{ ref('chase') }}
)
with 

source as (

    select * from {{ source('ingesta', 'municipios') }}

),

renamed as (

    select *

    from source

)

select * from renamed
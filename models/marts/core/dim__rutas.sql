{{ config(materialized = 'table') }}

select *
from {{ref('stg__rutas')}}

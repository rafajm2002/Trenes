{% snapshot snap_estaciones %}

{{
    config(
        target_schema='snapshots',
        unique_key='_id',
        strategy='check',
        check_cols=[
            'CERCANIAS',
            'FEVE',
            'COMUN'
        ]
    )
}}

SELECT *
FROM {{ source('ingesta', 'estaciones') }}

{% endsnapshot %}
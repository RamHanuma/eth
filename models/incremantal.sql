
{{config(materialized = 'incremental',
          incremental_strategy  = 'merge' ,
          unique_key = 'hash',
          on_schema_change = 'sync_all_columns'
        
          )
}}

select

*

from {{ source('eth_source', 'transactions') }} t

{% if is_incremental() %}

  where date > (select max(date) from {{ this }})

{% endif %}
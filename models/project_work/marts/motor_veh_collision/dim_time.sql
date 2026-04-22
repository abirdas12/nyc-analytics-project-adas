WITH time AS (
    SELECT DISTINCT 
        crash_time 
    FROM {{ref('staging_tbl_veh_collision')}}
    WHERE crash_time IS NOT NULL 

)

,dim_time AS (
    SELECT 
        {{ dbt_utils.generate_surrogate_key([
            'EXTRACT(HOUR FROM crash_time)'
            ,'EXTRACT(MINUTE FROM crash_time)'
        ]) }} AS time_key
        ,CAST(COALESCE(EXTRACT(HOUR FROM crash_time),0) AS INT)   AS hour
        ,CAST(COALESCE(EXTRACT(MINUTE FROM crash_time),0) AS INT) AS minute
    FROM time
)

SELECT *
FROM dim_time
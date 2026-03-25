-- Clean and standardize NYC Open Restaurant Applications data
WITH source AS (
   SELECT * FROM {{ source('raw', 'source_nyc_open_restaurant_apps') }}
),
cleaned AS (
   SELECT
       CAST(objectid AS STRING) AS restaurant_id,
       CAST(restaurant_name AS STRING) AS restaurant_name,
       CAST(account_name AS STRING) AS account_name,
       CAST(legal_business_name AS STRING) AS legal_business_name,
       CAST(doing_business_as_dba AS STRING) AS doing_business_as_dba,
       CAST(borough AS STRING) AS borough,
       CAST(zip AS STRING) AS zip_code,
       CAST(street AS STRING) AS street,
       CAST(building_number AS STRING) AS building_number,
       CAST(business_address AS STRING) AS business_address,
       CAST(seating_interest_sidewalk AS STRING) AS seating_interest_sidewalk,
       CAST(seating_interest_roadway AS STRING) AS seating_interest_roadway,
       CAST(seating_interest_both AS STRING) AS seating_interest_both,
       CAST(approved_for_sidewalk_seating AS STRING) AS approved_for_sidewalk_seating,
       CAST(approved_for_roadway_seating AS STRING) AS approved_for_roadway_seating,
       CAST(qualitative_status AS STRING) AS qualitative_status,
       CAST(latitude AS STRING) AS latitude,
       CAST(longitude AS STRING) AS longitude,
       CAST(time_of_submission AS STRING) AS time_of_submission,
       CURRENT_TIMESTAMP() AS _stg_loaded_at
   FROM source
   WHERE objectid IS NOT NULL
   QUALIFY ROW_NUMBER() OVER (PARTITION BY objectid ORDER BY objectid) = 1
)
SELECT * FROM cleaned
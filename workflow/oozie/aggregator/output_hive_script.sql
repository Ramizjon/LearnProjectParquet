use segments;
drop table if exists temp_table;

create external table temp_table (
  userId string,
  command string,
  segmentTimestamps map<string,string>
)
  STORED AS PARQUET
  LOCATION "${outputDir}";

CREATE TABLE IF NOT EXISTS user_operations_parquet (
  userId string,
  command string,
  segmentTimestamps map<string,string>)
 PARTITIONED BY (
  year string,
  month string,
  day string,
  hour string
)
  STORED AS PARQUET;

  INSERT INTO TABLE user_operations_parquet
  PARTITION
 (year = ${year},
 month = ${month},
 day = ${day},
 hour = ${hour})
 SELECT * FROM temp_table;
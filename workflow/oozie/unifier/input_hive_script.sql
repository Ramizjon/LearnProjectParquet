use segments;
DROP TABLE temp_users;

CREATE EXTERNAL TABLE IF NOT EXISTS temp_users(
     userId string,
     command string,
     segmentTimestamps map<string,string>
)
STORED AS PARQUET
LOCATION "${inputDir}";

CREATE TABLE IF NOT EXISTS user_operations_raw (
   userId string,
   command string,
   segmentTimestamps map<string,string>
)
PARTITIONED BY (
  year string,
  month string,
  day string,
  hour string,
  provider string
)
STORED AS PARQUET;

INSERT INTO TABLE user_operations_raw
PARTITION (year = ${year}, month = ${month}, day = ${day}, hour = ${hour}, provider = "${provider}")
SELECT * FROM temp_users;

DROP TABLE temp_users;
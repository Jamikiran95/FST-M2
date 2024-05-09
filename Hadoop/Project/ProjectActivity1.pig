-- Load the input file
lines = LOAD 'hdfs:///user/root/inputs' USING PigStorage(',') AS (character:chararray, line:chararray);

-- Group the lines by character and calculate the sum of lines spoken by each character
grouped_lines = GROUP lines BY character;
line_count = FOREACH grouped_lines GENERATE group AS character, COUNT(lines) AS lines_spoken;

-- Order the result in descending order of lines spoken
ordered_result = ORDER line_count BY lines_spoken DESC;

-- Store the result
STORE ordered_result INTO 'output_directory' USING PigStorage(',');

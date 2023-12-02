from pyspark import SparkContext
from pyspark.sql import SparkSession
import pyspark.sql.functions as sf 
import sys 

# %%

def iabs_from_newline_list(infile: str, outfile: str) -> None:

    spark = SparkSession(SparkContext("local", "create_iabs"))

    file_df = spark.read.text(infile)

    lowercase_df = file_df.withColumn("lower", sf.lower("value"))

    commands_df = lowercase_df.withColumn("command", sf.concat(
        sf.lit(r"vim.cmd('iab "), sf.col("lower"), sf.lit(" "), 
               sf.col("value"), sf.lit("')")))

    commands = commands_df.select("command")

    commands.write.mode("overwrite").text(outfile)

# %%

iabs_from_newline_list(sys.argv[1], sys.argv[2])

# %%



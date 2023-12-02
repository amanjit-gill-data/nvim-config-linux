from pyspark import SparkContext
from pyspark.sql import SparkSession
import pyspark.sql.functions as sf 
import sys 

# %%

def iabs_from_comma_list(infile: str, outdir: str) -> None:

    spark = SparkSession(SparkContext("local", "create_iabs"))

    file_df = spark.read.text(infile)

    words_df = file_df.select(sf.explode(sf.split("value", ",")))
    words_df = words_df.select(sf.trim("col").alias("upper"))

    lowercase_df = words_df.withColumn("lower", sf.lower("upper"))

    commands_df = lowercase_df.withColumn("command", sf.concat(
        sf.lit(r"vim.cmd('iab "), sf.col("lower"), sf.lit(" "), 
               sf.col("upper"), sf.lit("')")))

    commands = commands_df.select("command")

    commands.write.mode("overwrite").text(outdir)

# %%

iabs_from_comma_list(sys.argv[1], sys.argv[2])

# %%



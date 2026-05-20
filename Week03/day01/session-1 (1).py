# Databricks notebook source
df = spark.read.format("csv").load("/Volumes/workspace/default/myfiles/empData.csv")
display(df)

# COMMAND ----------

df = spark.read.format("csv").load("/Volumes/workspace/default/myfiles/Big Sales.csv")
display(df)
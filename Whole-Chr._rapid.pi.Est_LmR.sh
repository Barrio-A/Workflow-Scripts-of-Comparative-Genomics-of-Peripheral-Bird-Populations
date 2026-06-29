#!/bin/bash

awk '$2 != "NA" {sum += $2; n++} END {if(n>0) print sum/n}' AfS_diversity_mean_per_chromosome.txt > result_mean_genome_AfS.txt

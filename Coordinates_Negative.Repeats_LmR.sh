#!/bin/bash

zcat bLanMin_hap1.Repeats.4jb.gff3.gz | cut -f1,4,5 | gzip > repeats_coord.Lm.gff3.gz

cut -f1,2 bLanMin1.curated_primary.no_mt.scrubbed.fa.fai | grep '^scaffold_' > genome.Lm.scaffolds.tsv

zcat repeats_coord.Lm.gff3.gz | \
awk 'BEGIN{OFS="\t"} !/^#/ && $1 ~ /^scaffold_/ {print $1,$2-1,$3}' \
> repeats.Lm.scaffolds.bed
bedtools sort -i repeats.Lm.scaffolds.bed -g genome.Lm.scaffolds.tsv \
> repeats.Lm.scaffolds.sorted.bed
bedtools merge -i repeats.Lm.scaffolds.sorted.bed \
> repeats.Lm.scaffolds.merged.bed
bedtools complement -i repeats.Lm.scaffolds.merged.bed \
-g genome.Lm.scaffolds.tsv \
> repeats.Lm.negative.scaffolds.bed
awk 'BEGIN{OFS=""} {print $1,":",$2+1,"_",$3}' \
repeats.Lm.negative.scaffolds.bed > repeats.Lm.negative_format.scaffolds.bed

cut -f1,2 bLanMin1.curated_primary.no_mt.scrubbed.fa.fai | grep '^SUPER_' > genome.Lm.SUPER.tsv
zcat repeats_coord.Lm.gff3.gz | \
awk 'BEGIN{OFS="\t"} !/^#/ && $1 ~ /^SUPER_/ {print $1,$2-1,$3}' \
> repeats.Lm.SUPER.bed
bedtools sort -i repeats.Lm.SUPER.bed -g genome.Lm.SUPER.tsv \
> repeats.Lm.SUPER.sorted.bed
bedtools merge -i repeats.Lm.SUPER.sorted.bed \
> repeats.Lm.SUPER.merged.bed
bedtools complement -i repeats.Lm.SUPER.merged.bed \
-g genome.Lm.SUPER.tsv \
> repeats.Lm.negative.SUPER.bed
awk 'BEGIN{OFS=""} {print $1,":",$2+1,"_",$3}' \
repeats.Lm.negative.SUPER.bed > repeats.Lm.negative_format.SUPER.bed

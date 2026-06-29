#!/bin/bash

N_SITES=$((`zcat Lm_angsd.autosomes.pos.gz| wc -l`))
ngsF-HMM \
	--geno Lm_angsd.autosomes.glf \
	--pos Lm_angsd.autosomes.pos.gz \
	--n_ind 2 \
	--n_sites $N_SITES \
	--loglkl \
	--freq e \
	--freq_est 1 \
	--indF 0.1-0.1 \
	--n_threads 2 \
	--seed 212 \
	--out Lm_IBD_ngsF-HMM.results \
    --verbose 2 \
    --log 1

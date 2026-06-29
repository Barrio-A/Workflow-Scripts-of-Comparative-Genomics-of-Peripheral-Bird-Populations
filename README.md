---
# Workflow-Scripts-of-Comparative-Genomics-of-Peripheral-Bird-Populations
Bioinformatic workflows for comparative conservation genomics analyses of peripheral, threatened bird populations versus non-threatened populations from same species. Specifically, computational pipelines for genome-wide diversity (π), inbreeding (ROHs &amp; IBDs) and recent demographic history analyses ( SMC++).


## Bioinformatic Workflow
It is only shown one of the two species used for the project (*Lanius minor*). The analyses followed the general computational pipeline below:

---

### 1. Download Data

**Get the RawData, paired-end reads (pair-wise), from the Dataset of Interest (SRR)**
- SRA Toolkit v3.3.0 *(14 threads)*

[*SCRIPT HERE*](./DownloadRawData_SRATools_LmR.sh)

### 2. Raw sequencing data processing

**Cleaning Assessment: Quality Analysis, Filtering & Treaming**
- FastQC v0.12.1 *(12 threads)*
- fastp v0.23.2 *(12 threads)*
- cutadapt v2.6 *(12 threads)*

[*SCRIPT HERE*](./Filter-Quality_LmR.sh)

### 3. Mapping Clean Data & Depth Quantiles

**Paired-end read merging, reference indexing, read mapping, duplicate marking/removal, sorting and indexing again, until get the final BAM file**
- BWA v0.7.16a *(14 threads)*
- BBMap v38.18 *(14 threads)*
- picard v2.18.29 *(14 threads)*
- SAMtools v1.21 *(14 threads)*

[*SCRIPT HERE*]

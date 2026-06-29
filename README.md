---
# Workflow Scripts of Comparative Genomics of Peripheral Bird Populations
Bioinformatic workflows for comparative conservation genomics analyses of peripheral, threatened bird populations versus non-threatened populations from same species. Specifically, computational pipelines for genome-wide diversity (π), inbreeding (ROHs &amp; IBDs) and demographic history analyses (SMC++).

<img width="1920" height="1080" alt="ANDREA_WORKFLOW_TFM_1" src="https://github.com/user-attachments/assets/686a1acc-adf8-4d15-98d0-d8e75de117ec" />

## Bioinformatic Workflow
It is only shown one of the two populations (LmR) used for comparative assesments, from the two total species used for the project (*Lanius minor*). The analyses followed the general computational pipeline below:

---

### 1. Download Data

**Get the RawData, paired-end reads (pair-wise), from the Dataset of Interest (SRR)**
- SRA Toolkit v3.3.0 *(14 threads)*

[*DOWNLOAD_SCRIPT HERE*](./DownloadRawData_SRATools_LmR.sh)

### 2. Raw sequencing data processing

**Cleaning Assessment: Quality Analysis, Filtering & Treaming**
- FastQC v0.12.1 *(12 threads)*
- fastp v0.23.2 *(12 threads)*
- cutadapt v2.6 *(12 threads)*

[*FILTERING_SCRIPT HERE*](./Filter-Quality_LmR.sh)

### 3. Genome Mapping, BAM processing & Depth Quantiles

**Paired-end read merging, reference indexing, read mapping, duplicate marking/removal, sorting and indexing again, until get the final BAM file**
- BWA v0.7.16a *(12 threads)*
- BBMap v38.18 *(12 threads)*
- picard v2.18.29 *(12 threads)*
- SAMtools v1.21 *(12 threads)*
- R v4.3.3

[*MAPPING_DEPTH.COVERAGE_SCRIPT HERE*](./Mapping-&-Coverage.Depth_LmR.sh)

[*DEPTH.QUANTILES_SCRIPT HERE*](./Depth_Quantiles_LmR_.R)

### 4. Analysis of Next Generation Sequencing Data (ANGSD)

**Data Preparation Processes, Diverse Population Genetic Variation Analyses**
- bedtools v2.31.1 *(12 threads)*
- ANGSD v0.941 *(8 threads)*

[*NEGATIVE.REPEATS_COORDINATES_SCRIPT HERE*](./Coordinates_Negative.Repeats_LmR.sh)

[*ANGSD_I_SCRIPT_BOTH.POPULATIONS HERE*](./ANGSD_Lm.All.sh)

[*ANGSD_I_SCRIPT_ONE-SPECIFIC.POPULATION HERE*](./ANGSD_LmR.sh)

[*ANGSD_II_SCRIPT HERE*](./Sfs_Theta_Global.Statistics_LmR.sh)

### 5. Estimation, Comparison & Visualization of Nucleotide Diversity (π) Between Populations

**Nucleotide Diversity Analyses & Plotting. Only Super-Scaffold 'SUPER_1' as example**
- R v4.3.3
  
[*PREPARATION.CSV_FOR_NUCLEOTIDE.DIVERSITY.PLOTS_SCRIPT HERE*](./Windows_pi.Depth.nSites.csv_LmR.sh)

[*CHR._NUCLEOTIDE.DIVERSITY_SCRIPT HERE*](./Mean.pi.per.Chr_LmR.R)

[*WHOLE-GENOME_NUCLEOTIDE.DIVERSITY_SCRIPT HERE*](./Whole-Chr._rapid.pi.Est_LmR.sh)

[*NUCLEOTIDE.DIVERSITY.PLOT_ONE.POPULATION_SCRIPT HERE*](./Mean.pi+pi_LmR.R)

[*NUCLEOTIDE.DIVERSITY.PLOT_TWO.POPULATIONS_SCRIPT HERE*](./Nucleotide-Diversity-&-Mean-pi_LmRvsLmV.R)

[*NUCLEOTIDE.DIVERSITY.DEPTH.SITES.PLOT_TWO.POPULATIONS_SCRIPT HERE*](./Pi+mean.pi+Depth+nSites_LmRvsLmV.R)

### 6. Identification of Runs of Homozigosity (ROH)

**Identification of invariant regions at a chromosome-level of the genome**
- ROHan v1.0 *(24 threads)*

[*ROH_SCRIPT HERE*](./ROH_LmR.sh)

### 7. Inference of Identity-By-Descent (IBD) Tracts

**Detect potentially candidate regions to be Identity-By-Descent, direct signs of inbreeding, at a chromosome-level**
- ngsF-HMM v1.1.0 *(2 threads)*

[*IBD_SCRIPT HERE*](./IBD_LmR.sh)

### 8. Inference of Demographic History with a Sequentially Markovian Coalescent (SMC) Approach:

**Infer demographic trajectories from a single-individual whole-genome sequencing data**
- SMC++ v1.15.2 *(12 threads)*
- BCFtools v1.22 *(12threads)*

[*BCF.TO.VCF_CONVERSION_SCRIPT HERE*](./VCF_Lm.All.sh)

[*DEMOGRAPHIC.INFERENCE_SCRIPT HERE*](./HistoryDemographic.Inference_LmR.sh)


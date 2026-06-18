# Corophioid Amphipod Phylogenomics

## PLANNED ANALYSIS FOR GENERATING COROPHIOID AMPHIPOD PHYLOGENY FROM TRANSCRIPTOMES AND TARGETED DNA SEQUENCES

---

Principle Investigators: Brittany Cummings, Gustav Paulay, Joseph Ryan\
Draft or Version Number: v.2.1\
Date: 01 February 2023

## LIST OF ABBREVIATIONS

---

**ABBREVIATIONS TO BE ADDED**

## 1. INTRODUCTION: BACKGROUND INFORMATION AND SCIENTIFIC RATIONALE

---

### 1.1 Background Information

Corophioids *sensu lato* (Amphipoda: Corophiida) are distinctive components of marine epifaunal and biofouling communities with highly varied body forms and an unclear evolutionary history. Morphology suggests that silk glands ignited a cascade of key innovations that first led to tube-dwelling, then to diverse free-living lifestyles (Myers & Lowry, 2003). A phylogenetic framework is needed to test hypotheses regarding how corophioids transitioned to multiple body types, but previous evolutionary studies suffer from scant fossil records, homoplasious traits, and a historical reliance on morpho-taxonomy or insufficient gene markers. This project will use phylogenomic methods to generate a molecular phylogeny of corophioid amphipods and investigate the diversification of their morphological innovations. Specifically, RNA-seq and DNA target enrichment will be used to sequence numerous gene characters from multiple genera of corophioid families. Here, we present the pipeline of our phylogenomic analysis of corophioids using 22 unpublished and 1 published corophioid transcriptome, 25 published and 2 unpublished crustacean transcriptomes, and 1 published and 1 unpublished crustacean genome that will serve as outgroups.

### 1.2 Rationale

Despite hypotheses about key innovations, there is no robust phylogenetic framework to reconstruct the history of trait acquisition across the corophioid clade. Identifying the traits that preceded diversification events are key to understanding how corophioids radiated into numerous morphologies and lifestyles. However, previous phylogenetic analyses have failed to resolve the evolutionary relationships between corophiidean amphipods. Even though amphipod characters are highly homoplastic (Berge et al., 2000; Hurt et al., 2013), most comprehensive phylogenetic studies of amphipods use morphological traits to reconstruct evolutionary relationships (Kim & Kim, 1993; Berge et al., 2000; Myers & Lowry, 2003; Lowry & Myers, 2013, 2017). Moreover, phylogenetic analyses that have considered genetic differentiation in corophiideans are insufficient to resolve evolutionary relationships between major groups. This study uses phylogenomic analysis of next-generation sequencing (NGS) data to obtain numerous gene characters and more robust reconstruction of evolutionary relationships between organisms (Wen et al., 2015).

### 1.3 Objectives

The objective of this study is to generate a robust phylogeny of corophioid amphipods using phylogenomic methods and reconstruct the evolutionary history of key morphological characters and modes of life among corophioid families. The resulting tree will be used to assess sequence and frequency of major morphological and ecological transitions in this diverse group.

---

## 2. TRANSCRIPTOMES

### 2.1 Acquiring transcriptomes

For this study we will use novel transcriptomes and publicly available corophioid transcriptomes.

#### 2.1.1 *Corophioid Transcriptomes*

We will acquire corophioid transcriptomes from our own sequencing efforts and publicly available data.

##### *Sequenced Transcriptomes*

Upload our unpublished transcriptomes to the server using methods suited to respective file origins.

For transcriptomes on the local computer, upload using ```scp```.

```bash
scp [local_directory]/[TRANSCRIPTS_R1].fastq.gz [local_directory]/[TRANSCRIPTS_R2].fastq.gz username@servername:[receiving_directory]
```

For transcriptomes straight from sequencing company, transfer from their remote server.

```bash
# While logged into server:
sftp kmkocot_ua@sftp.genewiz.com
Password: [ENTER HERE]
lcd [receiving_directory] #changes working directory to folder that receives files
cd [directory_w_files_to_transfer]
get -a -r [TRANSCRIPTS_R1].fastq.gz [TRANSCRIPTS_R2].fastq.gz
```

For transcriptomes from external hard drives, manually upload using Cyberduck.

##### *Public Transcriptomes*

Download publicly available corophioid transcriptomes from the SRA database.

Search for SRR sequences on the SRA database (<https://www.ncbi.nlm.nih.gov/sra>) using the search parameters below.

```bash
taxa name [ORGN] AND Illumina BUTNOT genotyping BUTNOT metagenome BUTNOT miRNA
```

Download and split the paired-end SRR sequences into F and R reads using SRA toolkit (<https://trace.ncbi.nlm.nih.gov/Traces/sra/sra.cgi?view=software>) then rename and compress the FASTQ files.

> **NOTE:**
Some of the SRR sequences from the SRA database will have already been assembled and uploaded to the NCBI TSA database. If possible, try to only use SRR sequences so that you can use your Trinity command line codes and keep assembly methods consistent. However, if only assembled transcriptome is available, use the assembled file and skip to Section 2.3.

* You may have to run the SRA Toolkit configuration before running the below commands. To do this, enter the "vdb-config --interactive" command, save all default settings, and exit the configuration before proceeding.

```bash
prefetch SRR[number] &
```

```bash
fastq-dump --defline-seq '@$sn[_$rn]/$ri' --split-files SRR7056353 > fqd.SRR7056353.out 2> fqd.SRR7056353.err &
```

```bash
mv SRR7056353_1.fastq SRR7056353_pass_1.fastq
mv SRR7056353_2.fastq SRR7056353_pass_2.fastq
```

```bash
pigz -9 SRR7056353_pass_1.fastq &
pigz -9 SRR7056353_pass_2.fastq &
```

##### *Public Genomes*

Download publicly available corophioid and outgroup genome data from the NCBI Genome database, and upload to server manually using Cyberduck.

We will download the translated protein sequences to save space and time. Since these sequences do not need to be assembled by Trinity, they will be added to the assembled transcriptomes from Section 2.3 and on. We will also download curated sequence data from Refseq, rather than non-curated data from Genbank, since the data will be less redundant.

> **NOTE:**
To download genomes: Go to the <a href = https://www.ncbi.nlm.nih.gov/genbank/>NCBI website</a>, select "Genome" in the drop down menu, and type enter the name of the species of interest. On the species genome page, scroll down and click the "Download" button. Under "Select file source", choose "Refseq only". Under "Select file types", choose "Genome coding sequences (FASTA)" and "Protein (FASTA)". Then click "Download" and extract the zip file. Open the FASTA files in Atom and re-save file with taxon name and respective ".cds" or ".aa" extension (e.g., Hya_azt_genome.aa). Then upload the respective FASTA files to the server under the "/bwdata3/bcummings/00-DATA/GENOME" folder.

#### 2.1.2 *Outgroup Transcriptomes*

We will acquire most outgroup transcriptomes from publicly available data in the SRA database (<https://www.ncbi.nlm.nih.gov/sra>) and some from collaborating sequencing efforts (K. Kocot, unpublished data).

We will use representatives from non-corophioid amphipod families and orders of other peracarid and crustacean arthropods for outgroups. Outgroup selection will be based on transcriptome availability from recent phylogenetic studies of Amphipoda and Arthropoda (2018 - present). Transcriptome choice will be based on (1) phylogenetic position to achieve wide breadth of phylogenetic diversity, (2) completeness of transcriptome (i.e., BUSCO score), and (3) matrix occupancy (i.e., percentage of orthologous genes/characters of the outgroup taxon shared with all other taxa in the analysis).

---

### 2.2 Transcriptome assembly and assessment

We will perform *de novo* transcriptome assembly with Trinity v2.15.0 (Grabherr et al. 2011). As opposed to reference assembly, *de novo* assembly attempts to join reads together like a jigsaw puzzle without a reference.

First, we will use FASTQC to get an idea of our data quality before trimming and assembling.

```bash
# on mildred
#symlink to raw sequences for input to FastQC
mkdir -p /bwdata3/bcummings/COROPHIOID/00-DATA/00-FASTQC_BEFORETRIMMING

find /bwdata3/bcummings/COROPHIOID/00-DATA/Brittany \
  -type f -name "*.fastq.gz" \
  -exec ln -s {} /bwdata3/bcummings/COROPHIOID/00-DATA/00-FASTQC_BEFORETRIMMING/ \;

find /bwdata3/bcummings/COROPHIOID/00-DATA/Siena \
  -type f -name "*.fastq.gz" \
  -exec ln -s {} /bwdata3/bcummings/COROPHIOID/00-DATA/00-FASTQC_BEFORETRIMMING/ \;

find /bwdata3/bcummings/COROPHIOID/00-DATA/NCBI \
  -type f -name "*.fastq.gz" \
  -exec ln -s {} /bwdata3/bcummings/COROPHIOID/00-DATA/00-FASTQC_BEFORETRIMMING/ \;


cd /bwdata3/bcummings/COROPHIOID/00-DATA/00-FASTQC_BEFORETRIMMING

fastqc *.fastq.gz

#remove .fastq.gz to save space
rm *.fastq.gz


```

Download the .zip files and unzip to view the results. Open the html files and scroll to the bottom of the page to see the adapter content. The FastQC results will also serve as our baseline for before assembly (sequence lengths, etc.).

```bash
logout

wsl

scp bcummings@10.251.34.217:/bwdata3/bcummings/COROPHIOID/00-DATA/00-FASTQC_BEFORETRIMMING/*.zip /mnt/e/DISSERTATION_DATA/chapter2_data_analysis/Data_NextGenSeq/Transcriptomes/FastQC/01-FASTQC_BEFORETRIMMING/

scp bcummings@10.251.34.217:/bwdata3/bcummings/COROPHIOID/00-DATA/00-FASTQC_BEFORETRIMMING/*.html /mnt/e/DISSERTATION_DATA/chapter2_data_analysis/Data_NextGenSeq/Transcriptomes/FastQC/01-FASTQC_BEFORETRIMMING/
```

#### 2.2.1 *Trimming and re-assembly*

We will use Trimmomatic to trim out adapter sequences and low quality trailing bases from PE Illumina reads. We will run the program with default parameters and change the adapters as needed for each file.

>**NOTE:** You can run Trimmomatic as part of Trinity, if desired. I actually did this for the transcriptome tree, but I trimmed the sequences separately for input into the aTRAM pipeline during the target capture UCE harvesting step later.

First, make a shell script ```00-script_trim.sh``` with each file that you want to trim. For example:

```shell
#!/bin/bash

java -jar /usr/local/Trimmomatic-0.39/trimmomatic-0.39.jar PE \
  -threads 50 \
  -phred33 \
  /bwdata3/bcummings/COROPHIOID/00-DATA/Brittany/Aoroides_spp-BPER0026/Aoroides_spp_1.fastq.gz \
  /bwdata3/bcummings/COROPHIOID/00-DATA/Brittany/Aoroides_spp-BPER0026/Aoroides_spp_2.fastq.gz \
  Aoroides_spp-READ1.fastq.gz \
  Aoroides_spp.unp1.fq \
  Aoroides_spp-READ2.fastq.gz \
  Aoroides_spp.unp2.fq \
  ILLUMINACLIP:/usr/local/Trimmomatic-0.39/adapters/NexteraPE-PE.fa:2:30:10 \
  LEADING:5 \
  TRAILING:5 \
  SLIDINGWINDOW:4:5 \
  MINLEN:25 \
  > Aoroides_spp.trimmo.out 2> Aoroides_spp.trimmo.err

java -jar /usr/local/Trimmomatic-0.39/trimmomatic-0.39.jar PE \
  -threads 50 \
  -phred33 \
  /bwdata3/bcummings/COROPHIOID/00-DATA/Brittany/Caprella_irregularis-BCPD0040/Caprella_irregularis_1.fastq.gz \
  /bwdata3/bcummings/COROPHIOID/00-DATA/Brittany/Caprella_irregularis-BCPD0040/Caprella_irregularis_2.fastq.gz \
  Caprella_irregularis-READ1.fastq.gz \
  Caprella_irregularis.unp1.fq \
  Caprella_irregularis-READ2.fastq.gz \
  Caprella_irregularis.unp2.fq \
  ILLUMINACLIP:/usr/local/Trimmomatic-0.39/adapters/NexteraPE-PE.fa:2:30:10 \
  LEADING:5 \
  TRAILING:5 \
  SLIDINGWINDOW:4:5 \
  MINLEN:25 \
  > Caprella_irregularis.trimmo.out 2> Caprella_irregularis.trimmo.err

java -jar /usr/local/Trimmomatic-0.39/trimmomatic-0.39.jar PE \
  -threads 50 \
  -phred33 \
  /bwdata3/bcummings/COROPHIOID/00-DATA/Brittany/Caprella_laeviscula-BCPD0048/Caprella_laeviscula_1.fastq.gz \
  /bwdata3/bcummings/COROPHIOID/00-DATA/Brittany/Caprella_laeviscula-BCPD0048/Caprella_laeviscula_2.fastq.gz \
  Caprella_laeviscula-READ1.fastq.gz \
  Caprella_laeviscula.unp1.fq \
  Caprella_laeviscula-READ2.fastq.gz \
  Caprella_laeviscula.unp2.fq \
  ILLUMINACLIP:/usr/local/Trimmomatic-0.39/adapters/TruSeq3-PE.fa:2:30:10 \
  LEADING:5 \
  TRAILING:5 \
  SLIDINGWINDOW:4:5 \
  MINLEN:25 \
  > Caprella_laeviscula.trimmo.out 2> Caprella_laeviscula.trimmo.err
#...
```

Then run the script.

```bash

mkdir -p /bwdata3/bcummings/COROPHIOID/00-TRIMMING

cd /bwdata3/bcummings/COROPHIOID/00-TRIMMING

chmod +x 00-script_trim.sh

bash ./00-script_trim.sh

```

> **NOTE:**
In our initial transcriptome tree pipeline, we mistakenly ran Trimmomatic within Trinity using the same TruSeq3-PE adapter settings for all samples. As a result, ~8–10 samples with Nextera adapters were not properly trimmed. However, extensive downstream filtering likely removed most contaminated sequences, minimizing the impact on the guide tree used for bait design. We checked this by rebuilding the tree with data from properly trimmed assemblies and making sure the topology was consistent (ARBOR_redo). This trimming is shown in Section 2.2.1 below. For the final species trees, we made sure to use the properly trimmed sequences.

Use FastQC to check and make sure adapters have been removed.

```bash
# on mildred
cd /bwdata3/bcummings/COROPHIOID/00-TRIMMING

fastqc /bwdata3/bcummings/COROPHIOID/00-TRIMMING/*fastq.gz


#move fastqc output files to a new folder
mkdir -p /bwdata3/bcummings/COROPHIOID/00-TRIMMING/00-FASTQC_AFTERTRIMMING

cd /bwdata3/bcummings/COROPHIOID/00-TRIMMING/00-FASTQC_AFTERTRIMMING

mv /bwdata3/bcummings/COROPHIOID/00-TRIMMING/*.zip .

mv /bwdata3/bcummings/COROPHIOID/00-TRIMMING/*.html .



```

Download the .zip files and unzip to view the results. Open the html files and scroll to the bottom of the page to see the adapter content and make sure adapters have been removed.

```bash
logout

wsl

scp bcummings@10.251.34.217:/bwdata3/bcummings/COROPHIOID/00-TRIMMING/00-FASTQC_AFTERTRIMMING/*.zip /mnt/e/DISSERTATION_DATA/chapter2_data_analysis/Data_NextGenSeq/Transcriptomes/FastQC/02-FASTQC_AFTERTRIMMING/

scp bcummings@10.251.34.217:/bwdata3/bcummings/COROPHIOID/00-TRIMMING/00-FASTQC_AFTERTRIMMING/*.html /mnt/e/DISSERTATION_DATA/chapter2_data_analysis/Data_NextGenSeq/Transcriptomes/FastQC/02-FASTQC_AFTERTRIMMING/

```

>**NOTE:** I had to re-trim Dulichia_rhabdoplastis with a combined adapter file containing both Illumina and Nextera adapters sequences since trimming with just one or the other did not get rid of all adapters. I found out after the fact that Leptochelia_spp (NCBI sequence) also needed to be trimmed with a combined adapter file, but was too late and used the less well-trimmed sequences for assembly for this one.

Now we can run Trinity to assemble our freshly trimmed data.

```bash
/usr/local/trinityrnaseq-v2.15.0/Trinity --seqType fq --max_memory 200G --CPU 45  --left /bwdata3/bcummings/COROPHIOID/00-TRIMMING/Byblis_spp-READ1.fastq.gz --right /bwdata3/bcummings/COROPHIOID/00-TRIMMING/Byblis_spp-READ2.fastq.gz --full_cleanup > trin.out 2> trin.err &

# etc.
```

If you skipped Trimmomatic above and need to run trimming within Trinity, instead run the following

```bash
/usr/local/trinityrnaseq-v2.15.0/Trinity --seqType fq --max_memory 200G --CPU 45 --trimmomatic --quality_trimming_params "ILLUMINACLIP:NexteraPE-PE.fa:2:30:10 SLIDINGWINDOW:4:5 LEADING:5 TRAILING:5 MINLEN:25" --left /bwdata3/bcummings/COROPHIOID/00-DATA/Brittany/Aoroides_spp-BPER0026/Aoroides_spp_1.fastq.gz --right /bwdata3/bcummings/COROPHIOID/00-DATA/Brittany/Aoroides_spp-BPER0026/Aoroides_spp_2.fastq.gz --full_cleanup > trin.out 2> trin.err &

# etc.
```

---

### 2.3 BUSCO Assessment: Part 1

We will use BUSCO on the website [gVolante](https://gvolante.riken.jp/) to assess completeness of transcriptome assemblies.

> **NOTE:**
BUSCO is a tool to assess completeness of genome assembly, gene set and transcriptome. It is based on the concept of single-copy orthologs that should be highly conserved among the closely related species. For example, users who wish to study the completeness of a mammalian genome assembly will use single-copy orthologs discovered among mammalian species. We will use BUSCO on (1) the original transcriptome assembly and (2) the transcriptome assembly after isoform removal (see Section 2.4). This will provide an additional check of the effectiveness of our isoform removal method.

For each transcriptome assembly, use the following parameters:

**Sequence type:** coding/transcribed (nucleotide)
**Choose an analysis program:** BUSCO v5
**Ortholog set for BUSCO v5:** Eukaryota

Or if running on commandline:

```bash
micromamba activate /bwdata3/bcummings/00-MICROMAMBA/busco

cd /bwdata3/bcummings/COROPHIOID/01-TRINITY/Kevin/Byblis_spp

busco -i Byblis_spp.Trinity.fasta -o Byblis_spp_EUK -l eukaryota_odb10 -m transcriptome -c 8
```

For now, keep transcriptomes with low quality BUSCO scores and proceed with isoform (Section 2.4) and contamination removal (Section 2.5). Revisit BUSCO scores following these steps to see if there is any improvement (Section 2.6).

---

### 2.4 Isoform clustering

We will remove isoforms and translate coding sequences in each transcriptome assembly using [Evigene](http://arthropods.eugenes.org/EvidentialGene/about/EvidentialGene_trassembly_pipe.html).

> **NOTE:**
SuperTranscripts is also an isoform tool which is now outdated. The program should not be used, but information on SuperTranscripts is included in this section for reference.

Gene isoforms code for proteins that are functionally similar but have a slightly different amino acid sequence (and, thus, nucleotide coding-sequence). More specifically, isoforms are mRNA transcripts that are produced from the same locus but are slightly different in their transcription start sites (TSSs), protein coding DNA sequences (CDSs) and/or untranslated regions (UTRs), potentially altering gene function. We are ultimately trying to find orthologs in our transcriptome assembly to construct our phylogeny, meaning genes that have a similar function and same evolutionary origin. The problem is that, when we run Orthofinder (see below), it will see isoform transcripts as from separate genes since the sequences are different, even though they are actually from the same gene. This means results will yield more ortholog genes than are actually present. Thus, we need to a way to account for isoforms in our transcriptome data before running Orthofinder. We do this by clustering isoforms.

Clustering a sequence database requires all-by-all comparisons; therefore it is very time-consuming. Many methods use BLAST to compute the all vs. all similarities, but it is very difficult for these methods to cluster large databases. The following methods take care of this problem.

BLAST is the preferred method for clustering isoforms, but is computationally difficult to use because of the large size of the assembled transcript sequence file. Evigene solves this problem by reducing the number of sequences before clustering. Evigene first removes transcript redundancy and then clusters remaining transcripts by similarity. First, perfectly identical coding-sequences are filtered out using the ```fastanrdb``` command of the ```exonerate``` package. Then, coding-sequences which are perfect fragments of other sequences are clustered using CD-HIT command ```cd-hit-est```. Finally, the remaining sequences are aligned using ```blastn``` to identify sequences with >98% similarity for clustering. The sequences are then spat out into "good" and "bad" piles after clustering so you can review the results.

The program also produces an amino acid file which allows you to skip Transdecoder translation.

#### 2.4.1 *Regularize transcript IDs*

Run the ```trformat.pl``` perl script on each transcript assembly file to regularize transcript IDs and allows tracking inputs through the Evigene pipeline.

```bash
[path_to_evigene_program_dir]/scripts/rnaseq/trformat.pl -pre "BC" -out [TRANSCRIPT_ASSEMBLY].tr -log -in [path_to_trinity_output]/[TRANSCRIPT_ASSEMBLY].Trinity.fasta
```

```bash
pigz -9 [TRANSCRIPT_ASSEMBLY].tr &
```

#### 2.4.2 *Make output folder & customize Evigene run script*

Make a folder for the Evigene output and copy the Evigene run script into this folder.

```bash
mkdir -p [path_to_working_evigene_folder]/[transcript_assembly_EVIGENE]/
```

```bash
cp [path_to_script]/run_tr2aacds.sh [path_to_working_evigene_folder]/[transcript_assembly_EVIGENE]
```

Edit all paths in ```run_tr2aacds.sh``` shell script to point to respective Evigene directories. For each assembly, edit line 2 with respective input [TRANSCRIPT_ASSEMBLY].tr.gz file name.

#### 2.4.3 *Run Evigene*

Run ```run_tr2aacds``` script from within working folder to start Evigene program.

```bash
chmod u+x run_tr2aacds.sh   #gain permission to run script
```

```bash
env trset=[TRANSCRIPT_ASSEMBLY].gz datad=`pwd` ./run_tr2aacds.sh >& log.tr2ac1 &
```

> **NOTE:**
After running ```tr2aacds.sh```, the output will be in the "okayset" folder. The "okay" files contain the transcript sequences ([TRANSCRIPT_FILE].okay.tr) and corresponding amino acid sequences ([TRANSCRIPT_FILE].okay.aa) that give the longest protein of each gene locus. The "okalt" files are the shorter "okay" alternatives to these sequences.

Even though most isoforms have been removed, Evigene will still retain duplicates in the "okay" file. Some of these duplicates are <a href = https://sourceforge.net/p/evidentialgene/blog/2017/10/why-more-proteins-than-transcripts-ie-utr-orfs/>UTRORFs</a>. Trinity sometimes joins 2 or more genes in one transcript, so Evigene looks for these instances by searching for more than one protein (ORF) in transcripts that have long untranslated regions (UTRs) left over from longest ORF. So you end up with these extra "UTRORF" sequences. Other duplicates are just "trash" proteins that are the result of Evigene not blasting sequences against the NCBI database (recall, Evigene blasts sequences against each other, not a database). Still other duplicates might exist [theoretically] because Evigene recognizes a group of 3 or more isoforms which all match each other in some way, but does not see the same matching when comparing only 2 of these isoforms, and thus leaves them as separate sequences. If you want to manually check this, use the code below:

```bash
# count total number of sequences
grep -c '^>' [FILE_NAME].okay.aa

# count all deflines that are not t1
grep '^>' [FILE_NAME].okay.aa | perl -ne 'print unless (m/^>\S+t1 /);' | wc -l

#These two results will likely not match since Evigene will retain duplicate (non "t1") transcripts
```

#### 2.4.4 *Remove duplicate sequences & rename files*

Remove remaining isoforms before proceeding with downstream analyses.

Even though most isoforms have been removed, Evigene will still retain duplicates. If two or more transcripts are duplicate isoforms, we are only interested in keeping the longest isoform for phylogenetic studies. To do this, use the ```get_longest_from_evigene.pl``` perl script on both amino acid and coding sequence files. This script will also modify defline names to streamline downstream analyses.

> **NOTE:**
We are only interested in keeping the longest isoform because (1) all the gene duplication events identified will be true duplicates rather than different transcript variants, (2) orthologs will be calculated at the gene level, which is the correct approach (i.e., you will correctly identify single copy orthologs), and (3) it saves a lot of computation time if you only analyze the longest transcripts.

```bash
perl [path_to_script]/get_longest_from_evigene.pl [path_to_working_evigene_folder]/okayset/[TRANSCRIPT_ASSEMBLY].okay.aa [FIRST_3_LETTERS_OF_GENUS]_[FIRST_3_LETTERS_OF_SPECIES] > [FIRST_3_LETTERS_OF_GENUS]_[FIRST_3_LETTERS_OF_SPECIES].aa
```

```bash
perl [path_to_script]/get_longest_from_evigene.pl [path_to_working_evigene_folder]/okayset/[TRANSCRIPT_ASSEMBLY].okay.cds [FIRST_3_LETTERS_OF_GENUS]_[FIRST_3_LETTERS_OF_SPECIES] > [FIRST_3_LETTERS_OF_GENUS]_[FIRST_3_LETTERS_OF_SPECIES].cds
```

Even though genomes will not be run through Evigene, rename the genome files and deflines to match transcriptome files.

```bash
#rename genome files
mv [AA_file].faa Gen_spe.aa
mv [CDS_file].fna Gen_spe.cds
```

```bash
#rename genome file deflines
perl -pi.orig -e 's/^>(\S+).*/>Gen_spe|$1/' Gen_spe.aa
perl -pi.orig -e 's/^>(\S+).*/>Gen_spe|$1/' Gen_spe.cds

```

#### 2.4.5 *Copy assemblies to new folder*
Copy post-Evigene assemblies to a new folder for easy access during Alien Index (Section 2.5) and PAL2NAL (Section 2.8).

```bash
#AA files
mkdir -p [path_to_working_evigene_folder]/ai_input

find [path_to_working_evigene_folder] -iname '*.aa' -exec cp {} [path_to_working_evigene_folder]/ai_input \;

find [path_to_working_evigene_folder]/ai_input -type f -regextype posix-egrep -regex ".*/[^/]{11}[^/]+$" -exec rm -vf {} \;
```

```bash
#CDS files
mkdir -p [path_to_working_evigene_folder]/pal2nal_input

find [path_to_working_evigene_folder] -iname '*.cds' -exec cp {} [path_to_working_evigene_folder]/pal2nal_input \;

find [path_to_working_evigene_folder]/pal2nal_input -type f -regextype posix-egrep -regex ".*/[^/]{11}[^/]+$" -exec rm -vf {} \;
```

---

### 2.5 Remove contaminating sequences using Alien Index

We will use the program [Alien Index](https://github.com/josephryan/alien_index) to remove contaminating, non-metazoan sequences.

#### 2.5.1 *Create BLAST database*

Create a database of metazoan and non-metazoan sequences for BLAST using the non_meta.fa.gz and meta.fa.gz files found <a href="http://ryanlab.whitney.ufl.edu/downloads/alien_index/">here</a>.

Make Alien Index database directory and upload non_meta.fa.gz and meta.fa.gz files to this folder.

```bash
mkdir -p /bwdata3/bcummings/03-ALIEN_INDEX/database
cd /bwdata3/bcummings/03-ALIEN_INDEX/database
```

Unzip metazoan and non-metazoan sequence files.

```bash
pigz -dk meta.fa.gz
pigz -dk non_meta.fa.gz
```

Add unique code to defline of all non-metazoan sequences.

```bash
perl -pi -e 's/^>/>ALIEN_/' non_meta.fa
```

Make sure this unique code is not found in metazoan fasta.

```bash
grep '^>' meta.fa | grep ALIEN_
```

Concatenate metazoan and non-metazoan sequences.

```bash
cat non_meta.fa meta.fa > ai.fa
```

Transform database into index files to speed up the search process.

```bash
diamond makedb --db prot --in ai.fa
```

#### 2.5.2 *BLAST transcriptome amino acid file*

For each transcriptome amino acid file, make an Alien Index folder and BLAST against the combined database.

```bash
mkdir -p [path_to_working_alien_index_folder]/[Gen_spp]
cd [path_to_working_alien_index_folder]/[Gen_spp]
```

```bash
diamond blastp --query [path_to_working_evigene_folder]/ai_input/[Gen_spp].aa --db [path_to_working_alien_index_folder]/prot.dmnd --outfmt 6 --max-target-seqs 1000 --seq yes --evalue 0.001 --threads 6 --out ai_diamond.out > diamond.stdout 2> diamond.err &
```

#### 2.5.3 *Run Alien Index on BLAST output*

```bash
alien_index --BLAST=ai_diamond.out --alien_pattern=ALIEN_ > ai.out 2> ai.err
```

#### 2.5.4 *Remove contaminating sequences from original input file*

Use the ```remove_aliens.pl``` script to remove contaminating sequences from the original amino acid file.

```bash
[path_to_script]/remove_aliens.pl ai.out [path_to_working_evigene_folder]/ai_input/[Gen_spp].aa > [path_to_working_alien_index_folder]/[Gen_spp]/[Gen_spp]_no_aliens.aa 2> ai2.err
```

#### 2.5.5 *Copy decontaminated output to new folder*

Copy post-Alien Index assemblies to a new folder for easy access during OrthoFinder (Section 2.7).

```bash
mkdir -p [path_to_working_alien_index_folder]/orthofinder_input
```

```bash
find [path_to_working_alien_index_folder] -iname '*.aa' -exec cp {} [path_to_working_alien_index_folder]/orthofinder_input \;
```

```bash
rename .aa .faa *.aa   #rename file extensions to .aa
```

---

### 2.6 BUSCO Assessment: Part 2

Use BUSCO on the website gVolante (<https://gvolante.riken.jp/>) to assess completeness of cleaned transcriptome assemblies.

For each transcriptome assembly, use the following parameters:

**Sequence type:** coding/transcribed (nucleotide)
**Choose an analysis program:** BUSCO v5
**Ortholog set for BUSCO v5:** Eukaryota

Or if running on commandline:

```bash
micromamba activate /bwdata3/bcummings/00-MICROMAMBA/busco

cd /bwdata3/bcummings/COROPHIOID/03-ALIEN_INDEX/Byb_spp

busco -i /bwdata3/bcummings/COROPHIOID/03-ALIEN_INDEX/orthofinder_input/Byb_spp_no_aliens.faa -o Byb_spp_EUK -l eukaryota_odb10 -m protein -c 8
```

Given the limited number of published amphipod genomes, transcriptomes with a BUSCO score below 25\% were excluded to retain as many corophioid ingroups as possible.

---

### 2.7 Identify orthogroups using OrthoFinder

We will identify orthogroups across corophioid transcriptomes with OrthoFinder v2.1.2 (Emms & Kelly 2015).

#### 2.7.1 *Link OrthoFinder output folder to input files*

```bash
mkdir -p [path_to_working_orthofinder_folder]/01-AA
```

```bash
ln -s [path_to_working_alien_index_folder]/orthofinder_input/*.faa [path_to_working_orthofinder_folder]/01-AA
```

#### 2.7.2 *Run OrthoFinder*

```bash
conda activate [path_to_conda_orthofinder_environment]
```

```bash
cd [path_to_working_orthofinder_folder]
```

```bash
orthofinder -X -S diamond -z -t 160 -f 01-AA -M msa | tee of.out 2> of.err
```

---

### 2.8 Prune orthogroups using PhyloPyPruner

To ensure that orthogroups contain only 1:1 orthologs, we will use <a href="https://pypi.org/project/phylopypruner/">PhyloPyPruner</a> to trim paralogs from orthogroups.

#### 2.8.1 *Retrieve orthogroups*

Copy orthogroups to a new folder.

```bash
mkdir -p [path_to_orthofinder_results_folder]/phylopypruner_input

perl [path_to_orthofinder_results_folder]/MultipleSequenceAlignments [path_to_orthofinder_results_folder]/Gene_Trees[path_to_orthofinder_results_folder]/phylopypruner_input &
```

#### 2.8.2 *Rename & filter alignment and tree files*

Change file extension for tree files.

```bash
for file in [path_to_orthofinder_results_folder]/phylopypruner_input/*_tree.txt; do mv "$file" "${file/_tree.txt/.tree}"; done

```

Filter orthogroups to only those containing a minimum of 50% taxa, and exclude fasta files with a number of sequences >10X the number of taxa. If we don't run this script, PhyloPyPruner may clog up. Before running the script, edit the file to match the number of taxa you have.

```bash
cd [path_to_orthofinder_results_folder]/phylopypruner_input
```

```bash
perl [path_to_script]/filter_taxa_kevin.pl
```

Move rejected tree files to a new folder.

```bash
mkdir trees_rejected
```

```bash
for tree_file in *.tree; do fa_file="${tree_file%.tree}.fa"; [ ! -e "$fa_file" ] && mv -- "$tree_file" trees_rejected/; done
```

Copy PhyloPyPruner input to a new directory.

```bash
mkdir -p [path_to_phylopypruner_folder]/input
find [path_to_orthofinder_results_folder]/phylopypruner_input -maxdepth 1 -type f | xargs cp -t [path_to_phylopypruner_folder]/input
```

#### 2.8.3 *Run PhyloPyPruner*

Run PhyloPyPruner with settings to eliminate output alignments that have fewer than 75% of the taxa (i.e., set matrix occupancy to 75%). Use a relaxed threshold, removing OTUs with a paralogy frequency greater than five times the standard deviation of the paralog frequency for all OTUs.

```bash
phylopypruner --threads 50 --dir . --min-len 100 --min-taxa 37 --min-support 0.75 --mask pdist --trim-lb 5 --trim-divergent 0.75 --min-pdist 2e-8 --prune LS
```

#### 2.8.4 *Examine occupancy matrix*

Visually examine occupancy matrix to determine if there are any taxa (OTUs) which are heavily excluded from most orthogroups. If such taxa are identified, re-run PhyloPyPruner without these taxa using the "--exclude <OTU>" parameter.

#### 2.8.5 *Move phylopypruner output to separate folder*

```bash
mv [path_to_phylopypruner_folder]/input/phylopypruner_output [path_to_phylopypruner_folder]
```

---

### 2.9 Align coding sequences using PAL2NAL

We will run PAL2NAL (Suyama et al. 2006) to align coding sequences based on their corresponding amino acid alignment.

> **NOTE:**
The PAL2NAL program aligns coding sequences based on their corresponding amino acid alignment. Other alignment programs, such as MAFFT, start by aligning coding sequences and translating aligned sequences to amino acids which can then be used to infer trees. But in our case, we want to reverse translate already-aligned amino acids to coding sequences so that we have the corresponding coding sequence alignment. The PAL2NAL server requires a multiple sequence alignment of proteins and the corresponding DNA sequences as input. The internal action of the program can be divided into three main steps: (i) upload the protein sequence alignment and DNA sequences, (ii) reverse translation, and (iii) generation of the codon alignment. In the second step, each protein sequence is converted into DNA sequence of a regular expression pattern. The input DNA sequence is searched with the pattern to obtain the corresponding coding region, and unmatched DNA sequence regions are discarded. In the third step, the protein sequence alignment is converted into the corresponding codon alignment by replacing each amino acid residue with the corresponding codon sequence.

#### 2.9.1 *Clean PhyloPyPruner amino acid alignments*

Phylopypruner alignments sometimes have no residues and fewer than the specified minimum number of taxa. We will use the ```remove_blank_seqs_and_fewer_than_n``` perl script to remove these alignments, just in case.

```bash
perl [path_to_script]/remove_blank_seqs_and_fewer_than_n.pl --out_dir=[path_to_working_pal2nal_folder]/01-SEQS --min_seq=37  --aln_dir=[path_to_phylopypruner_output_folder]/output_alignments
```

Remove "_pruned" at the end of .aa file names in 01-SEQS folder.

```bash
find . -type f -name "*pruned_1*" |  sed 's/\(.*\)pruned_1\(.*\)/mv \0 \1pruned\2/' | sh
find . -type f -name "*pruned_2*" |  sed 's/\(.*\)pruned_2\(.*\)/mv \0 \1pruned\2/' | sh
```

#### 2.9.2 *Retrieve corresponding CDS files*

Retrieve all .cds files corresponding to pruned .aa files

```bash
perl [path_to_script]/get_corresponding_cds.pl --cds_dir=[path_to_working_evigene_folder]/pal2nal_input --aa_dir=01-SEQS --out_dir=02-CDS
```

Rename .cds files to match .aa files in 02-CDS folder.

```bash
find . -type f -name "*.cds*" |  sed 's/\(.*\).cds\(.*\)/mv \0 \1\2/' | sh
```

#### 2.9.3 *Run PAL2NAL to get coding sequence alignments*

```bash
mkdir -p [path_to_working_pal2nal_folder]/03-P2N
```

```bash
chmod +x [path_to_script]/run_pal2nal.pl
chmod +x [path_to_script]/pal2nal.pl
```

```bash
perl [path_to_script]/run_pal2nal.pl [path_to_working_pal2nal_folder]/01-SEQS [path_to_working_pal2nal_folder]/03-P2N
```

---

### 2.10 Build preliminary gene & species trees

We will use all nucleotide orthogroups in IQ-TREE (Nguyen et al 2014) to build species and gene trees to be used in subsequent subsetting and filtering steps (Section 2.11 - 2.13). We will also build a species tree using amino acid data to check for topological consistency between nucleotide and amino acid trees (Section 2.10.5).

#### 2.10.1 *Format orthogroups*

Use ```remove_pipe_text.pl``` script to rename file deflines and remove text after pipe in these files. This allows for concatenation of sequences based on species name in Section 2.10.3. Repeat for both nucleotide and amino acid alignments.

##### *Nucleotide data*

```bash
mkdir -p /bwdata3/bcummings/COROPHIOID/07-SPECIESTREE/mintaxa75%/NUC_bestgenetreemodels/input_IQTREE
```

```bash
cd /bwdata3/bcummings/COROPHIOID/07-SPECIESTREE/mintaxa75%/NUC_bestgenetreemodels/input_IQTREE

perl /bwdata3/bcummings/SCRIPTS/remove_pipe_text.pl "/bwdata3/bcummings/COROPHIOID/06-PAL2NAL/mintaxa75%/03-P2N/*.fa"
```

##### *Amino acid data*

```bash
mkdir -p /bwdata3/bcummings/COROPHIOID/07-SPECIESTREE/mintaxa75%/AA_bestgenetreemodels/input_IQTREE
```

```bash
cd /bwdata3/bcummings/COROPHIOID/07-SPECIESTREE/mintaxa75%/AA_bestgenetreemodels/input_IQTREE

perl /bwdata3/bcummings/SCRIPTS/remove_pipe_text.pl "/bwdata3/bcummings/COROPHIOID/06-PAL2NAL/mintaxa75%/01-SEQS/*.fa"
```

NOTE:
We can also use PHYLUCE to summarize the orthogroups. This is just for summary statistics to include with publications.

First, explode orthogroups by taxon. We will do this for both pre and post PhyloPyPruner orthogroups.

```bash
micromamba activate /bwdata3/auehling/00-MICROMAMBA/phyluce-1.7.3

cd /bwdata3/bcummings/COROPHIOID/07-SPECIESTREE/NUC_bestgenetreemodels

phyluce_align_explode_alignments \
  --alignments input_IQTREE/ \
  --output individual_fastas_by_taxon/ \
  --by-taxon


cd /bwdata3/bcummings/COROPHIOID/05-PHYLOPYPRUNER/mintaxa75%

mkdir input_clean_for_summary

for f in input/*.fa; do
  sed 's/^\(>[^|]*\).*/\1/' "$f" \
    > input_clean_for_summary/$(basename "$f")
done

phyluce_align_explode_alignments \
  --alignments input_clean_for_summary/ \
  --output individual_fastas_by_taxon/ \
  --by-taxon

```

Then get per-taxon sequence length stats.

```bash
cd /bwdata3/bcummings/COROPHIOID/07-SPECIESTREE/NUC_bestgenetreemodels

for i in individual_fastas_by_taxon/*.fasta; do
    phyluce_assembly_get_fasta_lengths --input "$i" --csv
done > fasta_lengths_orthogroups_min75%.csv &50%


cd /bwdata3/bcummings/COROPHIOID/05-PHYLOPYPRUNER/mintaxa75%

for i in individual_fastas_by_taxon/*.fasta; do
    phyluce_assembly_get_fasta_lengths --input "$i" --csv
done > fasta_lengths_orthogroups.csv &

```

#### 2.10.2 *Build gene trees with nucleotide data*

For nucleotide data, run IQ-TREE with orthogroups using ```-m MFP``` to build gene trees using the best-fit substitution models for each orthogroup. Then concatenate these gene trees into a newick file. We only need these gene trees for GeneSortR, so we do not need to do this step with amino acid data. Instead, for amino acid data, we will just be using ModelFinder within the species tree construction to find the best model for each orthogroup.

```bash
mkdir -p [path_to_prelim_tree_folder]/GENE_TREE/output_IQTREE
```

```bash
cd [path_to_prelim_tree_folder]/GENE_TREE/output_IQTREE
for i in [path_to_prelim_tree_folder]/GENE_TREE/input_IQTREE/OG*.fa; do iqtree -s "$i" -m MFP -st DNA -bb 1000 -nt AUTO -pre ${i%.fa}_NUC_GENETREE_min75; done
```

```bash
cat *.contree > concatenated_NUC_GENETREES_min75.nwk
```

#### 2.10.3 *Concatenate orthogroups & generate gene partitions*

For nucleotide and amino acid data, use slightly modified version of the ```fasta2phylomatrix.pl``` script (available as a script within the JFR Perl Modules distribution (as of v1.1):  https://github.com/josephryan/JFR-PerlModules) to concatenate sequences across species and generate a partition file which specifies the starting and ending positions of each gene within the sequence matrix. Then use custom script ```partition_to_nexus.pl``` to convert partition file to .nex format.

##### *Nucleotide data*

```bash
mkdir -p /bwdata3/bcummings/COROPHIOID/07-SPECIESTREE/mintaxa75%/NUC_bestgenetreemodels/output_IQTREE
```

```bash
perl /bwdata3/bcummings/SCRIPTS/fasta2phylomatrix_edit.pl --dir=/bwdata3/bcummings/COROPHIOID/07-SPECIESTREE/mintaxa75%/NUC_bestgenetreemodels/input_IQTREE --partition=partitions_NUC_min75.txt > concatenated_NUC_min75.fa
```

```bash
cd /bwdata3/bcummings/COROPHIOID/07-SPECIESTREE/mintaxa75%/NUC_bestgenetreemodels/output_IQTREE
perl /bwdata3/bcummings/SCRIPTS/partition_to_nexus.pl --input=partitions_NUC_min75.txt --output=partitions_NUC_min75.nex

```

##### *Amino acid data*

```bash
mkdir -p /bwdata3/bcummings/COROPHIOID/07-SPECIESTREE/mintaxa75%/AA_bestgenetreemodels/output_IQTREE
```

```bash
cd /bwdata3/bcummings/COROPHIOID/07-SPECIESTREE/mintaxa75%/AA_bestgenetreemodels/output_IQTREE

perl /bwdata3/bcummings/SCRIPTS/fasta2phylomatrix_edit.pl --dir=/bwdata3/bcummings/COROPHIOID/07-SPECIESTREE/mintaxa75%/AA_bestgenetreemodels/input_IQTREE --partition=partitions_AA_min75.txt > concatenated_AA_min75.fa
```

```bash
cd /bwdata3/bcummings/COROPHIOID/07-SPECIESTREE/mintaxa75%/AA_bestgenetreemodels/output_IQTREE
perl /bwdata3/bcummings/SCRIPTS/partition_to_nexus.pl --input=partitions_AA_min75.txt --output=partitions_AA_min75.nex
```

#### 2.10.4 *Build species trees*

##### *Nucleotide data*

For nucleotide data, run IQ-TREE with respective concatenated data and partition file using best substitution models for each orthogroup from Section 2.10.2.

First, use the custom script ```retrieve_models.pl``` add the "best models" from Section 2.10.2 to the partition file.

```bash
perl /bwdata3/bcummings/SCRIPTS/retrieve_models.pl --input /bwdata3/bcummings/COROPHIOID/07-SPECIESTREE/mintaxa75%/NUC_bestgenetreemodels/output_IQTREE/partitions_NUC_min75.nex --output /bwdata3/bcummings/COROPHIOID/07-SPECIESTREE/mintaxa75%/NUC_bestgenetreemodels/output_IQTREE/partitions_NUC_bestgenetreemodels_min75.nex --logs /bwdata3/bcummings/COROPHIOID/07-SPECIESTREE/mintaxa75%/GENE_TREE/output_IQTREE

```

Run IQ-TREE using the resulting partition file.

```bash
iqtree -s concatenated_NUC_min75.fa -spp partitions_NUC_bestgenetreemodels_min75.nex -st DNA -bb 1000 -nt AUTO -pre NUC_bestgenetreemodels_min75
```

For bookkeeping, use the following script to determine the total number of basepairs used in your concatenated dataset, and the percent missing data per taxon:

```bash
chmod +x /bwdata3/bcummings/SCRIPTS/calculate_missing_data_per_taxon.pl

perl /bwdata3/bcummings/SCRIPTS/calculate_missing_data_per_taxon.pl \
    concatenated_NUC_min75.fa \
    transcriptome_missing_data_by_taxon.csv
```

##### *Amino acid data*

For amino acid data, run IQ-TREE with respective concatenated data and partition file using ```-m MFP+MERGE``` to select the best-fit partitioning scheme and generate trees from the best-fit substitution models for each partition, or using ```-m C60``` to generate trees from the C60 substitution model for each partition. Note that the first option is a very time-intensive run and can take over week.

```bash
cd /bwdata3/bcummings/COROPHIOID/07-SPECIESTREE/mintaxa75%/AA_bestgenetreemodels/output_IQTREE

iqtree -s concatenated_AA_min75.fa -spp partitions_AA_min75.nex -m MFP+MERGE -st AA -bb 1000 -nt AUTO -pre AA_MFP_min75
```

OR

```bash
iqtree -s concatenated_AA_min75.fa -spp partitions_AA_min75.nex -m C60 -st AA -bb 1000 -nt AUTO -pre AA_C60_min75
```

#### 2.10.5 *Compare tree topology*

Compare topologies of trees built from nucleotide and amino acid data. If topologies are consistent and/or bootstrap support is high for most clades, include Robinson-Foulds gene property in genesortR filtering (Section 2.11). If topologies are inconsistent and/or bootstrap support is low for clades, omit Robinson-Foulds gene property.

> **UPDATE 11/2024:**
Topologies are inconsistent so we will omit Robinson-Foulds gene property.

---

## 3. BAIT DESIGN

### 3.1 Subset orthogroups by phylogenetic usefulness

We will use the R script genesortR (Koch 2021) (https://github.com/mongiardino/genesortR) to extract orthogroups which are most phylogenetically useful. This reduces heterogeneity and optimizes phylogenetic inference from orthogroups for bait design.

#### 3.1.1 *Consolidate files for genesortR*

Copy nucleotide data from Section 2.10, including the concatenated data matrix, partition file, gene trees file, and species tree file.

```bash
mkdir -p [path_to_working_genesortR_folder]/input
```

```bash
cd mkdir -p [path_to_working_genesortR_folder]/input
cp [path_to_prelim_tree_folder]/NUC_PART/output_IQTREE/concatenated_NUC_PART_min75.fa .
cp [path_to_prelim_tree_folder]/NUC_PART/output_IQTREE/partitions_NUC_PART_min75.nex .
cp [path_to_prelim_tree_folder]/NUC_PART/output_IQTREE/concatenated_NUC_GENETREES_min75.nwk .
cp [path_to_prelim_tree_folder]/NUC_PART/output_IQTREE/NUC_PART_min75.contree .
```

#### 3.1.2 *Format files for genesortR*

Remove incompatible symbols in the deflines of the gene tree file.

```bash
sed 's/|[^:]*//g' concatenated_NUC_GENETREES_min75.nwk > concatenated_NUC_GENETREES_min75_renamed.nwk
```

Convert species tree to newick format.

```bash
cp NUC_PART_min75.contree NUC_PART_min75.nwk
```

Use custom script ```partition_rename.pl``` on partition file to replace partition names with orthogroup names:
perl [path_to_script]/partition_rename.pl [path_to_working_genesortR_folder]/input/partitions_NUC_PART_min75.nex partitions_NUC_PART_min75_renamed.nex

#### 3.1.3 *Run genesortR*

Open R and run genesortR script with the following parameters:

```bash
type <- 'DNA'
ingroup <- c('Lat_bac', 'Cap_lae') #the names of two terminals that bracket the ingroup
threshold <- '8'    # Set to 25% of ingroup taxa if matrix occupancy is <75%. Set to ~33% of ingroup taxa if matrix occupancy is ≥75%.
remove_outliers <- T
outlier_fraction <- 0.10
n_genes <- 'all'
topological_similarity <- T

```

#### 3.1.4 *Determine most phylogenetically useful orthogroups*

Look at the printed output in the R console and look at the percentage of variance associated with the "Phylogenetic Usefulness Axis". Compare this value to a graph of the principal components to identify whether PC1 or PC2 is the "Phylogenetic Usefulness Axis".

```R
install.packages("FactoMineR")
install.packages("devtools")
install.packages("factoextra")
library(FactoMineR)
library(devtools)
library(factoextra)

fviz_pca_var(
    PCA, col.var = "cos2",
    gradient.cols = c("#00AFBB", "#E7B800", "#FC4E07"),
    repel = TRUE # Avoid text overlapping
    )
```

Open ```properties_sorted_dataset.csv``` in Excel and sort the identified "Phylogenetic Usefulness Axis" (i.e., PC1 or PC2) in ascending order. Note that genesortR automatically does this, but it's good to double check.

Copy orthogroup names corresponding to the 200 highest ranked genes (i.e., the top half of the PC column), and paste these names into a .txt file. Save file as ```200BESTGENES.txt```.

Upload all genesortR output and ```200BESTGENES.txt``` to a new folder on the server.

```bash
mkdir -p [path_to_working_genesortR_folder]/RAW_OUTPUT
# Upload genesortR output and 200BESTGENES.txt to this folder
```

#### 3.1.5 *Extract best orthogroups*

Use the custom script ```copy_genesortR_files.pl``` to extract orthogroups that are listed in the ```200BESTGENES.txt``` file. Do this for both nucleotide and amino acid data to remain consistent for downstream phylogenetic analyses.

##### *Nucleotide data*

```bash
mkdir -p [path_to_working_genesortR_folder]/NUC
```

```bash
perl [path_to_script]/copy_genesortR_files.pl [path_to_working_genesortR_folder]/RAW_OUTPUT/50%BESTGENES.txt [path_to_working_pal2nal_folder]/03-P2N [path_to_working_genesortR_folder]/NUC
```

##### *Amino acid data*

```bash
mkdir -p [path_to_working_genesortR_folder]/AA
```

```bash
perl [path_to_script]/copy_genesortR_files.pl [path_to_working_genesortR_folder]/RAW_OUTPUT/200BESTGENES.txt [path_to_working_pal2nal_folder]/01-SEQS [path_to_working_genesortR_folder]/AA

```

---

### 3.2 Subset taxa in orthogroups (optional)

To improve specificity in sequences uploaded to Arbor Biosciences for bait design, we will extract orthologs from a select few corophioid taxa in the nucleotide orthogroup datasets. These data subsets will be used for bait design and to generate species trees that can be compared with full datasets to assess phylogenetic performance (see Section 2.15). We will choose 3 taxa and span the breadth of predicted corophioid phylogenetic space.

#### 3.2.1 *Make list of taxa to exclude*

Make a text file called ```exclude_taxa.txt``` containing the list of taxa to be EXCLUDED from orthogroups.

```txt
Nip_hra
Eus_gig
Gam_lac
Ase_hil
Ali_gig
Sco_sch
...
etc

```

#### 3.2.2 *Make select files*

For each orthogroup, use ```exclude_taxa.txt``` with the custom script ```generate_select_files.pl``` to generate tab separated lists of taxa to be INCLUDED in orthogroups.

```bash
mkdir -p [path_to_working_taxasubset_folder]/pods2outgroups/NUC/select_files
```

```bash
chmod +x [path_to_script]/generate_select_files.pl
perl [path_to_script]/generate_select_files.pl [path_to_working_genesortR_folder]/NUC/ /[path_to_working_taxasubset_folder]/pods2outgroups/NUC/select_files [path_to_working_taxasubset_folder]/exclude_taxa.txt
```

#### 3.2.3 *Extract taxa contigs from orthogroups*

For each orthogroup, use the "select_file" and a modified version of the ```select_contigs.pl``` script (Hahn et al. 2014) to extract ortholog sequences associated with taxa in the tab separated lists. This modified script can recognize both amino acid and nucleotide data, just in case we ever want to subsample taxa from amino acid data at a later date.

```bash
mkdir -p [path_to_working_taxasubset_folder]/pods2outgroups/NUC/output
cd [path_to_working_taxasubset_folder]/pods2outgroups/NUC/output
```

```bash
chmod +x [path_to_script]/select_contigs.pl

for orthogroup_file in [path_to_working_genesortR_folder]/NUC/*.fa; do base_name=$(basename "$orthogroup_file" .fa); select_file="[path_to_working_taxasubset_folder]/pods2outgroups/NUC/select_files/select_file_${base_name}.tsv"; output_file="[path_to_working_taxasubset_folder]/pods2outgroups/NUC/output/genesortR_filtered_${base_name}.fa"; if [[ -e "$select_file" ]]; then perl [path_to_script]/select_contigs_edit.pl -n "$select_file" "$orthogroup_file" "$output_file"; else echo "Select file $select_file does not exist for $orthogroup_file"; fi; done
```

#### 3.2.4 *Check target coverage*

Use PhyloPyPruner to verify that the taxa-subset orthogroups covers ~400-500 Kb of target space. Our Arbor Biosciences sequencing package is limited to 500 Kb target space for baits.

First, use FastTree with substitution model for nucleotides (```-nt -gtr -gamma```) to construct quick gene trees from the subsampled orthogroups.

```bash
mkdir -p cd [path_to_working_taxasubset_folder]/pods2outgroups/NUC/output_w_GENETREE
```

```bash
cd [path_to_working_taxasubset_folder]/pods2outgroups/NUC/output_w_GENETREE
cp -r [path_to_working_genesortR_folder]/outlier15%/pods2outgroups/NUC/input/* .
```

```bash
for i in genesortR_filtered_OG*.fa; do FastTreeMP -nt -gtr -gamma -nni -quiet "$i" > "${i%.fa}.tree"; done
```

Run phylopypruner on the taxa-subset orthogroups and gene trees, and move results to a new folder. The output parameters don't matter here because we just want the input stats.

```bash
cd [path_to_working_taxasubset_folder]/pods2outgroups/NUC/output_w_GENETREE
phylopypruner --threads 50 --dir . --min-len 100 --min-taxa 13 --min-support 0.70 --mask pdist --trim-lb 5 --trim-divergent 0.70 --min-pdist 2e-8 --prune LS
```

```bash
mv phylopypruner_output [path_to_working_taxasubset_folder]/pods2outgroups/NUC
```

Download and open "input_alignment_stats.csv" in Excel. Create a new column which is the product of the "sequences" and the "meanSeqLen" column. Sum this column and make sure the result is 500-550 Kb. If over or under this range, reduce the number of "best genes" and repeat Section 2.12 until you get desired target coverage.

---

### 3.3 Screen for mitochondrial genes (optional)

To ensure balanced sequencing coverage of baits, we will screen the taxa-subset orthogroups through InterProScan (Jones et al 2014, Blum et al 2021) to verify the absence of mitochondrial genes that could disrupt effective nuclear DNA capture.

#### 3.3.1 *Format data for InterProScan*

Remove hyphens from data. These are not allowed in InterProScan.

```bash
cp [path_to_working_taxasubset_folder]/pods2outgroups/NUC/output/*.fa [path_to_working_interproscan_folder]/input
```

```bash
cd [path_to_working_interproscan_folder]/input
for file in *.fa; do sed 's/-//g' "$file" > "nohyphen_${file%.fa}.fa" && mv "nohyphen_${file%.fa}.fa" "$file"; done
```

#### 3.3.2 *Choose orthologs*

Choose 1 random ortholog in each orthogroup for running through InterProScan to save computation time. Orthologous sequences in each orthogroup represent the same gene in theory, so it doesn't matter which you choose.

```bash
for file in *.fa; do random_contig=$(grep "^>" "$file" | shuf -n 1); awk -v contig="$random_contig" '/^>/{p=0} $0 == contig{p=1} p' "$file" > "nohyphen_single_${file#nohyphen_}" && rm "$file"; done
```

#### 3.3.3 *Run InterProScan*

Run InterproScan on chosen orthologs.

```bash
mkdir -p [path_to_working_interproscan_folder]/output
```

```bash
for file in [path_to_working_interproscan_folder]/input/*.fa; do /usr/local/interproscan-5.26-65.0/interproscan.sh -i "$file" --cpu 16 --iprlookup --goterms --pathways --formats TSV,GFF3 --output-file-base "[path_to_working_interproscan_folder]/output/$(basename "$file" .fa)-InterProScan"; done
```

#### 3.3.4 *Format output*

Combine all output .tsv files into one tab separated list for easier viewing.

```bash
cat *.tsv > temp_output.tsv && mv temp_output.tsv combined_output.tsv
```

Sort output to only mitochondrial proteins

```bash
grep -i -E "mito" combined_output.tsv > filtered_mitochondria.tsv
```

Make FASTA file for BLAST to see if any of these output proteins are coded for by mitochondrial genes.

```bash
perl [path_to_script]/extract_sequences.pl [path_to_working_interproscan_folder]/input filtered_mitochondria.tsv mitochondria_prot.fa
```

#### 3.3.5 *BLAST output*

Upload FASTA file to NCBI BLAST (https://blast.ncbi.nlm.nih.gov/) and search tblastn database (i.e., translated nucleotide databases using a protein query). Look at results of each protein and determine which are coded for by nuclear or mitochondrial genes. If any are coded for by mitochondrial genes, remove the associated orthogroup from the dataset before proceeding with subsequent steps.

---

### 3.4 Submit for bait design

We will submit the final selection of "best genes" to Arbor Bioscences for bait design. Because we used the mean sequence length to estimate the target coverage of our gene set, our approximation is likely imprecise. As a result, Arbor may need to adjust the number of genes to ensure the final set stays within the 550kb target coverage limit. To facilitate this process, we will provide a ranked list of the top 200 genes ordered from best to worst (i.e., the "200BESTGENES.txt" file from above), allowing Arbor to refine the selection as needed.

> **UPDATE 12/2024:**
The input dataset contained 869 target sequences (839 unique) spanning 845,850 nucleotides with an average GC content of 45.7%. Targets were softmasked for repeats, gaps were removed, and duplicate names corrected. Using 80nt baits with 3x tiling (~27nt overlap), 28,703 baits were designed. BLAST screening against the Hyalella azteca genome filtered out overrepresented loci, leaving 28,125 baits with ≤25% repeat masking and no mitogenome hits. The final kit was reduced to 19,913 baits to fit within the 20K bait limit, prioritizing the top 132 genes in the "best genes" list.

---

## 4. TARGET CAPTURE

### 4.1 Acquiring target capture data

DNA extractions of museum specimens will be submitted to Arbor Biosciences for target-capture sequencing. Arbor will use custom baits to sequence the extractions. The resulting sequence files and metadata (e.g., read count, adapter sequences) will be uploaded as .fastq.gz files on the company website which can be downloaded to the local computer. Upload these files to the server using Cyberduck or ```scp```.

---

### 4.2 Renaming reads

Raw .fastq files from Arbor will be renamed with taxa IDs before proceeding with cleaning and assembly.

```bash
# Example
cd [path_to_raw_targetcapture]

mv CBC01_L0001_R1.fastq.gz Aoroides_spp_L0001_R1.fastq.gz &&
mv CBC01_L0002_R1.fastq.gz Protomedeia_prudens_L0002_R1.fastq.gz &&
mv CBC01_L0003_R1.fastq.gz Ampithoe_lacertosa_L0003_R1.fastq.gz &&
mv CBC01_L0004_R1.fastq.gz Latigammaropsis_spp_L0004_R1.fastq.gz &&
mv CBC01_L0005_R1.fastq.gz Cerapus_spp_L0005_R1.fastq.gz &&
mv CBC01_L0006_R1.fastq.gz Microprotopidae_spp_L0006_R1.fastq.gz &&
mv CBC01_L0007_R1.fastq.gz Cyamus_erraticus_L0007_R1.fastq.gz &&
mv CBC01_L0008_R1.fastq.gz Cyamus_boopis_L0008_R1.fastq.gz &&
mv CBC01_L0009_R1.fastq.gz Cyamus_scammoni_L0009_R1.fastq.gz &&
mv CBC01_L0010_R1.fastq.gz Tropichelura_spp_1_L0010_R1.fastq.gz &&
mv CBC01_L0011_R1.fastq.gz Plesiolembos_rectangulatus_L0011_R1.fastq.gz &&
mv CBC01_L0012_R1.fastq.gz Dyopedos_arcticus_L0012_R1.fastq.gz &&
mv CBC01_L0013_R1.fastq.gz Podocerus_cristatus_1_L0013_R1.fastq.gz &&
mv CBC01_L0014_R1.fastq.gz Ischyrocerus_anguipes_2_L0014_R1.fastq.gz &&
mv CBC01_L0015_R1.fastq.gz Monocorophium_acherusicum_L0015_R1.fastq.gz &&
mv CBC01_L0016_R1.fastq.gz Paragammaropsis_spp_L0016_R1.fastq.gz &&
mv CBC01_L0017_R1.fastq.gz Chevaliidae_spp_L0017_R1.fastq.gz &&
mv CBC01_L0018_R1.fastq.gz Podocerus_cristatus_2_L0018_R1.fastq.gz &&
mv CBC01_L0019_R1.fastq.gz Pseudampithoides_incurvaria_L0019_R1.fastq.gz &&
mv CBC01_L0020_R1.fastq.gz Tropichelura_spp_2_L0020_R1.fastq.gz &&
mv CBC01_L0021_R1.fastq.gz Kamakidae_spp_L0021_R1.fastq.gz

mv CBC01_L0001_R2.fastq.gz Aoroides_spp_L0001_R2.fastq.gz &&
mv CBC01_L0002_R2.fastq.gz Protomedeia_prudens_L0002_R2.fastq.gz &&
mv CBC01_L0003_R2.fastq.gz Ampithoe_lacertosa_L0003_R2.fastq.gz &&
mv CBC01_L0004_R2.fastq.gz Latigammaropsis_spp_L0004_R2.fastq.gz &&
mv CBC01_L0005_R2.fastq.gz Cerapus_spp_L0005_R2.fastq.gz &&
mv CBC01_L0006_R2.fastq.gz Microprotopidae_spp_L0006_R2.fastq.gz &&
mv CBC01_L0007_R2.fastq.gz Cyamus_erraticus_L0007_R2.fastq.gz &&
mv CBC01_L0008_R2.fastq.gz Cyamus_boopis_L0008_R2.fastq.gz &&
mv CBC01_L0009_R2.fastq.gz Cyamus_scammoni_L0009_R2.fastq.gz &&
mv CBC01_L0010_R2.fastq.gz Tropichelura_spp_1_L0010_R2.fastq.gz &&
mv CBC01_L0011_R2.fastq.gz Plesiolembos_rectangulatus_L0011_R2.fastq.gz &&
mv CBC01_L0012_R2.fastq.gz Dyopedos_arcticus_L0012_R2.fastq.gz &&
mv CBC01_L0013_R2.fastq.gz Podocerus_cristatus_1_L0013_R2.fastq.gz &&
mv CBC01_L0014_R2.fastq.gz Ischyrocerus_anguipes_2_L0014_R2.fastq.gz &&
mv CBC01_L0015_R2.fastq.gz Monocorophium_acherusicum_L0015_R2.fastq.gz &&
mv CBC01_L0016_R2.fastq.gz Paragammaropsis_spp_L0016_R2.fastq.gz &&
mv CBC01_L0017_R2.fastq.gz Chevaliidae_spp_L0017_R2.fastq.gz &&
mv CBC01_L0018_R2.fastq.gz Podocerus_cristatus_2_L0018_R2.fastq.gz &&
mv CBC01_L0019_R2.fastq.gz Pseudampithoides_incurvaria_L0019_R2.fastq.gz &&
mv CBC01_L0020_R2.fastq.gz Tropichelura_spp_2_L0020_R2.fastq.gz &&
mv CBC01_L0021_R2.fastq.gz Kamakidae_spp_L0021_R2.fastq.gz
```

---

### 4.3 Cleaning target capture data

#### 4.3.1 *FastQC*

Arbor Biosciences will trim adapters/indexes from raw target capture data before sending you the files. However, it is likely that some adapters/indexes have not been removed. We will use FastQC (Andrews 2010) to do a quick quality control check.

> **NOTE:**
You can also run FastQC as an interactive graphical application on your local computer, if you prefer. You can [download it here](https://www.bioinformatics.babraham.ac.uk/projects/download.html#fastqc).

```bash
# on mildred
cd /bwdata3/bcummings/COROPHIOID/00-DATA/TARGET_CAPTURE/

fastqc /bwdata3/bcummings/COROPHIOID/00-DATA/TARGET_CAPTURE/*fastq.gz


#move fastqc output files to a new folder
mkdir -p /bwdata3/bcummings/COROPHIOID/11-TARGETCAPTURE/01-Trimming/00-FASTQC_BEFORETRIMMING

cd /bwdata3/bcummings/COROPHIOID/11-TARGETCAPTURE/01-Trimming/00-FASTQC_BEFORETRIMMING

mv /bwdata3/bcummings/COROPHIOID/00-DATA/TARGET_CAPTURE/*.zip .

mv /bwdata3/bcummings/COROPHIOID/00-DATA/TARGET_CAPTURE/*.html .

```

Download the .zip files and unzip to view the results. Open the html files and scroll to the bottom of the page to see the adapter content. Proceed with Section 3.3.2 if any adapters are in the sequences. If not, just use Trimmomatic to remove low quality trailing bases and skip to Section 3.3.3.

```bash
logout

scp bcummings@10.251.34.217:/bwdata3/bcummings/COROPHIOID/11-TARGETCAPTURE/01-Trimming/00-FASTQC_BEFORETRIMMING/*.zip "C:/Users/bmc82/Documents/UF/PhD_Projects/1-COROPHIOID/Data/Data_NextGenSeq/TargetCapture/Arbor/Results/01-FASTQC_BEFORETRIMMING"

scp bcummings@10.251.34.217:/bwdata3/bcummings/COROPHIOID/11-TARGETCAPTURE/01-Trimming/00-FASTQC_BEFORETRIMMING/*.html "C:/Users/bmc82/Documents/UF/PhD_Projects/1-COROPHIOID/Data/Data_NextGenSeq/TargetCapture/Arbor/Results/01-FASTQC_BEFORETRIMMING"
```

#### 4.3.2 *Trimming Adapters*

We will use Trimmomatic instead of Illumiprocessor (Faircloth 2013) to trim out adapter sequences and low quality trailing bases from PE Illumina reads. Illumiprocessor is difficult to set up and get to work properly with our data. We will run the program with relaxed parameters to maximize the number of reads available for assembly. These are the same trimming parameters we used to trim the transcriptome sequences above.

First, make a shell script ```00-script_trim_targetcapture.sh``` with each file that you want to trim. For example:

```shell
#!/bin/bash

java -jar /usr/local/Trimmomatic-0.39/trimmomatic-0.39.jar PE \
  -threads 50 \
  -phred33 \
  /bwdata3/bcummings/COROPHIOID/00-DATA/TARGET_CAPTURE/Ampithoe_lacertosa_L0003_R1.fastq.gz \
  /bwdata3/bcummings/COROPHIOID/00-DATA/TARGET_CAPTURE/Ampithoe_lacertosa_L0003_R2.fastq.gz \
  Ampithoe_lacertosa-READ1.fastq.gz \
  Ampithoe_lacertosa.unp1.fq \
  Ampithoe_lacertosa-READ2.fastq.gz \
  Ampithoe_lacertosa.unp2.fq \
  ILLUMINACLIP:/usr/local/Trimmomatic-0.39/adapters/TruSeq3-PE.fa:2:30:10 \
  LEADING:5 \
  TRAILING:5 \
  SLIDINGWINDOW:4:5 \
  MINLEN:25 \
  > Ampithoe_lacertosa.trimmo.out 2> Ampithoe_lacertosa.trimmo.err

java -jar /usr/local/Trimmomatic-0.39/trimmomatic-0.39.jar PE \
  -threads 50 \
  -phred33 \
  /bwdata3/bcummings/COROPHIOID/00-DATA/TARGET_CAPTURE/Aoroides_spp_L0001_R1.fastq.gz \
  /bwdata3/bcummings/COROPHIOID/00-DATA/TARGET_CAPTURE/Aoroides_spp_L0001_R2.fastq.gz \
  Aoroides_spp-READ1.fastq.gz \
  Aoroides_spp.unp1.fq \
  Aoroides_spp-READ2.fastq.gz \
  Aoroides_spp.unp2.fq \
  ILLUMINACLIP:/usr/local/Trimmomatic-0.39/adapters/TruSeq3-PE.fa:2:30:10 \
  LEADING:5 \
  TRAILING:5 \
  SLIDINGWINDOW:4:5 \
  MINLEN:25 \
  > Aoroides_spp.trimmo.out 2> Aoroides_spp.trimmo.err

#...
```

Then run the script.

```bash

mkdir -p /bwdata3/bcummings/COROPHIOID/11-TARGETCAPTURE/01-Trimming/01-TRIMMOMATIC

cd /bwdata3/bcummings/COROPHIOID/11-TARGETCAPTURE/01-Trimming/01-TRIMMOMATIC

chmod +x 00-script_trim_targetcapture.sh

bash ./00-script_trim_targetcapture.sh

```

Check quality of trimming by using FastQC.

```bash
# on mildred

#use cleaned sequences as input for FastQC

cd /bwdata3/bcummings/COROPHIOID/11-TARGETCAPTURE/01-Trimming

find 01-TRIMMOMATIC -type f -name "*.fastq.gz" -exec fastqc {} \;


#move fastqc output files to a new folder
mkdir -p /bwdata3/bcummings/COROPHIOID/11-TARGETCAPTURE/01-Trimming/02-FASTQC_AFTERTRIMMING

cd /bwdata3/bcummings/COROPHIOID/11-TARGETCAPTURE/01-Trimming/02-FASTQC_AFTERTRIMMING

mv /bwdata3/bcummings/COROPHIOID/11-TARGETCAPTURE/01-Trimming/01-TRIMMOMATIC/*.zip .

mv /bwdata3/bcummings/COROPHIOID/11-TARGETCAPTURE/01-Trimming/01-TRIMMOMATIC/*.html .

```

Download the .zip files and unzip to view the results. Open the html files and scroll to the bottom of the page to see the adapter content. The FastQC results will also serve as our baseline for before assembly (sequence lengths, etc.).

```bash
logout

scp bcummings@10.251.34.217:/bwdata3/bcummings/COROPHIOID/11-TARGETCAPTURE/01-Trimming/02-FASTQC_AFTERTRIMMING/*.zip "C:/Users/bmc82/Documents/UF/PhD_Projects/1-COROPHIOID/Data/Data_NextGenSeq/TargetCapture/Arbor/Results/02-FASTQC_AFTERTRIMMING"

scp bcummings@10.251.34.217:/bwdata3/bcummings/COROPHIOID/11-TARGETCAPTURE/01-Trimming/02-FASTQC_AFTERTRIMMING/*.html "C:/Users/bmc82/Documents/UF/PhD_Projects/1-COROPHIOID/Data/Data_NextGenSeq/TargetCapture/Arbor/Results/02-FASTQC_AFTERTRIMMING"
```

>**NOTE:** I had to re-trim Paragammaropsis_spp, Pseudampithoides_incurvaria, and Tropichelura_spp_2 with expanded TruSeq3-PE-2.fa adapters file since trimming with TruSeq-PE.fa did not get rid of all Illumina adapters.

---

### 4.4 Assembling target capture data

The automated Target Restricted Assembly Method, aTRAM 2.0 (Allen et al., 2015, 2018; http://www.github.com/juliema/) will be used to assemble target capture data using the orthologous transcriptome genes as reference sequences. This approach uses local blast searches and an iterative approach to produce assemblies for genes of interest from cleaned read data. In other words, aTRAM extracts just the loci you care about using reference sequences to guide the process.

We chose this approach over the PHYLUCE assembly pipeline because of the way our probes are designed and the evolutionary divergence among our taxa. In our dataset, individual loci are often fragmented across multiple contigs. When a single UCE probe matches more than one contig—due to this fragmentation—PHYLUCE interprets these as potential paralogs and excludes them from downstream analysis. As a result, this filtering reduces the number of loci available for matching to other UCE probes, limiting overall data recovery.

It is convenient to run aTRAM as a loop, assembling a set of genes for a set of taxa. These can be set up in two parts, as shown below.

#### 4.4.1 *Installing aTRAM*

First, install aTRAM as a micromamba environment. The program requires a newer version of BLAST than what might be on the servers, so we will be sure to install that as well.

```bash
cd /bwdata3/bcummings/00-MICROMAMBA
git clone https://github.com/juliema/aTRAM.git
cd aTRAM
micromamba create -p /bwdata3/bcummings/00-MICROMAMBA/atram -f environment.yml
cd ..
mv aTRAM atram

micromamba activate /bwdata3/bcummings/00-MICROMAMBA/atram

#aTRAM requires a newer version of BLAST
micromamba install -c bioconda blast=2.14

#aTRAM requires an older version of spades
micromamba install -c bioconda -c conda-forge spades=3.11.1

#you will also need bbmap
micromamba install -c bioconda -c conda-forge bbmap


```
#### 4.4.2 *Prepare libraries for assembly*

Use `atram_preprocessor.py` to prep libraries for aTRAM. This will build BLAST databases and an SQLite3 database for each taxon for rapid read retrieval. We will run this as a loop so that we can save time.

First, prepare the input files. We will use a custom script to change the headers to match the format expected by aTRAM. Note that this step might take up to 10 minutes per file.

```bash
cd /bwdata3/bcummings/COROPHIOID/11-TARGETCAPTURE/01-Trimming/01-TRIMMOMATIC

rm -r *-singles.fastq.gz

mkdir -p /bwdata3/bcummings/COROPHIOID/11-TARGETCAPTURE/02-Contig_Assembly_aTRAM/atram_input

bash /bwdata3/bcummings/SCRIPTS/atram_rename.sh /bwdata3/bcummings/COROPHIOID/11-TARGETCAPTURE/01-Trimming/01-TRIMMOMATIC /bwdata3/bcummings/COROPHIOID/11-TARGETCAPTURE/02-Contig_Assembly_aTRAM/atram_input

```

Now run `atram_preprocessor.py` on the input files to make the aTRAM libraries.

```bash
cd /bwdata3/bcummings/COROPHIOID/11-TARGETCAPTURE/02-Contig_Assembly_aTRAM/

mkdir -p atram_db

micromamba activate /bwdata3/bcummings/00-MICROMAMBA/atram

for a in "${array[@]}";
do
atram_preprocessor.py --cpus 80 --gzip -b /bwdata3/bcummings/COROPHIOID/11-TARGETCAPTURE/02-Contig_Assembly_aTRAM/atram_db/${a}/lib_${a} --end-1 /bwdata3/bcummings/COROPHIOID/11-TARGETCAPTURE/02-Contig_Assembly_aTRAM/atram_input/${a}-READ1.fastq.gz --end-2 /bwdata3/bcummings/COROPHIOID/11-TARGETCAPTURE/02-Contig_Assembly_aTRAM/atram_input/${a}-READ2.fastq.gz
done

```

To get a better idea of what is going on, you can explore the output database. Note that this is NOT necessary, but it's good practice for working with sqlite. For example:

```bash
cd /bwdata3/bcummings/COROPHIOID/11-TARGETCAPTURE/02-Contig_Assembly_aTRAM/atram_db

# Enter database:
sqlite3 ${a}/lib_${a}.sqlite.db

# It’s often easier to change some defaults for better viewing:
.mode columns
.headers on
.nullvalue .

# To see which tables the database contains:
.tables

# To look at the contents of the "matches" table (i.e., data that would be used in a incomplete matrix in Section 3.5.2):
SELECT * FROM sequences;

.exit
```

>**Note:** SQLite and SQL are two distinct concepts in the realm of database management. The main difference between SQLite and SQL is that SQL is a language used for querying relational databases, while SQLite is a database management system that uses SQL.
>- SQL, or Structured Query Language, is a standard language for managing relational databases, used to access, create, and manage databases. It is a query language used with databases.
>- SQLite is a software library that provides a relational database management system, designed to be self-contained, serverless, and zero-configuration. It is a portable database that can be extended in any programming language used to access the database.

#### 4.4.3 *Assemble loci*

We will now use `atram.py` to assemble loci from the databases built by `atram_preprocessor.py`. We will use the 135 best transcriptome orthogroups (from above) as reference gene sequences. Each orthogroup file will act as a query file, and aTRAM uses BLAST to search the raw reads against this query file. We will choose SPADES as our assembler, but you could use Velvet, Trinity, or ABYSS.

First, make our aTRAM output folders.

```bash

cd /bwdata3/bcummings/COROPHIOID/11-TARGETCAPTURE/02-Contig_Assembly_aTRAM/

mkdir -p atram_output

array=(Amphideutopus_oculatus Ampithoe_lacertosa Aoroides_spp Cerapus_spp Chevaliidae_spp Cyamus_boopis Cyamus_erraticus Cyamus_scammoni Dyopedos_arcticus Ischyrocerus_anguipes Latigammaropsis_spp Microprotopus_raneyi Monocorophium_acherusicum Paragammaropsis_spp Plesiolembos_rectangulatus Podocerus_cristatus_1 Podocerus_cristatus_2 Protomedeia_prudens Pseudampithoides_incurvaria Tropichelura_spp_1 Tropichelura_spp_2)

for a in "${array[@]}";
do
mkdir atram_output/${a}
mkdir atram_output/${a}/output_nucleotide
mkdir atram_output/${a}/logs
done
```

Use the custom Perl script `extract_refs_from_probes.pl` to prepare full-length nucleotide reference sequences for downstream assembly and stitching. While UCE probes are designed to target only specific regions within genes, this script extracts the entire orthologous gene sequences from the original orthogroup FASTA files. It does so by parsing each UCE probe header to identify the associated UCE ID, reference taxon, and locus, then matches these to the corresponding entries in the orthogroup files. The full-length orthologs are written to a cleaned reference FASTA file with standardized headers, and a TSV lookup table file is also generated to record the relationship between each UCE, taxon, locus, and orthogroup.

```bash
perl /bwdata3/bcummings/SCRIPTS/extract_refs_from_probes.pl \
    /bwdata3/bcummings/COROPHIOID/11-TARGETCAPTURE/02-Contig_Assembly_aTRAM/probes_renamed.fasta \
    /bwdata3/bcummings/COROPHIOID/06-PAL2NAL/mintaxa75%_ARBOR_BAITDESIGN/03-P2N/ \
    /bwdata3/bcummings/COROPHIOID/11-TARGETCAPTURE/02-Contig_Assembly_aTRAM/refseqs_NUC.fasta \
    /bwdata3/bcummings/COROPHIOID/11-TARGETCAPTURE/02-Contig_Assembly_aTRAM/matched_loci_info.tsv

```

We will use the custom perl script `extract_matching_proteins.pl` with the TSV lookup table and our folder of amino acid sequences (from earlier when we used PAL2NAL to prep sequences for species tree construction) to extract the sequences and create an amino acid reference file. We won't use this until the stitching step after assembly.

```bash
perl /bwdata3/bcummings/SCRIPTS/extract_matching_proteins.pl matched_loci_info.tsv /bwdata3/bcummings/COROPHIOID/06-PAL2NAL/mintaxa75%_ARBOR/01-SEQS refseqs_AA.fasta
```

Now run aTRAM. Note that this will take ~1 day to complete for our 21 taxa.

```bash
cd /bwdata3/bcummings/COROPHIOID/11-TARGETCAPTURE/02-Contig_Assembly_aTRAM

micromamba activate /bwdata3/bcummings/00-MICROMAMBA/atram


# Assemble genes
array=(Amphideutopus_oculatus Ampithoe_lacertosa Aoroides_spp Cerapus_spp Chevaliidae_spp Cyamus_boopis Cyamus_erraticus Cyamus_scammoni Dyopedos_arcticus Ischyrocerus_anguipes Latigammaropsis_spp Microprotopus_raneyi Monocorophium_acherusicum Paragammaropsis_spp Plesiolembos_rectangulatus Podocerus_cristatus_1 Podocerus_cristatus_2 Protomedeia_prudens Pseudampithoides_incurvaria Tropichelura_spp_1 Tropichelura_spp_2)

for a in "${array[@]}"; # Iterate through samples
do
atram.py -b /bwdata3/bcummings/COROPHIOID/11-TARGETCAPTURE/02-Contig_Assembly_aTRAM/atram_db/${a}/lib_${a} -Q /bwdata3/bcummings/COROPHIOID/11-TARGETCAPTURE/02-Contig_Assembly_aTRAM/refseqs_NUC.fasta -i 5 --cpus 80 -o /bwdata3/bcummings/COROPHIOID/11-TARGETCAPTURE/02-Contig_Assembly_aTRAM/atram_output/${a}/output_nucleotide/${a} --log-file /bwdata3/bcummings/COROPHIOID/11-TARGETCAPTURE/02-Contig_Assembly_aTRAM/atram_output/${a}/logs/${a}.Nucleotide.log -a spades
done


```

>**NOTE:** Failed assemblies (i.e., assemblies with insufficient BLAST hits) will show up in the log file as "ERROR: Exception: [Errno 2] No such file or directory:". Do not worry about this - the program just doesn't have a more elegant way of stating which assemblies failed. If you are trying to troubleshoot assemblies, use the "-t TEMP_DIR" and "--keep-temp-dir" flags to keep temporary files for debugging.

Now separate the "filtered" and "all" output into respective output folders.

```bash
array=(Amphideutopus_oculatus Ampithoe_lacertosa Aoroides_spp Cerapus_spp Chevaliidae_spp Cyamus_boopis Cyamus_erraticus Cyamus_scammoni Dyopedos_arcticus Ischyrocerus_anguipes Latigammaropsis_spp Microprotopus_raneyi Monocorophium_acherusicum Paragammaropsis_spp Plesiolembos_rectangulatus Podocerus_cristatus_1 Podocerus_cristatus_2 Protomedeia_prudens Pseudampithoides_incurvaria Tropichelura_spp_1 Tropichelura_spp_2)

for a in "${array[@]}"; # Iterate through samples
do
cd /bwdata3/bcummings/COROPHIOID/11-TARGETCAPTURE/02-Contig_Assembly_aTRAM/atram_output/${a}/output_nucleotide
mkdir filtered all
mv *.filtered_contigs.fasta filtered/
mv *.all_contigs.fasta all/
done
```

We will use the "*.filtered_contigs.fasta" output for downstream analyses.

#### 4.4.4 *Stitch exons*

To recover full gene sequences from our target UCE loci, we must stitch together exons from the aTRAM assemblies. ATRAM performs iterative assemblies to build contigs, but loci are often split into multiple contigs due to low sequencing coverage or high divergence from the reference. Although aTRAM's build-in `atram_stitcher.py` offers a general-purpose contig merging function, it is not optimized for extracting exon-only sequences from fragmented assemblies. Because our assemblies often contained multiple short contigs per locus due to high divergence or low coverage, we used a reference-guided annotation and stitching pipeline (Allen et al. 2017; Barrow et al. 2019) that identifies exon boundaries with Exonerate v.2.2.0 (Slater and Birney 2005) and reconstructs coding sequences with greater accuracy.

The steps are as follows: (1) select only the contigs from the last ATRAM iteration, which are likely to be the most complete and longest, (2) employ Exonerate to align the assembled contigs to the reference exon sequences (in our case, Cap_lae, Cer_spp, Mon_ins, and the handful of exon sequences from the other taxa that we used to design our probes), and (3) perform exon stitching to reconstruct loci that were broken into multiple contigs or had missing regions. This last step retains both ends of the sequence for alignment if the middle is missing, improving the recovery of partial loci.

This pipeline uses a script `exon_stitching.sh` which requires multiple inputs:

- `tax_list.txt`: A plain text file with one target taxon name per line. These names are used to match and iterate over all UCE locus assemblies corresponding to each taxon.
- `refseqs_AA.fasta`: A FASTA file of amino acid reference sequences from the species used for bait/probe design. Only one reference file is used per script run.
- `atram_output/`: A directory containing nucleotide FASTA assemblies from aTRAM for each UCE locus and taxon.
- `overlap`: A numeric value indicating the minimum number of overlapping bases required to stitch adjacent exons together (commonly set to `10`).

First, copy the amino acid file that we made earlier.

```bash
mkdir -p /bwdata3/bcummings/COROPHIOID/11-TARGETCAPTURE/02-Contig_Assembly_aTRAM/atram_stitching/exon_stitching2.0

cp -r /bwdata3/bcummings/COROPHIOID/11-TARGETCAPTURE/02-Contig_Assembly_aTRAM/refseqs_AA.fasta /bwdata3/bcummings/COROPHIOID/11-TARGETCAPTURE/02-Contig_Assembly_aTRAM/atram_stitching/exon_stitching2.0
```

Next, we need to use `getlastiteration.pl` to keep only the contigs from the last aTRAM iteration.

```bash
array=(Amphideutopus_oculatus Ampithoe_lacertosa Aoroides_spp Cerapus_spp Chevaliidae_spp Cyamus_boopis Cyamus_erraticus Cyamus_scammoni Dyopedos_arcticus Ischyrocerus_anguipes Latigammaropsis_spp Microprotopus_raneyi Monocorophium_acherusicum Paragammaropsis_spp Plesiolembos_rectangulatus Podocerus_cristatus_1 Podocerus_cristatus_2 Protomedeia_prudens Pseudampithoides_incurvaria Tropichelura_spp_1 Tropichelura_spp_2)

for a in "${array[@]}";
do
cd /bwdata3/bcummings/COROPHIOID/11-TARGETCAPTURE/02-Contig_Assembly_aTRAM/atram_output/${a}/output_nucleotide/filtered
perl /bwdata3/bcummings/SCRIPTS/getlastiteration.pl
mkdir /bwdata3/bcummings/COROPHIOID/11-TARGETCAPTURE/02-Contig_Assembly_aTRAM/atram_output/${a}/output_nucleotide/filtered/last
mv *.last.* last/
cd ..
cd /bwdata3/bcummings/COROPHIOID/11-TARGETCAPTURE/02-Contig_Assembly_aTRAM/atram_output/${a}/output_nucleotide/all
perl /bwdata3/bcummings/SCRIPTS/getlastiteration.pl
mkdir /bwdata3/bcummings/COROPHIOID/11-TARGETCAPTURE/02-Contig_Assembly_aTRAM/atram_output/${a}/output_nucleotide/all/last
mv *.last.* last/
done

```

For these outputs, we will need to combine matches for the same UCE (from different probe taxa) into the same file and rename file names and headers to keep things clear and compatible with the stitching script.

First count and delete empty assembly files, if there are any.

```bash
mkdir -p /bwdata3/bcummings/COROPHIOID/11-TARGETCAPTURE/02-Contig_Assembly_aTRAM/atram_stitching/exon_stitching2.0/assemblies

array=(Amphideutopus_oculatus Ampithoe_lacertosa Aoroides_spp Cerapus_spp Chevaliidae_spp Cyamus_boopis Cyamus_erraticus Cyamus_scammoni Dyopedos_arcticus Ischyrocerus_anguipes Latigammaropsis_spp Microprotopus_raneyi Monocorophium_acherusicum Paragammaropsis_spp Plesiolembos_rectangulatus Podocerus_cristatus_1 Podocerus_cristatus_2 Protomedeia_prudens Pseudampithoides_incurvaria Tropichelura_spp_1 Tropichelura_spp_2)

for a in "${array[@]}";
do
cp /bwdata3/bcummings/COROPHIOID/11-TARGETCAPTURE/02-Contig_Assembly_aTRAM/atram_output/${a}/output_nucleotide/filtered/last/* /bwdata3/bcummings/COROPHIOID/11-TARGETCAPTURE/02-Contig_Assembly_aTRAM/atram_stitching/exon_stitching2.0/assemblies
done

#Change name so that UCE number is added after the taxon name. This let's us keep track of contigs after downstream processing.

cd /bwdata3/bcummings/COROPHIOID/11-TARGETCAPTURE/02-Contig_Assembly_aTRAM/atram_stitching/exon_stitching2.0/assemblies

for f in *.fasta; do
  taxon=$(echo "$f" | cut -d'.' -f1)
  uce=$(echo "$f" | grep -o 'uce_[0-9]\{3\}')
  new="${uce}_${taxon}.${f#*.}"
  mv "$f" "$new"
done


# Count and delete empty assembly files
find . -type f -ls | wc -l
# 1339

find . -type f -empty -delete
find . -type f -ls | wc -l
# 1339

```

Now, make the taxon list. Each name should match the portion before .lib in your UCE assembly filenames. For example, if your file is named "Abyssorchomene_distinctus_uce001.lib_Abyssorchomene_distinctus_refseqs_NUC_uce_001_Cer_spp_OG0001610_1.filtered_contigs.last.fasta", then the taxon name would be Abyssorchomene_distinctus_uce001.

```bash
cd /bwdata3/bcummings/COROPHIOID/11-TARGETCAPTURE/02-Contig_Assembly_aTRAM/atram_stitching/exon_stitching2.0

for f in /bwdata3/bcummings/COROPHIOID/11-TARGETCAPTURE/02-Contig_Assembly_aTRAM/atram_stitching/exon_stitching2.0/assemblies/*.lib_*.fasta; do basename "$f" | sed 's/_uce[0-9]\{3\}//' | sed 's/\.lib.*//' ; done | sort -u > tax_list.txt

```

Now, we can use all these inputs with the `exon_stitching.sh` script to stitch together exons from UCE loci that were assembled using aTRAM. This process refines contig-level assemblies by aligning them to amino acid reference sequences, identifying exonic regions with Exonerate, and stitching those regions together into final gene models.

For each taxon-UCE in the species list, (1) the script iterates over all UCE locus assemblies for that taxon-UCE, (2) identifies the matching reference protein sequence (based on UCE ID), (3) uses Exonerate to align the reference protein to the assembled contig, (4) parses Exonerate output to extract high-confidence exonic alignments, (5) stitches adjacent or overlapping exons if they meet the overlap threshold, and (6) outputs the stitched exonic sequence to a new FASTA file for downstream use.

For each taxon-UCE, the script outputs a stitched nucleotide FASTA file using the matched reference protein as the name (e.g., "uce_001_Cer_spp_OG0001610.stitched_exons.fasta").

> **NOTE**
Make sure your stitching folder has a subfolder called "bin" containing the following scripts from Barrow et al 2019: editfasta.pl, getcontigs.pl, stitch.contigs.pl, summary_stats.pl. Also, make sure you have the exon_stitching.sh script in the exon_stitching2.0 folder.

```bash
cd /bwdata3/bcummings/COROPHIOID/11-TARGETCAPTURE/02-Contig_Assembly_aTRAM/atram_stitching/exon_stitching2.0

bash exon_stitching.sh tax_list.txt refseqs_AA.fasta assemblies/ 10
```

The output shows which exons were successfully recovered and stitched together from our sequenced target species, using references derived from the probe taxa. Each output FASTA file corresponds to a single UCE locus, and each sequence header indicates the target species and the UCE it was matched to. For example, a header like >Abyssorchomene_distinctus_uce_001. 3_NODE_1... indicates that this stitched exon sequence belongs to the species Abyssorchomene distinctus and corresponds to UCE locus 001. The rest of the header includes information from the original aTRAM assembly and alignment score.

#### 4.4.5 *Consolidate stitched exons*

Since we used multiple reference files (each based on different probe taxa), some UCE loci were targeted more than once across these files. As a result, we may have multiple stitched exon sequences for the same taxon–UCE combination. These duplicates can vary in length or completeness depending on the reference file used and how well the target species aligned to it. To standardize the dataset, we retain only the best sequence per gene per taxon, typically selecting the longest sequence as it is assumed to represent the most complete reconstruction.

To perform this filtering, we run the custom Perl script ```select_best_stitched_exons.pl```. This script recursively searches through subfolders containing stitched exon files, identifies all taxon–UCE pairs, retains only the longest sequence for each pair, and combines everything into one file per UCE. Additionally, it modifies output filenames by removing the probe taxon portion from the matched reference name, ensuring compatibility with formatting required for downstream analyses.

```bash

perl /bwdata3/bcummings/SCRIPTS/select_best_stitched_exons.pl /bwdata3/bcummings/COROPHIOID/11-TARGETCAPTURE/02-Contig_Assembly_aTRAM/atram_stitching/exon_stitching2.0/ /bwdata3/bcummings/COROPHIOID/11-TARGETCAPTURE/02-Contig_Assembly_aTRAM/atram_stitching/stitched_exons/

```

#### 4.4.6 *Reciprocal best-BLAST check*

We will perform a recipricol BLAST check on the final stitched exons to identify and remove any individual-locus combination for which the top match for the assembled locus was not the target locus. For this search, we will create a local blast database from all orthologous genes from all taxa used to build the original transcriptome tree.

```bash
#First combine all the sequences into one file

cd /bwdata3/bcummings/COROPHIOID/11-TARGETCAPTURE/02-Contig_Assembly_aTRAM
mkdir /bwdata3/bcummings/COROPHIOID/11-TARGETCAPTURE/02-Contig_Assembly_aTRAM/reciprocal_besthit
cd reciprocal_besthit/
mkdir db
cd db/

for f in /bwdata3/bcummings/COROPHIOID/06-PAL2NAL/mintaxa75%_ARBOR_BAITDESIGN/02-CDS/*.fa; do
    og=$(basename "$f" .fa | sed 's/_pruned$//')
    awk -v og="$og" '/^>/{print $0"|"og; next} {print}' "$f"
done > transcriptome_genes.fasta

makeblastdb -in transcriptome_genes.fasta -dbtype 'nucl' -out transcriptome_genes_blast_db
mkdir ../seq
cd ..
cp ../atram_stitching/stitched_exons/*stitched_exons.fasta seq/

for f in seq/*.fasta
do blastn -query "$f" -db db/transcriptome_genes_blast_db -out "${f%.fasta}_blast.csv" -outfmt 10
done

cd seq/
for filename in *.csv; do echo "$filename"; cat "$filename"; done > blast_output.txt

```

Go through BLAST output and flag any locus-individual combos where top hit is not the desired locus. In our case, use the "orthogroup_map" tab in the "probes_working.xlsx" file to figure out which locus corresponds to which UCE number. Remove mismatches from stitched exons files before proceeding with downstream analyses.

```bash
mkdir -p /bwdata3/bcummings/COROPHIOID/11-TARGETCAPTURE/02-Contig_Assembly_aTRAM/reciprocal_besthit/seq_clean/

cp -r /bwdata3/bcummings/COROPHIOID/11-TARGETCAPTURE/02-Contig_Assembly_aTRAM/atram_stitching/stitched_exons/*stitched_exons.fasta /bwdata3/bcummings/COROPHIOID/11-TARGETCAPTURE/02-Contig_Assembly_aTRAM/reciprocal_besthit/seq_clean/

cd /bwdata3/bcummings/COROPHIOID/11-TARGETCAPTURE/02-Contig_Assembly_aTRAM/reciprocal_besthit/seq_clean/


patterns="uce_099_Ampithoe_lacertosa."

for file in *.stitched_exons.fasta; do
  awk -v pat="$patterns" '/^>/{keep = ($0 !~ pat)} keep' "$file" > tmp && mv tmp "$file"
done

#remove empty files
mkdir -p empty
find . -maxdepth 1 -type f -name "*.fasta" -size 0 -exec mv {} empty/ \;


```

---

### 4.5 Harvesting UCE loci from transcriptome and genome data

We will repeat the aTRAM pipeline for the raw transcriptome data and genome assemblies to extract the corresponding UCE loci. Rather than using the Trinity-assembled transcriptomes from above, we use aTRAM to assemble UCE loci directly from raw reads to ensure consistency in assembly strategy and reference-based locus identification across datasets. Thus, we maintain methodological comparability between datasets which will be used in the final tree construction.

For genome assemblies provided as .cds files, which cannot be processed with aTRAM, we instead extract UCE loci using BLAST searches against the coding sequences, followed by formatting steps that mimic the structure of aTRAM outputs to preserve downstream compatibility (Section 4.5.4).

#### 4.5.1 *Trimming adapters from transcriptomes*

We already trimmed adapters from transcriptome data with Trimmomatic before the Trinity assembly above, so we will just use this data.

```bash
mkdir -p /bwdata3/bcummings/COROPHIOID/12-TRANSCRIPTOME_HARVESTING/01-Trimming

cd /bwdata3/bcummings/COROPHIOID/12-TRANSCRIPTOME_HARVESTING/01-Trimming

ln -s /bwdata3/bcummings/COROPHIOID/00-TRIMMING/*.fastq.gz .


```

#### 4.5.2 *Prepare libraries for assembly*

Use `atram_preprocessor.py` to prep libraries for aTRAM. This will build BLAST databases and an SQLite3 database for each taxon for rapid read retrieval. We will run this as a loop so that we can save time.

First, prepare the input files. We will copy the raw fastq.gz files and then change the headers to match the format expected by aTRAM. Note that this step might take at least 10 minutes per file.

```bash
mkdir -p /bwdata3/bcummings/COROPHIOID/12-TRANSCRIPTOME_HARVESTING/02-Contig_Assembly_aTRAM/atram_input

cd /bwdata3/bcummings/COROPHIOID/12-TRANSCRIPTOME_HARVESTING/02-Contig_Assembly_aTRAM/

bash /bwdata3/bcummings/SCRIPTS/atram_rename.sh /bwdata3/bcummings/COROPHIOID/12-TRANSCRIPTOME_HARVESTING/01-Trimming/ /bwdata3/bcummings/COROPHIOID/12-TRANSCRIPTOME_HARVESTING/02-Contig_Assembly_aTRAM/atram_input


```

Now run `atram_preprocessor.py` on the input files to make the aTRAM libraries.

```bash
cd /bwdata3/bcummings/COROPHIOID/12-TRANSCRIPTOME_HARVESTING/02-Contig_Assembly_aTRAM/

mkdir -p atram_db

micromamba activate /bwdata3/bcummings/00-MICROMAMBA/atram

array=(Abyssorchomene_distinctus Alicella_gigantea Aoroides_spp Apseudomorpha_spp Armadillidium_vulgare Asellus_hilgendorfii Caprella_irregularis Caprella_laeviscula Cerapus_spp Cheirimedeia_zotea Cyclaspis_gigas Cymothoa_exigua Deutella_californica Dulichia_rhabdoplastis Dulichia_spp Diastylopsis_goekei Eusirus_giganteus Gammaropsis_thompsoni Gammarus_lacustris Globosolembos_spp Grandidierella_japonica Hirondellea_gigas Hyperia_spp Idotea_balthica Ischyrocerus_anguipes Jassa_carltoni Jassa_marmorata Laticorophium_baconi Leptochelia_spp Metacaprella_anomala Microjassa_litotes Monocorophium_acherusicum Monocorophium_insidiosum Neomysis_awatschensis Neoxenodice_spp_1 Neoxenodice_spp_2 Niphargus_hrabei Orchestia_grillus Paragammaropsis_spp Parhyale_hawaiiensis Photis_conchicola Phoxokalliapseudes_tomiokaensis Platorchestia_hallaensis Podocerus_septumcarinatus Podocerus_spp Scalpellum_stearnsi Scopelocheirus_schellenbergi Sunamphitoe_spp_1 Sunamphitoe_spp_2 Talitrus_saltador Tanaella_kommritzia Tritella_laevis Zeuxo_ezoensis)

for a in "${array[@]}";
do
atram_preprocessor.py --cpus 80 --gzip -b /bwdata3/bcummings/COROPHIOID/12-TRANSCRIPTOME_HARVESTING/02-Contig_Assembly_aTRAM/atram_db/${a}/lib_${a} --end-1 /bwdata3/bcummings/COROPHIOID/12-TRANSCRIPTOME_HARVESTING/02-Contig_Assembly_aTRAM/atram_input/${a}-READ1.fastq.gz --end-2 /bwdata3/bcummings/COROPHIOID/12-TRANSCRIPTOME_HARVESTING/02-Contig_Assembly_aTRAM/atram_input/${a}-READ2.fastq.gz
done

```

#### 4.5.3 *Assemble loci*

We will now use `atram.py` to assemble loci from the databases built by `atram_preprocessor.py`. We will use the 135 best transcriptome orthogroups (from above) as reference gene sequences. Each orthogroup file will act as a query file, and aTRAM uses BLAST to search the raw reads against this query file. We will choose SPADES as our assembler, but you could use Velvet, Trinity, or ABYSS.

First, make our aTRAM output folders.

```bash

cd /bwdata3/bcummings/COROPHIOID/12-TRANSCRIPTOME_HARVESTING/02-Contig_Assembly_aTRAM/

mkdir -p atram_output

array=(Abyssorchomene_distinctus Alicella_gigantea Aoroides_spp Apseudomorpha_spp Armadillidium_vulgare Asellus_hilgendorfii Caprella_irregularis Caprella_laeviscula Cerapus_spp Cheirimedeia_zotea Cyclaspis_gigas Cymothoa_exigua Deutella_californica Dulichia_rhabdoplastis Dulichia_spp Diastylopsis_goekei Eusirus_giganteus Gammaropsis_thompsoni Gammarus_lacustris Globosolembos_spp Grandidierella_japonica Hirondellea_gigas Hyperia_spp Idotea_balthica Ischyrocerus_anguipes Jassa_carltoni Jassa_marmorata Laticorophium_baconi Leptochelia_spp Metacaprella_anomala Microjassa_litotes Monocorophium_acherusicum Monocorophium_insidiosum Neomysis_awatschensis Neoxenodice_spp_1 Neoxenodice_spp_2 Niphargus_hrabei Orchestia_grillus Paragammaropsis_spp Parhyale_hawaiiensis Photis_conchicola Phoxokalliapseudes_tomiokaensis Platorchestia_hallaensis Podocerus_septumcarinatus Podocerus_spp Scalpellum_stearnsi Scopelocheirus_schellenbergi Sunamphitoe_spp_1 Sunamphitoe_spp_2 Talitrus_saltador Tanaella_kommritzia Tritella_laevis Zeuxo_ezoensis)

for a in "${array[@]}";
do
mkdir atram_output/${a}
mkdir atram_output/${a}/output_nucleotide
mkdir atram_output/${a}/logs
done


-----

array=(Neoxenodice_spp_1 Cyclaspis_gigas Diastylopsis_goekei)

for a in "${array[@]}";
do
mkdir atram_output/${a}
mkdir atram_output/${a}/output_nucleotide
mkdir atram_output/${a}/logs
done

```

Use the custom Perl script `extract_refs_from_probes.pl` to prepare full-length nucleotide reference sequences for downstream assembly and stitching. While UCE probes are designed to target only specific regions within genes, this script extracts the entire orthologous gene sequences from the original orthogroup FASTA files. It does so by parsing each UCE probe header to identify the associated UCE ID, reference taxon, and locus, then matches these to the corresponding entries in the orthogroup files. The full-length orthologs are written to a cleaned reference FASTA file with standardized headers, and a TSV lookup table file is also generated to record the relationship between each UCE, taxon, locus, and orthogroup.

```bash
perl /bwdata3/bcummings/SCRIPTS/extract_refs_from_probes.pl \
    /bwdata3/bcummings/COROPHIOID/12-TRANSCRIPTOME_HARVESTING/02-Contig_Assembly_aTRAM/probes_renamed.fasta \
    /bwdata3/bcummings/COROPHIOID/06-PAL2NAL/mintaxa75%_ARBOR_BAITDESIGN/03-P2N/ \
    /bwdata3/bcummings/COROPHIOID/12-TRANSCRIPTOME_HARVESTING/02-Contig_Assembly_aTRAM/refseqs_NUC.fasta \
    /bwdata3/bcummings/COROPHIOID/12-TRANSCRIPTOME_HARVESTING/02-Contig_Assembly_aTRAM/matched_loci_info.tsv

```

We will use the custom perl script `extract_matching_proteins.pl` with the TSV lookup table and our folder of amino acid sequences (from earlier when we used PAL2NAL to prep sequences for species tree construction) to extract the sequences and create an amino acid reference file. We won't use this until the stitching step after assembly.

```bash
perl /bwdata3/bcummings/SCRIPTS/extract_matching_proteins.pl matched_loci_info.tsv /bwdata3/bcummings/COROPHIOID/06-PAL2NAL/mintaxa75%_ARBOR_BAITDESIGN/01-SEQS refseqs_AA.fasta
```

Now run aTRAM. Note that this will probably take ~1 week to complete for our 51 taxa.

```bash
cd /bwdata3/bcummings/COROPHIOID/12-TRANSCRIPTOME_HARVESTING/02-Contig_Assembly_aTRAM

micromamba activate /bwdata3/bcummings/00-MICROMAMBA/atram


# Assemble genes
array=(Abyssorchomene_distinctus Alicella_gigantea Aoroides_spp Apseudomorpha_spp Armadillidium_vulgare Asellus_hilgendorfii Caprella_irregularis Caprella_laeviscula Cerapus_spp Cheirimedeia_zotea Cyclaspis_gigas Cymothoa_exigua Deutella_californica Dulichia_rhabdoplastis Dulichia_spp Diastylopsis_goekei Eusirus_giganteus Gammaropsis_thompsoni Gammarus_lacustris Globosolembos_spp Grandidierella_japonica Hirondellea_gigas Hyperia_spp Idotea_balthica Ischyrocerus_anguipes Jassa_carltoni Jassa_marmorata Laticorophium_baconi Leptochelia_spp Metacaprella_anomala Microjassa_litotes Monocorophium_acherusicum Monocorophium_insidiosum Neomysis_awatschensis Neoxenodice_spp_1 Neoxenodice_spp_2 Niphargus_hrabei Orchestia_grillus Paragammaropsis_spp Parhyale_hawaiiensis Photis_conchicola Phoxokalliapseudes_tomiokaensis Platorchestia_hallaensis Podocerus_septumcarinatus Podocerus_spp Scalpellum_stearnsi Scopelocheirus_schellenbergi Sunamphitoe_spp_1 Sunamphitoe_spp_2 Talitrus_saltador Tanaella_kommritzia Tritella_laevis Zeuxo_ezoensis)

for a in "${array[@]}"; # Iterate through samples
do
atram.py -b /bwdata3/bcummings/COROPHIOID/12-TRANSCRIPTOME_HARVESTING/02-Contig_Assembly_aTRAM/atram_db/${a}/lib_${a} -Q /bwdata3/bcummings/COROPHIOID/12-TRANSCRIPTOME_HARVESTING/02-Contig_Assembly_aTRAM/refseqs_NUC.fasta -i 5 --cpus 80 -o /bwdata3/bcummings/COROPHIOID/12-TRANSCRIPTOME_HARVESTING/02-Contig_Assembly_aTRAM/atram_output/${a}/output_nucleotide/${a} --log-file /bwdata3/bcummings/COROPHIOID/12-TRANSCRIPTOME_HARVESTING/02-Contig_Assembly_aTRAM/atram_output/${a}/logs/${a}.Nucleotide.log -a spades
done


```

>**NOTE:** Failed assemblies (i.e., assemblies with insufficient BLAST hits) will show up in the log file as "ERROR: Exception: [Errno 2] No such file or directory:". Do not worry about this - the program just doesn't have a more elegant way of stating which assemblies failed. If you are trying to troubleshoot assemblies, use the "-t TEMP_DIR" and "--keep-temp-dir" flags to keep temporary files for debugging.

Now separate the "filtered" and "all" output into respective output folders.

```bash
array=(Abyssorchomene_distinctus Alicella_gigantea Aoroides_spp Apseudomorpha_spp Armadillidium_vulgare Asellus_hilgendorfii Caprella_irregularis Caprella_laeviscula Cerapus_spp Cheirimedeia_zotea Cyclaspis_gigas Cymothoa_exigua Deutella_californica Dulichia_rhabdoplastis Dulichia_spp Diastylopsis_goekei Eusirus_giganteus Gammaropsis_thompsoni Gammarus_lacustris Globosolembos_spp Grandidierella_japonica Hirondellea_gigas Hyperia_spp Idotea_balthica Ischyrocerus_anguipes Jassa_carltoni Jassa_marmorata Laticorophium_baconi Leptochelia_spp Metacaprella_anomala Microjassa_litotes Monocorophium_acherusicum Monocorophium_insidiosum Neomysis_awatschensis Neoxenodice_spp_1 Neoxenodice_spp_2 Niphargus_hrabei Orchestia_grillus Paragammaropsis_spp Parhyale_hawaiiensis Photis_conchicola Phoxokalliapseudes_tomiokaensis Platorchestia_hallaensis Podocerus_septumcarinatus Podocerus_spp Scalpellum_stearnsi Scopelocheirus_schellenbergi Sunamphitoe_spp_1 Sunamphitoe_spp_2 Talitrus_saltador Tanaella_kommritzia Tritella_laevis Zeuxo_ezoensis)

for a in "${array[@]}"; # Iterate through samples
do
cd /bwdata3/bcummings/COROPHIOID/12-TRANSCRIPTOME_HARVESTING/02-Contig_Assembly_aTRAM/atram_output/${a}/output_nucleotide
mkdir filtered all
mv *.filtered_contigs.fasta filtered/
mv *.all_contigs.fasta all/
done



```

We will use the "*.filtered_contigs.fasta" output for downstream analyses.

>**NOTE:** We removed the atram output for Aoroides_spp into a separate folder called "atram_output_DIDNOTUSE" because we do not yet have permission to use this specimen in downstream analyses. We did not use this transcriptome in our transcriptome tree either.

#### 4.5.4 Extracting UCEs from Genome Coding Sequences

Besides transcriptomes, our genome files are available only as coding sequence FASTA files, rather than raw sequencing reads. These pre-assembled files cannot be processed with aTRAM, which is designed to work from raw reads. Instead, we extract UCE loci from .cds files using a BLAST-based method, then reformat the output to match aTRAM-assembled loci so that they can be used in downstream exon stitching.

This approach maintains maximum consistency with the existing aTRAM pipeline by mimicking its output structure and format.

First, make the BLAST database.

```bash
mkdir -p /bwdata3/bcummings/COROPHIOID/12-TRANSCRIPTOME_HARVESTING/02-Contig_Assembly_aTRAM/genomes/

cd /bwdata3/bcummings/COROPHIOID/12-TRANSCRIPTOME_HARVESTING/02-Contig_Assembly_aTRAM/genomes/

cp /bwdata3/bcummings/COROPHIOID/01-TRINITY/GENOME/Hya_azt/Hya_azt.cds .
cp /bwdata3/bcummings/COROPHIOID/01-TRINITY/GENOME/Tig_cal/Tig_cal.cds .

mv Hya_azt.cds Hyalella_azteca.cds
mv Tig_cal.cds Tigriopus_californicus.cds

makeblastdb -in Hyalella_azteca.cds -dbtype nucl -out Hyalella_azteca_db
makeblastdb -in Tigriopus_californicus.cds -dbtype nucl -out Tigriopus_californicus_db

```

Then run BLAST. We use the same refseqs_NUC.fasta file used in the aTRAM assemblies to identify matches to UCE loci:

```bash
blastn -query /bwdata3/bcummings/COROPHIOID/12-TRANSCRIPTOME_HARVESTING/02-Contig_Assembly_aTRAM/refseqs_NUC.fasta \
       -db Hyalella_azteca_db \
       -out Hyalella_azteca_raw_hits.tsv \
       -evalue 1e-10 \
       -outfmt "6 qseqid sseqid pident length mismatch gapopen qstart qend sstart send evalue bitscore"

blastn -query /bwdata3/bcummings/COROPHIOID/12-TRANSCRIPTOME_HARVESTING/02-Contig_Assembly_aTRAM/refseqs_NUC.fasta \
       -db Tigriopus_californicus_db \
       -out Tigriopus_californicus_raw_hits.tsv \
       -evalue 1e-10 \
       -outfmt "6 qseqid sseqid pident length mismatch gapopen qstart qend sstart send evalue bitscore"
```

Then extract the matched sequences using a custom script which will write them to separate FASTA files, named in a similar way to the aTRAM output. The output will be placed in the same folder as the transcriptome UCE assemblies that are in line for stitching.

```bash
mkdir -p /bwdata3/bcummings/COROPHIOID/12-TRANSCRIPTOME_HARVESTING/02-Contig_Assembly_aTRAM/genomes/output

cd /bwdata3/bcummings/COROPHIOID/12-TRANSCRIPTOME_HARVESTING/02-Contig_Assembly_aTRAM/genomes/

perl /bwdata3/bcummings/SCRIPTS/extract_matched_cds_regions.pl \
     --cds Hyalella_azteca.cds \
     --blast Hyalella_azteca_raw_hits.tsv \
     --taxon Hyalella_azteca \
     --output-dir /bwdata3/bcummings/COROPHIOID/12-TRANSCRIPTOME_HARVESTING/02-Contig_Assembly_aTRAM/genomes/output

perl /bwdata3/bcummings/SCRIPTS/extract_matched_cds_regions.pl \
     --cds Tigriopus_californicus.cds \
     --blast Tigriopus_californicus_raw_hits.tsv \
     --taxon Tigriopus_californicus \
     --output-dir /bwdata3/bcummings/COROPHIOID/12-TRANSCRIPTOME_HARVESTING/02-Contig_Assembly_aTRAM/genomes/output

```

#### 4.5.5 *Stitch exons*

To recover full gene sequences from our target UCE loci, we must stitch together exons from the aTRAM assemblies. ATRAM performs iterative assemblies to build contigs, but loci are often split into multiple contigs due to low sequencing coverage or high divergence from the reference. Although aTRAM's build-in `atram_stitcher.py` offers a general-purpose contig merging function, it is not optimized for extracting exon-only sequences from fragmented assemblies. Because our assemblies often contained multiple short contigs per locus due to high divergence or low coverage, we used a reference-guided annotation and stitching pipeline (Allen et al. 2017; Barrow et al. 2019) that identifies exon boundaries with Exonerate v.2.2.0 (Slater and Birney 2005) and reconstructs coding sequences with greater accuracy.

The steps are as follows: (1) select only the contigs from the last ATRAM iteration, which are likely to be the most complete and longest, (2) employ Exonerate to align the assembled contigs to the reference exon sequences (in our case, Cap_lae, Cer_spp, Mon_ins, and the handful of exon sequences from the other taxa that we used to design our probes), and (3) perform exon stitching to reconstruct loci that were broken into multiple contigs or had missing regions. This last step retains both ends of the sequence for alignment if the middle is missing, improving the recovery of partial loci.

This pipeline uses a script `exon_stitching.sh` which requires multiple inputs:

- `tax_list.txt`: A plain text file with one target taxon name per line. These names are used to match and iterate over all UCE locus assemblies corresponding to each taxon.
- `refseqs_AA.fasta`: A FASTA file of amino acid reference sequences from the species used for bait/probe design. Only one reference file is used per script run.
- `atram_output/`: A directory containing nucleotide FASTA assemblies from aTRAM for each UCE locus and taxon.
- `overlap`: A numeric value indicating the minimum number of overlapping bases required to stitch adjacent exons together (commonly set to `10`).

First, copy the amino acid file that we made earlier.

```bash
mkdir -p /bwdata3/bcummings/COROPHIOID/11-TARGETCAPTURE/02-Contig_Assembly_aTRAM/atram_stitching/exon_stitching2.0

cp -r /bwdata3/bcummings/COROPHIOID/12-TRANSCRIPTOME_HARVESTING/02-Contig_Assembly_aTRAM/refseqs_AA.fasta /bwdata3/bcummings/COROPHIOID/12-TRANSCRIPTOME_HARVESTING/02-Contig_Assembly_aTRAM/atram_stitching/exon_stitching2.0
```

Now, we need to use `getlastiteration.pl` to keep only the contigs from the last aTRAM iteration.

```bash
array=(Abyssorchomene_distinctus Alicella_gigantea Apseudomorpha_spp Armadillidium_vulgare Asellus_hilgendorfii Caprella_irregularis Caprella_laeviscula Cerapus_spp Cheirimedeia_zotea Cyclaspis_gigas Cymothoa_exigua Deutella_californica Diastylopsis_goekei Dulichia_spp Eusirus_giganteus Gammaropsis_thompsoni Gammarus_lacustris Globosolembos_spp Grandidierella_japonica Hirondellea_gigas Hyperia_spp Idotea_balthica Ischyrocerus_anguipes Jassa_carltoni Jassa_marmorata Laticorophium_baconi Leptochelia_spp Metacaprella_anomala Microjassa_litotes Monocorophium_acherusicum Monocorophium_insidiosum Neomysis_awatschensis Neoxenodice_spp_1 Neoxenodice_spp_2 Niphargus_hrabei Orchestia_grillus Paragammaropsis_spp Parhyale_hawaiiensis Photis_conchicola Phoxokalliapseudes_tomiokaensis Platorchestia_hallaensis Podocerus_septumcarinatus Podocerus_spp Scalpellum_stearnsi Scopelocheirus_schellenbergi Sunamphitoe_spp_1 Sunamphitoe_spp_2 Talitrus_saltador Tanaella_kommritzia Tritella_laevis Zeuxo_ezoensis)

for a in "${array[@]}";
do
cd /bwdata3/bcummings/COROPHIOID/12-TRANSCRIPTOME_HARVESTING/02-Contig_Assembly_aTRAM/atram_output/${a}/output_nucleotide/filtered
perl /bwdata3/bcummings/SCRIPTS/getlastiteration.pl
mkdir /bwdata3/bcummings/COROPHIOID/12-TRANSCRIPTOME_HARVESTING/02-Contig_Assembly_aTRAM/atram_output/${a}/output_nucleotide/filtered/last
mv *.last.* last/
cd ..
cd /bwdata3/bcummings/COROPHIOID/12-TRANSCRIPTOME_HARVESTING/02-Contig_Assembly_aTRAM/atram_output/${a}/output_nucleotide/all
perl /bwdata3/bcummings/SCRIPTS/getlastiteration.pl
mkdir /bwdata3/bcummings/COROPHIOID/12-TRANSCRIPTOME_HARVESTING/02-Contig_Assembly_aTRAM/atram_output/${a}/output_nucleotide/all/last
mv *.last.* last/
done

```

For these outputs, we will need to combine matches for the same UCE (from different probe taxa) into the same file and rename file names and headers to keep things clear and compatible with the stitching script.

First count and delete empty assembly files, if there are any.

```bash
mkdir -p /bwdata3/bcummings/COROPHIOID/12-TRANSCRIPTOME_HARVESTING/02-Contig_Assembly_aTRAM/atram_stitching/exon_stitching2.0/assemblies

array=(Abyssorchomene_distinctus Alicella_gigantea Apseudomorpha_spp Armadillidium_vulgare Asellus_hilgendorfii Caprella_irregularis Caprella_laeviscula Cerapus_spp Cheirimedeia_zotea Cyclaspis_gigas Cymothoa_exigua Deutella_californica Diastylopsis_goekei Dulichia_spp Eusirus_giganteus Gammaropsis_thompsoni Gammarus_lacustris Globosolembos_spp Grandidierella_japonica Hirondellea_gigas Hyperia_spp Idotea_balthica Ischyrocerus_anguipes Jassa_carltoni Jassa_marmorata Laticorophium_baconi Leptochelia_spp Metacaprella_anomala Microjassa_litotes Monocorophium_acherusicum Monocorophium_insidiosum Neomysis_awatschensis Neoxenodice_spp_1 Neoxenodice_spp_2 Niphargus_hrabei Orchestia_grillus Paragammaropsis_spp Parhyale_hawaiiensis Photis_conchicola Phoxokalliapseudes_tomiokaensis Platorchestia_hallaensis Podocerus_septumcarinatus Podocerus_spp Scalpellum_stearnsi Scopelocheirus_schellenbergi Sunamphitoe_spp_1 Sunamphitoe_spp_2 Talitrus_saltador Tanaella_kommritzia Tritella_laevis Zeuxo_ezoensis)

for a in "${array[@]}";
do
cp /bwdata3/bcummings/COROPHIOID/12-TRANSCRIPTOME_HARVESTING/02-Contig_Assembly_aTRAM/atram_output/${a}/output_nucleotide/filtered/last/* /bwdata3/bcummings/COROPHIOID/12-TRANSCRIPTOME_HARVESTING/02-Contig_Assembly_aTRAM/atram_stitching/exon_stitching2.0/assemblies
done

#Change name so that UCE number is added before the taxon name. This let's us keep track of contigs after downstream processing.

cd /bwdata3/bcummings/COROPHIOID/12-TRANSCRIPTOME_HARVESTING/02-Contig_Assembly_aTRAM/atram_stitching/exon_stitching2.0/assemblies

for f in *.fasta; do
  taxon=$(echo "$f" | cut -d'.' -f1)
  uce=$(echo "$f" | grep -o 'uce_[0-9]\{3\}')
  new="${uce}_${taxon}.${f#*.}"
  mv "$f" "$new"
done


# Count and delete empty assembly files
find . -type f -ls | wc -l
# 2683

find . -type f -empty -delete
find . -type f -ls | wc -l
# 2683

```

Now, make the taxon list. Each name should match the portion before .lib in your UCE assembly filenames. For example, if your file is named "Abyssorchomene_distinctus_uce001.lib_Abyssorchomene_distinctus_refseqs_NUC_uce_001_Cer_spp_OG0001610_1.filtered_contigs.last.fasta", then the taxon name would be "uce001_Abyssorchomene_distinctus".

```bash
cd /bwdata3/bcummings/COROPHIOID/12-TRANSCRIPTOME_HARVESTING/02-Contig_Assembly_aTRAM/atram_stitching/exon_stitching2.0

for f in /bwdata3/bcummings/COROPHIOID/12-TRANSCRIPTOME_HARVESTING/02-Contig_Assembly_aTRAM/atram_stitching/exon_stitching2.0/assemblies/u*.fasta; do
    fname=$(basename "$f")
    prefix=$(echo "$fname" | sed -E 's/^(uce_[0-9]{3}_[^\.]+)\.lib_.*/\1/')
    echo "$prefix"
done | sort -u > tax_list.txt




```

Now, we can use all these inputs with the `exon_stitching.sh` script to stitch together exons from UCE loci that were assembled using aTRAM. This process refines contig-level assemblies by aligning them to amino acid reference sequences, identifying exonic regions with Exonerate, and stitching those regions together into final gene models.

For each taxon-UCE in the species list, (1) the script iterates over all UCE locus assemblies for that taxon-UCE, (2) identifies the matching reference protein sequence (based on UCE ID), (3) uses Exonerate to align the reference protein to the assembled contig, (4) parses Exonerate output to extract high-confidence exonic alignments, (5) stitches adjacent or overlapping exons if they meet the overlap threshold, and (6) outputs the stitched exonic sequence to a new FASTA file for downstream use.

For each taxon-UCE, the script outputs a stitched nucleotide FASTA file using the matched reference protein as the name (e.g., "uce_001_Cer_spp_OG0001610.stitched_exons.fasta").

> **NOTE**
Make sure your stitching folder has a subfolder called "bin" containing the following scripts from Barrow et al 2019: editfasta.pl, getcontigs.pl, stitch.contigs.pl, summary_stats.pl

```bash
cd /bwdata3/bcummings/COROPHIOID/12-TRANSCRIPTOME_HARVESTING/02-Contig_Assembly_aTRAM/atram_stitching/exon_stitching2.0

sh exon_stitching.sh tax_list.txt refseqs_AA.fasta assemblies/ 10

```

The output shows which exons were successfully recovered and stitched together from our sequenced target species, using references derived from the probe taxa. Each output FASTA file corresponds to a single UCE locus, and each sequence header indicates the target species and the UCE it was matched to. For example, a header like >Abyssorchomene_distinctus_uce_001. 3_NODE_1... indicates that this stitched exon sequence belongs to the species Abyssorchomene distinctus and corresponds to UCE locus 001. The rest of the header includes information from the original aTRAM assembly and alignment score.

#### 4.5.6 *Consolidate stitched exons*

Since we used multiple reference files (each based on different probe taxa), some UCE loci were targeted more than once across these files. As a result, we may have multiple stitched exon sequences for the same taxon–UCE combination. These duplicates can vary in length or completeness depending on the reference file used and how well the target species aligned to it. To standardize the dataset, we retain only the best sequence per gene per taxon, typically selecting the longest sequence as it is assumed to represent the most complete reconstruction.

To perform this filtering, we run the custom Perl script ```select_best_stitched_exons.pl```. This script recursively searches through subfolders containing stitched exon files, identifies all taxon–UCE pairs, retains only the longest sequence for each pair, and combines everything into one file per UCE.

```bash

perl /bwdata3/bcummings/SCRIPTS/select_best_stitched_exons.pl /bwdata3/bcummings/COROPHIOID/12-TRANSCRIPTOME_HARVESTING/02-Contig_Assembly_aTRAM/atram_stitching/exon_stitching2.0/ /bwdata3/bcummings/COROPHIOID/12-TRANSCRIPTOME_HARVESTING/02-Contig_Assembly_aTRAM/atram_stitching/stitched_exons/

```

#### 4.5.7 *Combine with genome data*

Now we can combine the stitched UCEs harvested from transcriptomes with the UCEs harvested from genomes.

To do this, we will run the shell script ```genome_atram_merge.sh``` which will merge genome UCEs into existing exon-stitched UCE alignments.

```bash

mkdir -p /bwdata3/bcummings/COROPHIOID/12-TRANSCRIPTOME_HARVESTING/02-Contig_Assembly_aTRAM/atram_stitching/stitched_exons_withgenome

bash /bwdata3/bcummings/SCRIPTS/genome_atram_merge.sh \
  /bwdata3/bcummings/COROPHIOID/12-TRANSCRIPTOME_HARVESTING/02-Contig_Assembly_aTRAM/atram_stitching/stitched_exons/ \
  /bwdata3/bcummings/COROPHIOID/12-TRANSCRIPTOME_HARVESTING/02-Contig_Assembly_aTRAM/genomes/output \
  /bwdata3/bcummings/COROPHIOID/12-TRANSCRIPTOME_HARVESTING/02-Contig_Assembly_aTRAM/atram_stitching/stitched_exons_withgenome

```

We will then rerun the ```select_best_stitched_exons.pl``` script to make sure we still only retain only the single longest sequence for each taxon-UCE pair.

```bash

perl /bwdata3/bcummings/SCRIPTS/select_best_stitched_exons.pl /bwdata3/bcummings/COROPHIOID/12-TRANSCRIPTOME_HARVESTING/02-Contig_Assembly_aTRAM/atram_stitching/stitched_exons_withgenome/ /bwdata3/bcummings/COROPHIOID/12-TRANSCRIPTOME_HARVESTING/02-Contig_Assembly_aTRAM/atram_stitching/stitched_exons_withgenome_final

```

#### 4.5.8 *Reciprocal best-BLAST check*

We will perform a recipricol BLAST check on the final stitched exons to identify and remove any individual-locus combination for which the top match for the assembled locus was not the target locus. For this search, we will create a local blast database from all orthologous genes from all taxa used to build the original transcriptome tree.

```bash
#First combine all the sequences into one file

cd /bwdata3/bcummings/COROPHIOID/12-TRANSCRIPTOME_HARVESTING/02-Contig_Assembly_aTRAM
mkdir /bwdata3/bcummings/COROPHIOID/12-TRANSCRIPTOME_HARVESTING/02-Contig_Assembly_aTRAM/reciprocal_besthit
cd reciprocal_besthit/
mkdir db
cd db/

for f in /bwdata3/bcummings/COROPHIOID/06-PAL2NAL/mintaxa75%_ARBOR_BAITDESIGN/02-CDS/*.fa; do
    og=$(basename "$f" .fa | sed 's/_pruned$//')
    awk -v og="$og" '/^>/{print $0"|"og; next} {print}' "$f"
done > transcriptome_genes.fasta

makeblastdb -in transcriptome_genes.fasta -dbtype 'nucl' -out transcriptome_genes_blast_db
mkdir ../seq
cd ..
cp ../atram_stitching/stitched_exons_withgenome_final/*stitched_exons.fasta seq/

for f in seq/*.fasta
do blastn -query "$f" -db db/transcriptome_genes_blast_db -out "${f%.fasta}_blast.csv" -outfmt 10
done

cd seq/
for filename in *.csv; do echo "$filename"; cat "$filename"; done > blast_output.txt

```

Go through BLAST output and flag any locus-individual combos where top hit is not the desired locus. In our case, use the "orthogroup_map" tab in the "probes_working.xlsx" file to figure out which locus corresponds to which UCE number. Remove mismatches from stitched exons files before proceeding with downstream analyses.

```bash
mkdir -p /bwdata3/bcummings/COROPHIOID/12-TRANSCRIPTOME_HARVESTING/02-Contig_Assembly_aTRAM/reciprocal_besthit/seq_clean/

cp -r /bwdata3/bcummings/COROPHIOID/12-TRANSCRIPTOME_HARVESTING/02-Contig_Assembly_aTRAM/atram_stitching/stitched_exons_withgenome_final/*stitched_exons.fasta /bwdata3/bcummings/COROPHIOID/12-TRANSCRIPTOME_HARVESTING/02-Contig_Assembly_aTRAM/reciprocal_besthit/seq_clean/

cd /bwdata3/bcummings/COROPHIOID/12-TRANSCRIPTOME_HARVESTING/02-Contig_Assembly_aTRAM/reciprocal_besthit/seq_clean/


patterns="uce_024_Caprella_irregularis.|uce_024_Caprella_laeviscula.|uce_024_Cheirimedeia_zotea.|uce_024_Deutella_californica.|uce_024_Dulichia_spp.|uce_024_Gammaropsis_thompsoni.|uce_024_Ischyrocerus_anguipes.|uce_024_Jassa_carltoni.|uce_024_Jassa_marmorata.|uce_024_Laticorophium_baconi.|uce_024_Metacaprella_anomala.|uce_024_Microjassa_litotes.|uce_024_Monocorophium_acherusicum.|uce_024_Monocorophium_insidiosum.|uce_024_Neoxenodice_spp_1.|uce_024_Neoxenodice_spp_2.|uce_024_Podocerus_septumcarinatus.|uce_024_Podocerus_spp.|uce_024_Sunamphitoe_spp_1.|uce_024_Sunamphitoe_spp_2.|uce_024_Tritella_laevis.|uce_025_Parhyale_hawaiiensis.|uce_034_Podocerus_septumcarinatus.|uce_055_Cheirimedeia_zotea.|uce_055_Monocorophium_acherusicum.|uce_055_Podocerus_septumcarinatus.|uce_055_Sunamphitoe_spp_1.|uce_068_Dulichia_spp.|uce_070_Armadillidium_vulgare.|uce_070_Eusirus_giganteus.|uce_070_Paragammaropsis_spp.|uce_070_Talitrus_saltador.|uce_099_Hirondellea_gigas."

for file in *.stitched_exons.fasta; do
  awk -v pat="$patterns" '/^>/{keep = ($0 !~ pat)} keep' "$file" > tmp && mv tmp "$file"
done

#remove empty files
mkdir -p empty
find . -maxdepth 1 -type f -name "*.fasta" -size 0 -exec mv {} empty/ \;


```
---

### 4.6 Convert stitched exons to PHYLUCE format

Another nice thing about this pipeline is that it bridges the gap between aTRAM and PHYLUCE.

Before doing anything, we need to edit the taxa names that are found in both transcriptome and target capture data so that we can keep them as unique in downstream analyses. In our case, this is Ischyrocerus_anguipes. We also have duplicates of Cerapus_spp and Monocorophium_acherusicum, but we will only keep one set of these before aligning (see below).

```bash

find /bwdata3/bcummings/COROPHIOID/11-TARGETCAPTURE/02-Contig_Assembly_aTRAM/reciprocal_besthit/seq_clean/ -type f -exec sed -i 's/Ischyrocerus_anguipes/Ischyrocerus_anguipes_2/g' {} +

find /bwdata3/bcummings/COROPHIOID/11-TARGETCAPTURE/02-Contig_Assembly_aTRAM/reciprocal_besthit/seq_clean/ -type f -exec sed -i 's/Cerapus_spp/Cerapus_spp_2/g' {} +

find /bwdata3/bcummings/COROPHIOID/11-TARGETCAPTURE/02-Contig_Assembly_aTRAM/reciprocal_besthit/seq_clean/ -type f -exec sed -i 's/Monocorophium_acherusicum/Monocorophium_acherusicum_2/g' {} +

find /bwdata3/bcummings/COROPHIOID/11-TARGETCAPTURE/02-Contig_Assembly_aTRAM/reciprocal_besthit/seq_clean/ -type f -exec sed -i 's/Paragammaropsis_spp/Paragammaropsis_spp_2/g' {} +



find /bwdata3/bcummings/COROPHIOID/12-TRANSCRIPTOME_HARVESTING/02-Contig_Assembly_aTRAM/reciprocal_besthit/seq_clean/ -type f -exec sed -i 's/Ischyrocerus_anguipes/Ischyrocerus_anguipes_1/g' {} +

find /bwdata3/bcummings/COROPHIOID/12-TRANSCRIPTOME_HARVESTING/02-Contig_Assembly_aTRAM/reciprocal_besthit/seq_clean/ -type f -exec sed -i 's/Cerapus_spp/Cerapus_spp_1/g' {} +

find /bwdata3/bcummings/COROPHIOID/12-TRANSCRIPTOME_HARVESTING/02-Contig_Assembly_aTRAM/reciprocal_besthit/seq_clean/ -type f -exec sed -i 's/Monocorophium_acherusicum/Monocorophium_acherusicum_1/g' {} +

find /bwdata3/bcummings/COROPHIOID/12-TRANSCRIPTOME_HARVESTING/02-Contig_Assembly_aTRAM/reciprocal_besthit/seq_clean/ -type f -exec sed -i 's/Paragammaropsis_spp/Paragammaropsis_spp_1/g' {} +


```

We will then use custom Python scripts by Barrow et al 2019 to reformat aTRAM-assembled sequences for input into the PHYLUCE pipeline. PHYLUCE can then used to summarize locus information for each individual.

```bash
#TARGET CAPTURE UCE DATA
mkdir -p /bwdata3/bcummings/COROPHIOID/11-TARGETCAPTURE/03-Convert_to_Phyluce

cp /bwdata3/bcummings/COROPHIOID/11-TARGETCAPTURE/02-Contig_Assembly_aTRAM/reciprocal_besthit/seq_clean/*stitched_exons.fasta /bwdata3/bcummings/COROPHIOID/11-TARGETCAPTURE/03-Convert_to_Phyluce/

cd /bwdata3/bcummings/COROPHIOID/11-TARGETCAPTURE/03-Convert_to_Phyluce

#remove the underscore between the uce and uce number
for file in uce_*.stitched_exons.fasta; do
    newname=$(echo "$file" | sed 's/uce_\(0*[0-9]*\)/uce\1/')
    mv "$file" "$newname"
done

python /bwdata3/bcummings/SCRIPTS/ConvertATRAMtoPHYLUCE.py

mkdir -p /bwdata3/bcummings/COROPHIOID/11-TARGETCAPTURE/03-Convert_to_Phyluce/to_phyluce

mv *-phyluce.fasta to_phyluce

cd to_phyluce

cat *-phyluce.fasta > atram_targetcapture.fasta

#We have to also remove the second "_uce_###" part in the headers of this file. Otherwise, Phyluce will explode the combined fasta into individual files for each taxon-UCE, rather than for each taxon.
sed -i 's/\(_uce_[0-9]\{3\}\)//' atram_targetcapture.fasta


### USE PHYLUCE PIPELINE TO EXPLODE FASTAS AND SUMMARIZE

mkdir -p /bwdata3/bcummings/COROPHIOID/11-TARGETCAPTURE/04-Phyluce_explode

cd /bwdata3/bcummings/COROPHIOID/11-TARGETCAPTURE/04-Phyluce_explode

micromamba activate /bwdata3/auehling/00-MICROMAMBA/phyluce-1.7.3

# Explode the monolithic FASTA by taxon
phyluce_assembly_explode_get_fastas_file \
    --input /bwdata3/bcummings/COROPHIOID/11-TARGETCAPTURE/03-Convert_to_Phyluce/to_phyluce/atram_targetcapture.fasta \
    --output individual_fastas \
    --by-taxon


#Summarize
for i in individual_fastas/*.fasta; do
    phyluce_assembly_get_fasta_lengths --input "$i" --csv
done > fasta_lengths_targetcapture.csv &



#TRANSCRIPTOME UCE DATA
mkdir -p /bwdata3/bcummings/COROPHIOID/12-TRANSCRIPTOME_HARVESTING/03-Convert_to_Phyluce

cp /bwdata3/bcummings/COROPHIOID/12-TRANSCRIPTOME_HARVESTING/02-Contig_Assembly_aTRAM/reciprocal_besthit/seq_clean/*stitched_exons.fasta /bwdata3/bcummings/COROPHIOID/12-TRANSCRIPTOME_HARVESTING/03-Convert_to_Phyluce/

cd /bwdata3/bcummings/COROPHIOID/12-TRANSCRIPTOME_HARVESTING/03-Convert_to_Phyluce

#remove the underscore between the uce and uce number
for file in uce_*.stitched_exons.fasta; do
    newname=$(echo "$file" | sed 's/uce_\(0*[0-9]*\)/uce\1/')
    mv "$file" "$newname"
done

python /bwdata3/bcummings/SCRIPTS/ConvertATRAMtoPHYLUCE.py

mkdir -p /bwdata3/bcummings/COROPHIOID/12-TRANSCRIPTOME_HARVESTING/03-Convert_to_Phyluce/to_phyluce

mv *-phyluce.fasta to_phyluce

cd to_phyluce

cat *-phyluce.fasta > atram_transcriptome.fasta

#Let's remove the second "_uce_###" part in the headers of this file. Otherwise, Phyluce will explode the combined fasta into individual files for each taxon-UCE, rather than for each taxon. Also, let's remove everything after the "|uce-###" part to be consistent with the target capture header format.
sed -i 's/\(_uce_[0-9]\{3\}\)//' atram_transcriptome.fasta

### USE PHYLUCE PIPELINE TO EXPLODE FASTAS AND SUMMARIZE

mkdir -p /bwdata3/bcummings/COROPHIOID/12-TRANSCRIPTOME_HARVESTING/04-Phyluce_explode

cd /bwdata3/bcummings/COROPHIOID/12-TRANSCRIPTOME_HARVESTING/04-Phyluce_explode

micromamba activate /bwdata3/jfryan/00-MICROMAMBA/phyluce-1.7.3

# Explode the monolithic FASTA by taxon
phyluce_assembly_explode_get_fastas_file \
    --input /bwdata3/bcummings/COROPHIOID/12-TRANSCRIPTOME_HARVESTING/03-Convert_to_Phyluce/to_phyluce/atram_transcriptome.fasta \
    --output individual_fastas \
    --by-taxon

for i in individual_fastas/*.fasta; do
    phyluce_assembly_get_fasta_lengths --input "$i" --csv
done > fasta_lengths_transcriptome.csv &


```

Look through the output to get an idea of your UCE recovery. We will consider samples with at least 20% recovery to be successful and generate alignments including only those individuals.

Before we proceed with filtering out these taxa though, we might be able to add extra UCE that was missed by aTRAM by using PHYLUCE. We will repeat the assembly and UCE harvesting steps with PHYLUCE now before proceeding with filtering by UCE recovery.

---

### 4.7 Additional Assembly with Phyluce

We will now re-assemble the data with Phyluce instead of aTRAM to see if we can find any additional UCE.

#### 4.7.1 *Format directory*

The assembly program expects the input to be a certain way. Re-format the input directory using the code below:

```bash
mkdir -p /bwdata3/bcummings/COROPHIOID/13-PHYLUCE/01-Phyluce_input

cd /bwdata3/bcummings/COROPHIOID/13-PHYLUCE/01-Phyluce_input

src_dir=/bwdata3/bcummings/COROPHIOID/11-TARGETCAPTURE/01-Trimming/01-TRIMMOMATIC
dst_dir=/bwdata3/bcummings/COROPHIOID/13-PHYLUCE/01-Phyluce_input

mkdir -p "$dst_dir"

for f in "$src_dir"/*.{fastq.gz,err,out,fq}; do
    [ -e "$f" ] || continue   # skip if no matches
    base=$(basename "$f")
    d=$(echo "$base" | sed -E 's/[-_.](READ[12]|unp[12])?(\.fastq\.gz)$//')
    mkdir -p "$dst_dir/$d"
    mv "$f" "$dst_dir/$d"/
done
```

#### 4.7.2 *Assembly configuration*

Create a configuration file ```assembly.conf``` which lists the samples to be assembled and the paths to the respective clean reads.

```conf
[samples]
Amphideutopus_oculatus:/bwdata3/bcummings/COROPHIOID/13-PHYLUCE/01-Phyluce_input/Amphideutopus_oculatus/
Ampithoe_lacertosa:/bwdata3/bcummings/COROPHIOID/13-PHYLUCE/01-Phyluce_input/Ampithoe_lacertosa/
Aoroides_spp:/bwdata3/bcummings/COROPHIOID/13-PHYLUCE/01-Phyluce_input/Aoroides_spp/
Cerapus_spp:/bwdata3/bcummings/COROPHIOID/13-PHYLUCE/01-Phyluce_input/Cerapus_spp/
Chevaliidae_spp:/bwdata3/bcummings/COROPHIOID/13-PHYLUCE/01-Phyluce_input/Chevaliidae_spp/
Cyamus_boopis:/bwdata3/bcummings/COROPHIOID/13-PHYLUCE/01-Phyluce_input/Cyamus_boopis/
Cyamus_erraticus:/bwdata3/bcummings/COROPHIOID/13-PHYLUCE/01-Phyluce_input/Cyamus_erraticus/
Cyamus_scammoni:/bwdata3/bcummings/COROPHIOID/13-PHYLUCE/01-Phyluce_input/Cyamus_scammoni/
Dyopedos_arcticus:/bwdata3/bcummings/COROPHIOID/13-PHYLUCE/01-Phyluce_input/Dyopedos_arcticus/
Ischyrocerus_anguipes:/bwdata3/bcummings/COROPHIOID/13-PHYLUCE/01-Phyluce_input/Ischyrocerus_anguipes/
Latigammaropsis_spp:/bwdata3/bcummings/COROPHIOID/13-PHYLUCE/01-Phyluce_input/Latigammaropsis_spp/
Microprotopus_raneyi:/bwdata3/bcummings/COROPHIOID/13-PHYLUCE/01-Phyluce_input/Microprotopus_raneyi/
Monocorophium_acherusicum:/bwdata3/bcummings/COROPHIOID/13-PHYLUCE/01-Phyluce_input/Monocorophium_acherusicum/
Paragammaropsis_spp:/bwdata3/bcummings/COROPHIOID/13-PHYLUCE/01-Phyluce_input/Paragammaropsis_spp/
Plesiolembos_rectangulatus:/bwdata3/bcummings/COROPHIOID/13-PHYLUCE/01-Phyluce_input/Plesiolembos_rectangulatus/
Podocerus_cristatus_1:/bwdata3/bcummings/COROPHIOID/13-PHYLUCE/01-Phyluce_input/Podocerus_cristatus_1/
Podocerus_cristatus_2:/bwdata3/bcummings/COROPHIOID/13-PHYLUCE/01-Phyluce_input/Podocerus_cristatus_2/
Protomedeia_prudens:/bwdata3/bcummings/COROPHIOID/13-PHYLUCE/01-Phyluce_input/Protomedeia_prudens/
Pseudampithoides_incurvaria:/bwdata3/bcummings/COROPHIOID/13-PHYLUCE/01-Phyluce_input/Pseudampithoides_incurvaria/
Tropichelura_spp_1:/bwdata3/bcummings/COROPHIOID/13-PHYLUCE/01-Phyluce_input/Tropichelura_spp_1/
Tropichelura_spp_2:/bwdata3/bcummings/COROPHIOID/13-PHYLUCE/01-Phyluce_input/Tropichelura_spp_2/
```

#### 4.7.3 *Assemble using SPAdes*

We have the choice of using [Velvet](https://github.com/dzerbino/velvet), [ABySS](https://www.bcgsc.ca/resources/software/abyss), or [SPAdes](https://ablab.github.io/spades/) in Phyluce to assemble the data. We will use SPAdes since it's easiest. This program will likely take a few days to complete.

```bash

on  nzinga:
micromamba activate /bwdata3/jfryan/00-MICROMAMBA/phyluce-1.7.3
OR
micromamaba activate /bwdata3/auehling/00-MICROMAMBA/phyluce-1.7.3


screen -S phyluce

mkdir -p /bwdata3/bcummings/COROPHIOID/13-PHYLUCE/02-Contig_Assembly_relaxed

cd /bwdata3/bcummings/COROPHIOID/13-PHYLUCE/02-Contig_Assembly_relaxed

phyluce_assembly_assemblo_spades --conf assembly.conf --output spades-assemblies  --cores 80 --memory 700

```

#### 4.7.4 *Assembly quality control*

We will re-run the ```phyluce_assembly_get_fastq_lengths``` program on the contigs to get an idea of how well the assembly worked. Output will be comma-separated text corresponding to the following columns: filename, num_reads, total_bp, avg_len, stderr_len, min_len, max_len, median_len, num_contigs_gt_1kb. Copy and paste the results into a .csv Excel file and save for future reference.

```bash
# in nzinga:
micromamba activate /bwdata3/jfryan/00-MICROMAMBA/phyluce-1.7.3

cd /bwdata3/bcummings/COROPHIOID/13-PHYLUCE/02-Contig_Assembly_relaxed/spades-assemblies/contigs/

for i in *.fasta; do echo "Processing $i"; phyluce_assembly_get_fasta_lengths --input "$i" --csv >> phyluce_assembly_get_fastq_lengths_output.csv; done

mv phyluce_assembly_get_fastq_lengths_output.csv ../..

```

Rename taxa which are duplicates of transcriptome taxa to avoid confusion later on
```bash
cd /bwdata3/bcummings/COROPHIOID/13-PHYLUCE/02-Contig_Assembly_relaxed/spades-assemblies/contigs

mv Cerapus_spp.contigs.fasta Cerapus_spp_2.contigs.fasta
mv Monocorophium_acherusicum.contigs.fasta Monocorophium_acherusicum_2.contigs.fasta
mv Paragammaropsis_spp.contigs.fasta Paragammaropsis_spp_2.contigs.fasta
mv Ischyrocerus_anguipes.contigs.fasta Ischyrocerus_anguipes_2.contigs.fasta
```

#### 4.7.5 *Find target UCE data*

Now we can filter through the assemblies to figure out which are UCE loci and which are not. We will use the probe set and the ```phyluce_assembly_match_contigs_to_probes``` program.

```bash
micromamba activate /bwdata3/jfryan/00-MICROMAMBA/phyluce-1.7.3

cd /bwdata3/bcummings/COROPHIOID/13-PHYLUCE/02-Contig_Assembly_relaxed

cp -r /bwdata3/bcummings/COROPHIOID/11-TARGETCAPTURE/probes_renamed.fasta .

phyluce_assembly_match_contigs_to_probes \
--contigs spades-assemblies/contigs \
--probes probes_renamed.fasta \
--output uce-search-results
```

There will be an sqlite database in the output folder ```uce-search-results```. The ```probe.matches.sqlite``` database contains two tables which will help us generate a data matrix configuration file in Section 3.6.2. The ```match_map``` table is crucial for associating taxon names with contigs which have been arbitrarily named by the assembly program. This ensures correct taxonomic assignment of contigs. The ```matches``` table in the database tracks which contigs match specific UCE loci across taxa. This ensures correct identification of UCE loci across taxa.

To get a better idea of what is going on, you can explore the database and these tables using the following commands:

```bash
cd [path_to_phyluce_output_folder]/uce-search-results

# Enter database:
sqlite3 probe.matches.sqlite

# It’s often easier to change some defaults for better viewing:
.mode columns
.headers on
.nullvalue .

# To see which tables the database contains:
.tables

# To look at the contents of the "matches" table (i.e., data that would be used in a incomplete matrix in Section 3.5.2):
SELECT * FROM matches;


# To look at the contents of the "matches" table and see only those loci that enriched in all species (i.e., data that would be used in a complete matrix in Section 3.5.2):
SELECT * FROM matches WHERE Amp_lac = 1 AND Cer_sp1 = 1 AND Che_spp = 1 AND Cya_boo = 1 AND Cya_err = 1 AND Cya_sca = 1 AND Dyo_arc = 1 AND Isc_an2 = 1 AND Kam_spp = 1 AND Lat_spp = 1 AND Mic_spp = 1 AND Mon_ac1 = 1 AND Par_spp = 1 AND Ple_rec = 1 AND Pod_cr1 = 1 AND Pod_cr2 = 1 AND Pro_pru = 1 AND Pse_inc = 1 AND Tro_sp1 = 1 AND Tro_sp2 = 1;

# To see which which contigs match which UCE loci and contig orientation:
SELECT * FROM match_map;

```

>**Note:** SQLite and SQL are two distinct concepts in the realm of database management. The main difference between SQLite and SQL is that SQL is a language used for querying relational databases, while SQLite is a database management system that uses SQL.
>- SQL, or Structured Query Language, is a standard language for managing relational databases, used to access, create, and manage databases. It is a query language used with databases.
>- SQLite is a software library that provides a relational database management system, designed to be self-contained, serverless, and zero-configuration. It is a portable database that can be extended in any programming language used to access the database.

To export UCE recovery results as a .csv:

```bash

cd uce-search-results

sqlite3 -header -csv probe.matches.sqlite 'SELECT * FROM matches;' > ../phyluce_uce_matches.csv
```

#### 4.7.6 *Find target UCE data in transcriptomes*

We will also use Phyluce as an additional way to retrieve the corresponding UCE loci from our transcriptomes. We will use the method for harvesting from genomes in the Phyluce Tutorial III (https://phyluce.readthedocs.io/en/latest/tutorials/tutorial-3.html).

First, we need to reformat the orthologs to fit the format that phyluce expects. We will run custom perl script ```extract_species_sequences_phyluce.pl``` to extract orthologs by species name and remove symbols which confuse phyluce. Then we will run custom perl script ```rename_orthologs.pl`` to rename headers with unique node IDs.

```bash

mkdir -p /bwdata3/bcummings/COROPHIOID/13-PHYLUCE/03-Transcriptomes/input
mkdir -p /bwdata3/bcummings/COROPHIOID/13-PHYLUCE/03-Transcriptomes/input_reformatted

cd /bwdata3/bcummings/COROPHIOID/13-PHYLUCE/03-Transcriptomes/input

cp -r /bwdata3/bcummings/COROPHIOID/06-PAL2NAL/mintaxa75%/03-P2N/*.fa .

cd ..
cd input_reformatted

chmod +x /bwdata3/bcummings/SCRIPTS/extract_species_sequences_phyluce.pl
chmod +x /bwdata3/bcummings/SCRIPTS/rename_orthologs.pl

perl /bwdata3/bcummings/SCRIPTS/extract_species_sequences_phyluce.pl ../input
perl /bwdata3/bcummings/SCRIPTS/rename_orthologs.pl .
```

Make a separate directory for each transcriptome and copy transcriptomes into their respective directories.

```bash
mkdir -p /bwdata3/bcummings/COROPHIOID/13-PHYLUCE/03-Transcriptomes/transcriptome_dir

cd /bwdata3/bcummings/COROPHIOID/13-PHYLUCE/03-Transcriptomes/transcriptome_dir

for file in ../input_reformatted/*; do [ -f "$file" ] && folder_name=$(basename "$file" | cut -d'.' -f1) && mkdir -p "$folder_name" && cp "$file" "$folder_name/" || echo "Failed to copy $file"; done


```

Convert each fasta file to 2bit files such as below:

```bash
cd /bwdata3/bcummings/COROPHIOID/13-PHYLUCE/03-Transcriptomes/transcriptome_dir

for folder in *; do if [ -d "$folder" ]; then echo "Processing $folder..."; faToTwoBit "$folder/$folder.orthologs.fasta" "$folder/$folder.2bit" && twoBitInfo "$folder/$folder.2bit" "$folder/sizes.tab" && head -n 5 "$folder/sizes.tab"; fi; done

# this is the same thing as running this manually:
faToTwoBit Aby_dis/Aby_dis.orthologs.fasta Aby_dis/Aby_dis.2bit
twoBitInfo Aby_dis/Aby_dis.2bit Aby_dis/sizes.tab
head -n 5 Aby_dis/sizes.tab

faToTwoBit Ali_gig/Ali_gig.orthologs.fasta Ali_gig/Ali_gig.2bit
twoBitInfo Ali_gig/Ali_gig.2bit Ali_gig/sizes.tab
head -n 5 Ali_gig/sizes.tab

#...etc.

```

Copy your probe set into the same directory as the transcriptome folders.

```bash
cd /bwdata3/bcummings/COROPHIOID/13-PHYLUCE/03-Transcriptomes/transcriptome_dir

cp /bwdata3/bcummings/COROPHIOID/11-TARGETCAPTURE/probes_renamed.fasta .
```

Align the probes to the transcriptomes. The program that we are going to run assumes that each 2bit genome file is in it’s own directory (which we have ensured, above).

```bash
micromamba activate /bwdata3/jfryan/00-MICROMAMBA/phyluce-1.7.3

phyluce_probe_run_multiple_lastzs_sqlite --db tutorial3.sqlite --output tutorial3-transcriptome-lastz --scaffoldlist Aby_dis  Ase_hil  Che_zot  Dia_goe  Gam_tho  Hya_azt  Jas_car  Met_ano  Neo_awa  Orc_gri  Pho_tom  Sun_sp2  Tri_lae  Ali_gig  Cap_irr  Cyc_gig  Dul_spp  Glo_spp  Hyp_spp  Jas_mar  Mic_lit  Neo_sp1  Par_haw  Pla_hal  Sca_ste  Tal_sal  Zeu_ezo  Aps_spp  Cap_lae  Cym_exi  Eus_gig  Gra_jap  Ido_bal  Lat_bac  Mon_ach  Neo_sp2  Par_spp  Pod_sep  Sco_sch  Tan_kom  Arm_vul  Cer_spp  Deu_cal  Gam_lac  Hir_gig  Isc_ang  Lep_spp  Mon_ins  Nip_hra  Pho_con  Pod_spp  Sun_sp1  Tig_cal --genome-base-path ./ --probefile probes_renamed.fasta --cores 12
```

We now need to create a configuration file ```transcriptomes.conf``` that tells the Phyluce where to find each transcriptome it will be harvesting from. It should look something like this:

```
[scaffolds]
Aby_dis:/bwdata3/bcummings/COROPHIOID/13-PHYLUCE/03-Transcriptomes/transcriptome_dir/Aby_dis/Aby_dis.2bit
Ali_gig:/bwdata3/bcummings/COROPHIOID/13-PHYLUCE/03-Transcriptomes/transcriptome_dir/Ali_gig/Ali_gig.2bit
#...etc.

```

Now we can extract the loci identified during the search from each respective transcriptome sequence plus some sequence flanking each locus (at a distance you can specify).

```bash
micromamba activate /bwdata3/jfryan/00-MICROMAMBA/phyluce-1.7.3

cd /bwdata3/bcummings/COROPHIOID/13-PHYLUCE/03-Transcriptomes/transcriptome_dir

phyluce_probe_slice_sequence_from_genomes --lastz tutorial3-transcriptome-lastz --conf transcriptomes.conf --flank 500 --name-pattern "probes_renamed.fasta_v_{}.lastz.clean" --output output
```

We will rename these files and deflines within the files to be consistent with the format other assembled contigs above and to keep track of their origin.

```bash
cd /bwdata3/bcummings/COROPHIOID/13-PHYLUCE/03-Transcriptomes/transcriptome_dir

cp -r output output_renamed
cd output_renamed

#rename files
bash -c 'shopt -s nullglob; declare -A m=(
[aby_dis]=Abyssorchomene_distinctus
[cap_irr]=Caprella_irregularis
[cym_exi]=Cymothoa_exigua
[gam_lac]=Gammarus_lacustris
[hya_azt]=Hyalella_azteca
[jas_mar]=Jassa_marmorata
[mon_ach]=Monocorophium_acherusicum_1
[nip_hra]=Niphargus_hrabei
[pho_tom]=Phoxokalliapseudes_tomiokaensis
[sco_sch]=Scopelocheirus_schellenbergi
[tig_cal]=Tigriopus_californicus
[ali_gig]=Alicella_gigantea
[cap_lae]=Caprella_laeviscula
[deu_cal]=Deutella_californica
[gam_tho]=Gammaropsis_thompsoni
[hyp_spp]=Hyperia_spp
[lat_bac]=Laticorophium_baconi
[mon_ins]=Monocorophium_insidiosum
[orc_gri]=Orchestia_grillus
[pla_hal]=Platorchestia_hallaensis
[sun_sp1]=Sunamphitoe_spp_1
[tri_lae]=Tritella_laevis
[aps_spp]=Apseudomorpha_spp
[cer_spp]=Cerapus_spp_1
[dia_goe]=Diastylopsis_goekei
[glo_spp]=Globosolembos_spp
[ido_bal]=Idotea_balthica
[lep_spp]=Leptochelia_spp
[neo_awa]=Neomysis_awatschensis
[par_haw]=Parhyale_hawaiiensis
[pod_sep]=Podocerus_septumcarinatus
[sun_sp2]=Sunamphitoe_spp_2
[zeu_ezo]=Zeuxo_ezoensis
[arm_vul]=Armadillidium_vulgare
[che_zot]=Cheirimedeia_zotea
[dul_spp]=Dulichia_spp
[gra_jap]=Grandidierella_japonica
[isc_ang]=Ischyrocerus_anguipes_1
[met_ano]=Metacaprella_anomala
[neo_sp1]=Neoxenodice_spp_1
[par_spp]=Paragammaropsis_spp_1
[pod_spp]=Podocerus_spp
[tal_sal]=Talitrus_saltador
[ase_hil]=Asellus_hilgendorfii
[cyc_gig]=Cyclaspis_gigas
[eus_gig]=Eusirus_giganteus
[hir_gig]=Hirondellea_gigas
[jas_car]=Jassa_carltoni
[mic_lit]=Microjassa_litotes
[neo_sp2]=Neoxenodice_spp_2
[pho_con]=Photis_conchicola
[sca_ste]=Scalpellum_stearnsi
[tan_kom]=Tanaella_kommritzia
); for f in *.fasta; do k=${f%.fasta}; if [[ ${m[$k]+_} ]]; then mv -n -- "$f" "${m[$k]}.contigs.fasta"; else echo "Skipping (no mapping): $f"; fi; done'

#rename deflines
for f in *.fasta; do
  awk -F'|' '/^>/{print $1; next} {print}' "$f" > "$f.tmp" && mv "$f.tmp" "$f"
done


```

We can filter through the "assemblies" to figure out which are UCE loci and which are not by using the probe set and the ```phyluce_assembly_match_contigs_to_probes``` program.

```bash
micromamba activate /bwdata3/jfryan/00-MICROMAMBA/phyluce-1.7.3

cd /bwdata3/bcummings/COROPHIOID/13-PHYLUCE/03-Transcriptomes/transcriptome_dir

cp -r /bwdata3/bcummings/COROPHIOID/13-PHYLUCE/02-Contig_Assembly_relaxed/probes_renamed.fasta .

phyluce_assembly_match_contigs_to_probes \
--contigs output_renamed \
--probes probes_renamed.fasta \
--output uce-search-results
```

To export UCE recovery results as a .csv:

```bash
cd uce-search-results

sqlite3 -header -csv probe.matches.sqlite 'SELECT * FROM matches;' > ../phyluce_uce_matches.csv
```

#### 4.7.7 *Extract target UCE data*

The easiest way for you to use the extracted sequences is to basically pretend like they are “newly assembled contigs” and add them to the target capture database above.

We need to generate a data matrix configuration file that will contain our taxa and UCE loci that will be extracted. First, we will create this directory.

```bash
mkdir -p /bwdata3/bcummings/COROPHIOID/13-PHYLUCE/04-UCE_extraction
```

Then we will add a taxon-configuration file "taxon-set.conf" which denotes the taxa from each dataset. The target capture taxa will be listed without an asterisk, and the transcriptome taxa will be listed with an asterisk.

```text
[all]
Amphideutopus_oculatus
Ampithoe_lacertosa
Aoroides_spp
...
Abyssorchomene_distinctus*
Alicella_gigantea*
Apseudomorpha_spp*
...
```

Then, you need to pass ```phyluce_assembly_get_match_counts``` the location of both the target capture database (--locus-db) and the transcriptome database (--extend-locus-db).

```bash
cd /bwdata3/bcummings/COROPHIOID/13-PHYLUCE/04-UCE_extraction

micromamba activate /bwdata3/jfryan/00-MICROMAMBA/phyluce-1.7.3

# create the data matrix configuration file
phyluce_assembly_get_match_counts \
    --locus-db /bwdata3/bcummings/COROPHIOID/13-PHYLUCE/02-Contig_Assembly_relaxed/uce-search-results/probe.matches.sqlite \
    --taxon-list-config taxon-set.conf \
    --taxon-group 'dataset_all' \
    --extend-locus-db /bwdata3/bcummings/COROPHIOID/13-PHYLUCE/03-Transcriptomes/transcriptome_dir/uce-search-results/probe.matches.sqlite \
    --output dataset_all.conf \
    --incomplete-matrix
```

We now can extract the appropriate FASTA sequences from each assembly representing the taxon of interest.

```bash
cd /bwdata3/bcummings/COROPHIOID/13-PHYLUCE/04-UCE_extraction

micromamba activate /bwdata3/jfryan/00-MICROMAMBA/phyluce-1.7.3

phyluce_assembly_get_fastas_from_match_counts \
    --contigs /bwdata3/bcummings/COROPHIOID/13-PHYLUCE/02-Contig_Assembly_relaxed/spades-assemblies/contigs/ \
    --locus-db /bwdata3/bcummings/COROPHIOID/13-PHYLUCE/02-Contig_Assembly_relaxed/uce-search-results/probe.matches.sqlite \
    --match-count-output dataset_all.conf \
    --incomplete-matrix dataset_all.incomplete \
    --extend-locus-db /bwdata3/bcummings/COROPHIOID/13-PHYLUCE/03-Transcriptomes/transcriptome_dir/uce-search-results/probe.matches.sqlite \
    --extend-locus-contigs /bwdata3/bcummings/COROPHIOID/13-PHYLUCE/03-Transcriptomes/transcriptome_dir/output_renamed/ \
    --output dataset_all.fasta
```

This outputs a monolithic fasta file. We will now explode this fasta file to get individual statistics for taxa and UCEs.

```bash
cd /bwdata3/bcummings/COROPHIOID/13-PHYLUCE/04-UCE_extraction

micromamba activate /bwdata3/jfryan/00-MICROMAMBA/phyluce-1.7.3

phyluce_assembly_explode_get_fastas_file \
--input dataset_all.fasta \
--output individual_fastas \
--by-taxon

for i in individual_fastas/*.fasta; do
    phyluce_assembly_get_fasta_lengths --input "$i" --csv
done > fasta_lengths_ALL.csv &

```

---

### 4.8 Remove duplicate data

Before we combine the PHYLUCE data with the aTRAM data, we will remove data from duplicate specimens that were used in both target capture and transcriptome sequencing to test recovery (Cerapus_spp and Monocorophium_acherusicum), so that we do not include duplicate samples in phylogenetic analysis. Because the UCE recovery was either similar or better in the transcriptome results, we will use the harvested UCE's from the transcriptomes rather than the target capture samples for these taxa.

```bash

#Do this for aTRAM results
mkdir -p /bwdata3/bcummings/COROPHIOID/11-TARGETCAPTURE/04-Phyluce_explode/individual_fastas_removed

mv /bwdata3/bcummings/COROPHIOID/11-TARGETCAPTURE/04-Phyluce_explode/individual_fastas/Monocorophium-acherusicum-2.unaligned.fasta /bwdata3/bcummings/COROPHIOID/11-TARGETCAPTURE/04-Phyluce_explode/individual_fastas_removed

mv /bwdata3/bcummings/COROPHIOID/11-TARGETCAPTURE/04-Phyluce_explode/individual_fastas/Cerapus-spp-2.unaligned.fasta /bwdata3/bcummings/COROPHIOID/11-TARGETCAPTURE/04-Phyluce_explode/individual_fastas_removed

#Do this for PHYLUCE results
mkdir -p /bwdata3/bcummings/COROPHIOID/13-PHYLUCE/04-UCE_extraction/individual_fastas_removed

mv /bwdata3/bcummings/COROPHIOID/13-PHYLUCE/04-UCE_extraction/individual_fastas/Monocorophium-acherusicum-2.unaligned.fasta /bwdata3/bcummings/COROPHIOID/13-PHYLUCE/04-UCE_extraction/individual_fastas_removed

mv /bwdata3/bcummings/COROPHIOID/13-PHYLUCE/04-UCE_extraction/individual_fastas/Cerapus-spp-2.unaligned.fasta /bwdata3/bcummings/COROPHIOID/13-PHYLUCE/04-UCE_extraction/individual_fastas_removed

```

---

### 4.9 Combine PHYLUCE and aTRAM data

#### 4.9.1 *Target capture data*

We will combine the target capture data from the PHYLUCE and aTRAM fasta files using a custom script ```combine_assemblies.pl```. This script also removes duplicate UCE sequences, making sure to keep the longest one.

```bash
cd /bwdata3/bcummings/COROPHIOID/14-ALIGN/

perl /bwdata3/bcummings/SCRIPTS/combine_assemblies.pl \
  -o all-taxa-targetcapture.fasta \
  -l duplicates.log \
  --key base \
  /bwdata3/bcummings/COROPHIOID/11-TARGETCAPTURE/04-Phyluce_explode/individual_fastas \
  /bwdata3/bcummings/COROPHIOID/13-PHYLUCE/04-UCE_extraction/individual_fastas


perl /bwdata3/bcummings/SCRIPTS/uce_per_taxon_summary.pl all-taxa-targetcapture.fasta > targetcapture_uce_per_taxon.tsv

```

#### 4.9.2 *Transcriptome data*

We will combine the transcriptome data from the PHYLUCE and aTRAM fasta files using the same method.

```bash
cd /bwdata3/bcummings/COROPHIOID/14-ALIGN/

perl /bwdata3/bcummings/SCRIPTS/combine_assemblies.pl \
  -o all-taxa-transcriptome.fasta \
  -l duplicates.log \
  --key base \
  /bwdata3/bcummings/COROPHIOID/12-TRANSCRIPTOME_HARVESTING/04-Phyluce_explode/individual_fastas \
  /bwdata3/bcummings/COROPHIOID/13-PHYLUCE/04-UCE_extraction/individual_fastas

perl /bwdata3/bcummings/SCRIPTS/uce_per_taxon_summary.pl all-taxa-transcriptome.fasta > transcriptome_uce_per_taxon.tsv
```

#### 4.9.3 *Combine target capture and transcriptome data*

Now combine the transcriptome data and target capture data.

```bash
cd /bwdata3/bcummings/COROPHIOID/14-ALIGN/

perl /bwdata3/bcummings/SCRIPTS/combine_assemblies.pl \
  -o all-taxa-combined.fasta \
  -l duplicates.log \
  --key base \
  all-taxa-transcriptome.fasta \
  all-taxa-targetcapture.fasta
```

#### 4.9.4 *Filter combined data*

We filter the combined FASTA file by UCE recovery, retaining target-capture ingroup taxa with >30% of loci recovered, and all transcriptome taxa. Note that this script can keep some taxa unfiltered if you want by adding the "--keep" flag. If we applied the 30% threshold to the transcriptome taxa, it would disproportionately remove outgroups and potentially eliminate key transcriptome taxa that anchor the backbone topology. By applying group-specific thresholds, we preserve essential rooting and constraint taxa while still removing taxa with insufficient UCE representation for reliable phylogenetic inference.

We performed this filtering step using the custom script ```filter_uces_by_recovery.pl```. This script will also produce a list of taxa which were removed called all-taxa-combined-recovery-0.3.removed_taxa.txt. We will use this later to prune our transcriptome backbone tree.

```bash
cd /bwdata3/bcummings/COROPHIOID/14-ALIGN/

perl /bwdata3/bcummings/SCRIPTS/filter_taxa_by_uce_coverage.pl \
    --in all-taxa-combined.fasta \
    --targetcapture "Tropichelura_spp_1,Cyamus_erraticus,Cyamus_boopis,Aoroides_spp,Podocerus_cristatus_1,Podocerus_cristatus_2,Protomedeia_prudens,Ischyrocerus_anguipes_2,Plesiolembos_rectangulatus,Ampithoe_lacertosa,Dyopedos_arcticus,Chevaliidae_spp,Latigammaropsis_spp,Microprotopus_raneyi,Amphideutopus_oculatus,Pseudampithoides_incurvaria,Cyamus_scammoni,Tropichelura_spp_2" \
    --transcriptome "Cerapus_spp_1,Caprella_laeviscula,Monocorophium_insidiosum,Metacaprella_anomala,Caprella_irregularis,Monocorophium_acherusicum_1,Laticorophium_baconi,Ischyrocerus_anguipes_1,Jassa_carltoni,Cheirimedeia_zotea,Jassa_marmorata,Gammaropsis_thompsoni,Neoxenodice_spp_1,Neoxenodice_spp_2,Sunamphitoe_spp_2,Tritella_laevis,Abyssorchomene_distinctus,Sunamphitoe_spp_1,Alicella_gigantea,Grandidierella_japonica,Photis_conchicola,Podocerus_septumcarinatus,Dulichia_spp,Eusirus_giganteus,Microjassa_litotes,Orchestia_grillus,Deutella_californica,Hirondellea_gigas,Hyalella_azteca,Paragammaropsis_spp_1,Parhyale_hawaiiensis,Podocerus_spp,Niphargus_hrabei,Idotea_balthica,Neomysis_awatschensis,Zeuxo_ezoensis,Globosolembos_spp,Scopelocheirus_schellenbergi,Asellus_hilgendorfii,Phoxokalliapseudes_tomiokaensis,Armadillidium_vulgare,Talitrus_saltador,Diastylopsis_goekei,Tanaella_kommritzia,Tigriopus_californicus,Cymothoa_exigua,Hyperia_spp,Leptochelia_spp,Scalpellum_stearnsi,Cyclaspis_gigas" \
    --total 135 \
    --tc_pct 30 \
    --tx_pct 0 \
    --out all-taxa-combined-recovery-0.3_new.fasta

```

#### 4.9.5 *Summarize combined and filtered data*

We summarize UCE recovery and sequence length statistics for the final dataset used in phylogenetic analyses. This step provides per-taxon summaries of the number of retained UCE loci and total sequence lengths following all filtering decisions, and reflects the dataset prior to multiple sequence alignment.

To generate these summaries, we exploded the final combined FASTA file by taxon and calculated basic sequence statistics for each taxon using PHYLUCE utilities.

```bash
cd /bwdata3/bcummings/COROPHIOID/14-ALIGN/

micromamba activate /bwdata3/jfryan/00-MICROMAMBA/phyluce-1.7.3

# Explode final combined FASTA by taxon
phyluce_assembly_explode_get_fastas_file \
  --input all-taxa-combined-recovery-0.3_new.fasta \
  --output individual_fastas_final_new \
  --by-taxon

# Summarize UCE counts and sequence lengths per taxon
for i in individual_fastas_final_new/*.fasta; do
  phyluce_assembly_get_fasta_lengths --input "$i" --csv
done > fasta_lengths_targetcapture_transcriptome_FILTERED_new.csv


#If you want summary statistics for all taxa, including those filtered out...
phyluce_assembly_explode_get_fastas_file \
  --input all-taxa-combined.fasta \
  --output individual_fastas_final_new_prefilter \
  --by-taxon

for i in individual_fastas_final_new_prefilter/*.fasta; do
  phyluce_assembly_get_fasta_lengths --input "$i" --csv
done > fasta_lengths_targetcapture_transcriptome_UNFILTERED_new.csv

```

If you want, you can also download the combined fasta file to your local computer and run the following chunk in RStudio to generate an occupancy matrix. This will give you a visual idea of your data coverage.

```r
#BiocManager::install("Biostrings")

library(Biostrings)
library(tidyverse)
library(fs)

# Path to FASTA directory (unaligned sequences, one file per locus)
fasta_file  <- "C:/Users/bmc82/Documents/UF/PhD_Projects/1-COROPHIOID/Data/Data_NextGenSeq/all-taxa-combined-recovery-0.3_new.fasta"

# Read sequences
seqs <- readDNAStringSet(fasta_file)

# Parse headers like: >uce-045_Parhyale_hawaiiensis |uce-045
parsed <- tibble(
  header = names(seqs),
  locus = str_extract(header, "uce-\\d+"),
  taxon = str_match(header, "uce-\\d+_(.*?)\\s*\\|")[, 2]  # group between underscore and pipe
)

# Drop any NA (in case pattern didn't match)
parsed <- parsed %>% filter(!is.na(locus), !is.na(taxon))

# Build long-format presence table
occupancy_long <- parsed %>%
  distinct(locus, taxon) %>%
  mutate(present = 1)

# Wide matrix
occupancy_matrix <- occupancy_long %>%
  pivot_wider(names_from = taxon, values_from = present, values_fill = 0)

# Plot-compatible long format
occupancy_long_plot <- occupancy_matrix %>%
  pivot_longer(cols = -locus, names_to = "taxon", values_to = "present")

# Plot
ggplot(occupancy_long_plot, aes(x = locus, y = taxon, fill = factor(present))) +
  geom_tile(color = "black", size = 0.1) +
  scale_fill_manual(values = c("0" = "white", "1" = "darkgreen")) +
  labs(x = "Gene partitions", y = "OTUs", fill = "", title = "Occupancy Matrix") +
  theme_minimal(base_size = 10) +
  theme(
    axis.text.x = element_text(angle = 90, hjust = 1, vjust = 0.5, size = 6),
    axis.text.y = element_text(size = 6),
    panel.grid = element_blank(),
    legend.position = "right",
    plot.title = element_text(hjust = 0.5)
  ) +
  coord_fixed(ratio = 1)
```

#### 4.9.6 *Contamination check (optional)*

If desired, at this point you can run Kraken2 on the combined data to double check for contamination issues.

```bash
#Optional Kraken2 pipeline:
mkdir -p /bwdata3/bcummings/COROPHIOID/14-ALIGN/05-kraken2

cd /bwdata3/bcummings/COROPHIOID/14-ALIGN/05-kraken2

#split combined fasta into individual fasta files
mkdir -p individual_fastas_split

awk -v outdir="individual_fastas_split" '
  /^>/ {
    # Get the part after the first underscore, up to a space or pipe
    name = $0
    sub(/^>/, "", name)         # remove leading ">"
    sub(/[| ].*$/, "", name)    # drop everything after space or pipe
    sub(/^[^_]*_/, "", name)    # remove everything up to first "_"
    file = outdir "/" name ".fasta"
  }
  { print >> file }
' /bwdata3/bcummings/COROPHIOID/14-ALIGN/all-taxa-combined-recovery-0.3_new.fasta

#when you activate phyluce, it will also activate kraken2
micromamba activate /bwdata3/auehling/00-MICROMAMBA/phyluce-1.7.3

#The script "kraken_search.sh" will search a specific assembly:
for file in /bwdata3/bcummings/COROPHIOID/14-ALIGN/05-kraken2/individual_fastas_split/*.fasta; do base=$(basename "$file" .fasta); kraken2 --db /bwdata3/auehling/03-BRYO/02-Kraken2/kraken2_db/minikraken2_v2_8GB_201904_UPDATE --threads 8 --output kraken2_output_${base}.txt --report kraken2_report_${base}.txt "$file"; done
```

#### 4.9.7 *Remove problematic taxa (optional)*

For now, we will also remove the problematic taxon Tro_sp1. Even though the quality is good, it is falling out in weird places. This group needs to be re-evaluated in future trees.

```bash
cd /bwdata3/bcummings/COROPHIOID/14-ALIGN/

awk -v RS='>' -v ORS='' '
  NR==1{next}                                # skip leading empty record
  { hdr=$0; sub(/\n.*/,"",hdr) }             # header = first line of the record
  hdr ~ /(Tropichelura_spp_1)/ { next }
  { print ">" $0 }
' all-taxa-combined-recovery-0.3_new.fasta > all-taxa-combined-recovery-0.3-noTrospp_new.fasta


```

---

### 5.0 Align sequences and generate stats

#### 5.0.1 *MAFFT alignment*

We can now produce multiple sequence alignments with MAFFT. We will omit edge-trimming and retain full alignments.

```bash
cd /bwdata3/bcummings/COROPHIOID/14-ALIGN

mkdir logs_all-taxa-combined-recovery-0.3-noTrospp_new

micromamba activate /bwdata3/jfryan/00-MICROMAMBA/phyluce-1.7.3

# Align data with no trimming. We will use more permissive settings like in Barrow et al because we know our data is sparse.
#NOTE: This will take ~2-3 days for 68 taxa
phyluce_align_seqcap_align --input all-taxa-combined-recovery-0.3-noTrospp_new.fasta --output mafft-0.3-all-taxa-combined-recovery-0.3-noTrospp_new --taxa 68 --aligner mafft --cores 80 --incomplete-matrix --log-path logs_all-taxa-combined-recovery-0.3-noTrospp_new --no-trim --proportion 0.3 --threshold 0.3 --max-divergence 0.4

#NOTE: If this command isn't working in your environment, try running the following command first which will make all the standard shell commands available inside your micromamba environment: export PATH=$PATH:/usr/bin:/bin
```
#### 5.0.2 *Determine max number of taxa*

Determine the max number of taxa in any single alignment by using ```phyluce_align_get_align_summary_data```.

```bash
phyluce_align_get_align_summary_data --alignments mafft-0.3-all-taxa-combined-recovery-0.3-noTrospp_new --cores 12 --log-path logs_all-taxa-combined-recovery-0.3-noTrospp_new --show-taxon-counts

```
#### 5.0.3 *Remove locus names and generate occupancy stats*

Now, remove locus names from the sequences and generate occupancy stats.

```bash
cd /bwdata3/bcummings/COROPHIOID/14-ALIGN

micromamba activate /bwdata3/jfryan/00-MICROMAMBA/phyluce-1.7.3

#Remove locus names from sequences
phyluce_align_remove_locus_name_from_files \
    --alignments mafft-0.3-all-taxa-combined-recovery-0.3-noTrospp_new \
    --output mafft-0.3-all-taxa-combined-recovery-0.3-noTrospp-clean_new \
    --cores 12 \
    --log-path logs_all-taxa-combined-recovery-0.3-noTrospp_new

#Generate occupancy stats
phyluce_align_get_informative_sites \
    --alignments mafft-0.3-all-taxa-combined-recovery-0.3-noTrospp-clean_new/ \
    --output informative_stats \
    --log-path logs_all-taxa-combined-recovery-0.3-noTrospp_new

```
---

### 5.1 Filter alignments

We will now apply locus completeness filtering. This will only be done to the target-capture taxa. Incomplete UCE representation in transcriptome-derived taxa is not a concern here because the final phylogeny will be constrained by the original transcriptome tree. This constraint ensures that any transcriptome taxa with sparse UCE recovery are still placed correctly, preventing low-coverage transcriptomes from producing unstable or misleading backbone relationships.

To do this, we will extract only the target-capture taxa using ```phyluce_align_extract_taxa_from_alignments```, apply ```phyluce_align_get_only_loci_with_min_taxa``` to that subset to determine alignments with >50% matrix completeness, and then copy the corresponding alignments from the original alignments.

This ensures that we don't lose more UCE's than necessary. If all taxa (including transcriptomes) are included in the filtering step, loci that are well recovered in target-capture samples may be excluded simply because many transcriptomes contain missing or partial loci. Filtering only on target-capture taxa avoids unnecessarily discarding loci due to the variable recovery in our data.

```bash
cd /bwdata3/bcummings/COROPHIOID/14-ALIGN

micromamba activate /bwdata3/jfryan/00-MICROMAMBA/phyluce-1.7.3

phyluce_align_extract_taxa_from_alignments \
  --alignments mafft-0.3-all-taxa-combined-recovery-0.3-noTrospp-clean_new/ \
  --include Cyamus_erraticus Cyamus_boopis Aoroides_spp Podocerus_cristatus_1 Podocerus_cristatus_2 Protomedeia_prudens Ischyrocerus_anguipes_2 Plesiolembos_rectangulatus Ampithoe_lacertosa Dyopedos_arcticus Chevaliidae_spp Latigammaropsis_spp Microprotopus_raneyi Amphideutopus_oculatus Pseudampithoides_incurvaria  \
  --output alignments_targetcap_new/ \
  --output-format nexus

mkdir logs_alignments_targetcap_new

# determine the max number of taxa in any single subset alignment
phyluce_align_get_align_summary_data --alignments alignments_targetcap_new --cores 12 --log-path logs_alignments_targetcap_new --show-taxon-counts

# Keep alignments with specified level of completeness (% taxa per locus)
# Note that the --taxa flag denotes the the max number of taxa in any single alignment as determined by phyluce_align_get_align_summary_data
phyluce_align_get_only_loci_with_min_taxa \
  --alignments alignments_targetcap_new/ \
  --taxa 15 \
  --percent 0.5 \
  --output alignments_targetcap_min50_new/

# make a list of passing alignments (strip path + extension)
ls alignments_targetcap_min50_new/*.nexus \
  | sed 's#.*/##; s/\.[^.]*$//' > loci_pass_50_new.txt

# copy the corresponding UCE alignments from the original alignment set
mkdir -p mafft-0.3-all-taxa-combined-recovery-0.3-noTrospp-clean-completenesstargetcap-0.5_new

while read L; do
  cp "mafft-0.3-all-taxa-combined-recovery-0.3-noTrospp-clean_new/${L}.nexus" mafft-0.3-all-taxa-combined-recovery-0.3-noTrospp-clean-completenesstargetcap-0.5_new/ 2>/dev/null
done < loci_pass_50_new.txt
```

We will also optionally produce a combined file so we can look at the new occupancy matrix (using the Rmd script above).

```bash
# Directory holding your per-locus alignments (NEXUS)
DIR="mafft-0.3-all-taxa-combined-recovery-0.3-noTrospp-clean-completenesstargetcap-0.5_new"
OUT="mafft-0.3-all-taxa-combined-recovery-0.3-noTrospp-clean-completenesstargetcap-0.5_new.fasta"

: > "$OUT"  # truncate output

for f in "$DIR"/*.nexus; do
  L=$(basename "$f"); L="${L%.*}"   # locus, e.g. uce-002

  awk -v L="$L" '
    BEGIN{
      inmatrix=0; n=0
    }
    # Start of MATRIX block (case-insensitive)
    /^[[:space:]]*[Mm][Aa][Tt][Rr][Ii][Xx][[:space:]]*$/ { inmatrix=1; next }

    # Inside MATRIX: collect taxon + sequence fragments until ;
    inmatrix {
      # End of matrix
      if ($0 ~ /;/) { inmatrix=0; next }
      # skip blank/comment lines
      if ($0 ~ /^[[:space:]]*$/) next
      if ($0 ~ /^[[:space:]]*\[[^]]*\][[:space:]]*$/) next

      line=$0
      # taxon name = first field; rest of line is sequence chunk (spaces removed)
      tax=$1
      sub(/^[[:space:]]*[^\t ]+[ \t]+/, "", line)
      gsub(/[ \t]/, "", line)

      # remember order of first appearance
      if (!(tax in seen)) { seen[tax]=1; n++; ord[n]=tax }
      seq[tax]=seq[tax] line
      next
    }

    END{
      for (i=1; i<=n; i++){
        t=ord[i]
        # If you might have spaces in taxon names, uncomment next line:
        # gsub(/[[:space:]]+/, "_", t)
        printf(">%s_%s |%s\n", L, t, L)
        # wrap sequence at 60 chars (optional)
        s=seq[t]; while (length(s) > 60) { print substr(s,1,60); s=substr(s,61) }
        if (length(s)) print s
      }
    }
  ' "$f" >> "$OUT"

done
```

---

### 5.2 Nucleotide species tree construction

#### 5.2.1 *Format data for tree building*

Copy files to new folder.

```bash
# constraint tree unrooted, w/o Tro_sp1, aTRAM + PHYLUCE data
mkdir -p /bwdata3/bcummings/COROPHIOID/15-SPECIESTREE/mafft-0.3-all-taxa-combined-recovery-0.3-noTrospp-clean-completenesstargetcap-0.5_new/NUC_bestgenetreemodels_new/input_IQTREE/uce_alignments

cp -r /bwdata3/bcummings/COROPHIOID/14-ALIGN/mafft-0.3-all-taxa-combined-recovery-0.3-noTrospp-clean-completenesstargetcap-0.5_new/*.nexus /bwdata3/bcummings/COROPHIOID/15-SPECIESTREE/mafft-0.3-all-taxa-combined-recovery-0.3-noTrospp-clean-completenesstargetcap-0.5_new/NUC_bestgenetreemodels_new/input_IQTREE/uce_alignments

mkdir -p /bwdata3/bcummings/COROPHIOID/15-SPECIESTREE/mafft-0.3-all-taxa-combined-recovery-0.3-noTrospp-clean-completenesstargetcap-0.5_new/NUC_bestgenetreemodels_new/input_IQTREE/og_alignments

cp -r /bwdata3/bcummings/COROPHIOID/07-SPECIESTREE/mintaxa75%/NUC_bestgenetreemodels/input_IQTREE/*.fa /bwdata3/bcummings/COROPHIOID/15-SPECIESTREE/mafft-0.3-all-taxa-combined-recovery-0.3-noTrospp-clean-completenesstargetcap-0.5_new/NUC_bestgenetreemodels_new/input_IQTREE/og_alignments
```

Rename Isc_ang, Cer_spp, Mon_ach, and Par_spp in the og_alignments to be Isc_an1, Cer_sp1, Mon_ac1, and Par_sp1 to match the uce files.

```bash
cd /bwdata3/bcummings/COROPHIOID/15-SPECIESTREE/mafft-0.3-all-taxa-combined-recovery-0.3-noTrospp-clean-completenesstargetcap-0.5_new/NUC_bestgenetreemodels_new/input_IQTREE/og_alignments

for file in *.fa; do
  sed -i 's/\bIsc_ang\b/Isc_an1/g' "$file"
done

for file in *.fa; do
  sed -i 's/\bCer_spp\b/Cer_sp1/g' "$file"
done

for file in *.fa; do
  sed -i 's/\bMon_ach\b/Mon_ac1/g' "$file"
done

for file in *.fa; do
  sed -i 's/\bPar_spp\b/Par_sp1/g' "$file"
done

```

Convert UCE .nexus files to .fa files to match format of orthogroup files

```bash
cd /bwdata3/bcummings/COROPHIOID/15-SPECIESTREE/mafft-0.3-all-taxa-combined-recovery-0.3-noTrospp-clean-completenesstargetcap-0.5_new/NUC_bestgenetreemodels_new/input_IQTREE

perl /bwdata3/bcummings/SCRIPTS/convert_nexus_to_fasta.pl uce_alignments

cd /bwdata3/bcummings/COROPHIOID/15-SPECIESTREE/mafft-0.3-all-taxa-combined-recovery-0.3-noTrospp-clean-completenesstargetcap-0.5_new/NUC_bestgenetreemodels_new/input_IQTREE/uce_alignments

rm -r *.nexus

```

Shorten taxa names to match the format of the taxa in the original transcriptome tree.

```bash
#"shorten_nexus_headers.pl".
cd /bwdata3/bcummings/COROPHIOID/15-SPECIESTREE/mafft-0.3-all-taxa-combined-recovery-0.3-noTrospp-clean-completenesstargetcap-0.5_new/NUC_bestgenetreemodels_new/input_IQTREE/uce_alignments

for file in *.fa; do
  perl /bwdata3/bcummings/SCRIPTS/shorten_headers.pl --input "$file" --output "$file.tmp" && mv "$file.tmp" "$file"
done
```

Filter OG alignments to remove any that overlap with renamed UCEs (based on OG IDs)

First, create and upload a tab-delimited mapping file from the "orthogroup_map" tab of our "probes_working.xlsx" file. Save it as "uce_to_og.tsv".

```text
uce-001	OG0001610
uce-002	OG0001979
uce-003	OG0002010
...
```

Then filter OG alignments.

```bash
cd /bwdata3/bcummings/COROPHIOID/15-SPECIESTREE/mafft-0.3-all-taxa-combined-recovery-0.3-noTrospp-clean-completenesstargetcap-0.5_new/NUC_bestgenetreemodels_new/input_IQTREE

perl /bwdata3/bcummings/SCRIPTS/filter_and_rename_uces.pl \
  --uce uce_alignments/ \
  --og og_alignments/ \
  --mapping uce_to_og.tsv \
  --outdir combined_alignments/

```

#### 5.2.2 *Concatenate and partition data*

Generate concatenated dataset and partition file from cleaned dataset.

We will use a custom script which will track all unique taxa across all loci, for each gene adds ? for missing taxa, and concatenates them in order.

Make sure to check the concatenated data and to ensure filtered taxa are not in the dataset. You can do this using "grep -r "TAX_SPP" concatenated.fasta

```bash
cd /bwdata3/bcummings/COROPHIOID/15-SPECIESTREE/mafft-0.3-all-taxa-combined-recovery-0.3-noTrospp-clean-completenesstargetcap-0.5_new/NUC_bestgenetreemodels_new/input_IQTREE

perl /bwdata3/bcummings/SCRIPTS/merge_and_concatenate_alignments.pl \
  --input combined_alignments/ \
  --output concatenated.fasta \
  --partition partitions.txt

perl /bwdata3/bcummings/SCRIPTS/partition_to_nexus.pl --input=partitions.txt --output=partitions.nex

mkdir -p /bwdata3/bcummings/COROPHIOID/15-SPECIESTREE/mafft-0.3-all-taxa-combined-recovery-0.3-noTrospp-clean-completenesstargetcap-0.5_new/NUC_bestgenetreemodels_new/output_IQTREE

mv partitions.nex partitions.txt concatenated.fasta \
  /bwdata3/bcummings/COROPHIOID/15-SPECIESTREE/mafft-0.3-all-taxa-combined-recovery-0.3-noTrospp-clean-completenesstargetcap-0.5_new/NUC_bestgenetreemodels_new/output_IQTREE

```

#### 5.2.3 *Prepare constraint tree*

Copy the transcriptome constraint tree to the working folder.

```bash
cp /bwdata3/bcummings/COROPHIOID/07-SPECIESTREE/mintaxa75%/NUC_bestgenetreemodels/output_IQTREE/NUC_bestgenetreemodels_min75.treefile /bwdata3/bcummings/COROPHIOID/15-SPECIESTREE/mafft-0.3-all-taxa-combined-recovery-0.3-noTrospp-clean-completenesstargetcap-0.5_new/NUC_bestgenetreemodels_new/output_IQTREE
```

Rename taxa to match the current dataset. Specifically, "Isc_ang", "Cer_spp", "Mon_ach", and "Par_spp" in  constraint tree should be changed to "Isc_an1", "Cer_sp1", "Mon_ac1", and "Par_sp1" to be consistent with the target capture data.

```bash
cd /bwdata3/bcummings/COROPHIOID/15-SPECIESTREE/mafft-0.3-all-taxa-combined-recovery-0.3-noTrospp-clean-completenesstargetcap-0.5_new/NUC_bestgenetreemodels_new/output_IQTREE

sed -E \
  -e 's/\bIsc_ang\b/Isc_an1/g' \
  -e 's/\bCer_spp\b/Cer_sp1/g' \
  -e 's/\bMon_ach\b/Mon_ac1/g' \
  -e 's/\bPar_spp\b/Par_sp1/g' \
  NUC_bestgenetreemodels_min75.treefile > NUC_bestgenetreemodels_min75_renamed.treefile

```

#### 5.2.4 *Build preliminary species tree*

Build quick preliminary tree check to make sure the ingroups and outgroups fall into their respective zones. This will take a few hours.

```bash
iqtree -s concatenated.fasta -st DNA \
  -g NUC_bestgenetreemodels_min75_renamed.treefile \
  -m GTR+F+R4 -n 1 -nt AUTO \
  -pre mafft-0.3-all-taxa-combined-recovery-0.3-noTrospp-clean-completenesstargetcap-0.5_new_TEST
#Check for rooting and catastrophic errors. The actual topology of the ingroups will look wonky but we are looking for BIG errors - like ingroups falling into the outgroups. If outgroups are falling out where they are supposed to, move on to the next tree to get the final topology.

```

#### 5.2.5 *Build constrained species tree*

Build final nucleotide species tree with transcriptome tree as the constraint.

```
#Run IQTREE with constraint tree, allowing IQTREE to deal with the missing data as it wishes. This will take ~1 week.
iqtree -s concatenated.fasta -spp partitions.nex -m MFP+MERGE -st DNA -bb 1000 -alrt 1000 -nt AUTO \
  -g NUC_bestgenetreemodels_min75_renamed.treefile \
  -pre mafft-0.3-all-taxa-combined-recovery-0.3-noTrospp-clean-completenesstargetcap-0.5_new

```

#### 5.2.6 *Build unconstrained species tree*

Now we need to test the constrained tree against an unconstrained tree to see if the constrained tree is worse than just leaving the missing data there.

First, build the unconstrained species tree. This will take LONGER than the tree above (weeks and weeks).

```bash
cd /bwdata3/bcummings/COROPHIOID/15-SPECIESTREE/mafft-0.3-all-taxa-combined-recovery-0.3-noTrospp-clean-completenesstargetcap-0.5_new/NUC_bestgenetreemodels_new/output_IQTREE

#Make a tree with the entire dataset without constraint:
iqtree -s concatenated.fasta -p partitions.nex -m MFP+MERGE -bb 1000 -alrt 1000 -pre mafft-0.3-all-taxa-combined-recovery-0.3-noTrospp-clean-completenesstargetcap-0.5_new_unconstrained

```
Now, test the constrained tree against the unconstrained tree using RELL, KH, SH, and AU tests.

* RELL = bootstrap proportion, a posterior weight (NOT P VALUE) that sums to 1 across trees, ~ more is better
* KH = Kishino-Hasegawa 1989,gives a p-value where significant = bad
* SH = shimodaira-Hasegawa 2000, gives a p-value where significant = bad
* AU test = Shimodaira, 2002, easier to interpret, (-) means reject that tree, (+) means tree is plausible. Significant p-values are still bad.

The AU test is the best measure. If the constrained tree fails the AU test, then don't use it. If the trees are comparable, then you can use the constrained tree for final relationships between taxa knowing that you are basing the "backbone" of the tree on a solid, data-filled matrix.

```

#copy the trees to a new folder, and concatenate
cat mafft-0.3-all-taxa-combined-recovery-0.3-noTrospp-clean-completenesstargetcap-0.5_new.treefile mafft-0.3-all-taxa-combined-recovery-0.3-noTrospp-clean-completenesstargetcap-0.5_new_unconstrained.treefile > cat.treefile

#Now we test the trees to see if they vary a lot in robustness, using RELL, KH, SH, and AU tests to see if any trees get rejected

iqtree -s concatenated.fasta -m MFP+MERGE -z cat.treefile -n 0 -zb 1000 -au

```

---

### 5.3 Amino acid species tree construction

This pipeline constructs an amino acid dataset from both transcriptome-derived and target-capture UCE loci in order to generate an additional species tree based on amino acid data. We will compare the topology of the AA tree with the original NUC tree to verify robustness of inferred evolutionary relationships.

[in progress]

---

## 6. ANCESTRAL STATE RECONSTRUCTION

See Rmd files in GitHub repository.

---

## 8. LITERATURE REFERENCED

Dunn CW, Howison M, Zapata F. 2013. Agalma: an automated phylogenomics workflow. BMC Bioinformatics 14(1): 330. doi:10.1186/1471-2105-14-330

Emms, D. M., & Kelly, S. (2015). OrthoFinder: solving fundamental biases in whole genome comparisons dramatically improves orthogroup inference accuracy. Genome Biology, 16(1), 157.

Kocot, K. M., Citarella, M. R., Moroz, L. L., & Halanych, K. M. (2013). PhyloTreePruner: a phylogenetic tree-based approach for selection of orthologous sequences for phylogenomics. Evolutionary Bioinformatics Online, 9, 429.

Nguyen, L. T., Schmidt, H. A., von Haeseler, A., & Minh, B. Q. (2014). IQ-TREE: a fast and effective stochastic algorithm for estimating maximum-likelihood phylogenies. Molecular Biology and Evolution, 32(1), 268-274.

Suyama, M., Torrents, D., & Bork, P. (2006). PAL2NAL: robust conversion of protein sequence alignments into the corresponding codon alignments. Nucleic Acids Research, 34(suppl_2), W609-W612.

TransDecoder: https://transdecoder.github.io/

Yamada, K. D., Tomii, K., & Katoh, K. (2016). Application of the MAFFT sequence alignment program to large data—reexamination of the usefulness of chained guide trees. Bioinformatics, 32(21), 3246-3251.

[in progress]


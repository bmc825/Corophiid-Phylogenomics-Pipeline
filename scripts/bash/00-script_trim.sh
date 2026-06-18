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

java -jar /usr/local/Trimmomatic-0.39/trimmomatic-0.39.jar PE \
  -threads 50 \
  -phred33 \
  /bwdata3/bcummings/COROPHIOID/00-DATA/Brittany/Cheirimedeia_zotea-BCPD0023/Cheirimedeia_zotea_1.fastq.gz \
  /bwdata3/bcummings/COROPHIOID/00-DATA/Brittany/Cheirimedeia_zotea-BCPD0023/Cheirimedeia_zotea_2.fastq.gz \
  Cheirimedeia_zotea-READ1.fastq.gz \
  Cheirimedeia_zotea.unp1.fq \
  Cheirimedeia_zotea-READ2.fastq.gz \
  Cheirimedeia_zotea.unp2.fq \
  ILLUMINACLIP:/usr/local/Trimmomatic-0.39/adapters/TruSeq3-PE.fa:2:30:10 \
  LEADING:5 \
  TRAILING:5 \
  SLIDINGWINDOW:4:5 \
  MINLEN:25 \
  > Cheirimedeia_zotea.trimmo.out 2> Cheirimedeia_zotea.trimmo.err

java -jar /usr/local/Trimmomatic-0.39/trimmomatic-0.39.jar PE \
  -threads 50 \
  -phred33 \
  /bwdata3/bcummings/COROPHIOID/00-DATA/Brittany/Deutella_californica-BCPD0058/Deutella_californica_1.fastq.gz \
  /bwdata3/bcummings/COROPHIOID/00-DATA/Brittany/Deutella_californica-BCPD0058/Deutella_californica_2.fastq.gz \
  Deutella_californica-READ1.fastq.gz \
  Deutella_californica.unp1.fq \
  Deutella_californica-READ2.fastq.gz \
  Deutella_californica.unp2.fq \
  ILLUMINACLIP:/usr/local/Trimmomatic-0.39/adapters/TruSeq3-PE.fa:2:30:10 \
  LEADING:5 \
  TRAILING:5 \
  SLIDINGWINDOW:4:5 \
  MINLEN:25 \
  > Deutella_californica.trimmo.out 2> Deutella_californica.trimmo.err

java -jar /usr/local/Trimmomatic-0.39/trimmomatic-0.39.jar PE \
  -threads 50 \
  -phred33 \
  /bwdata3/bcummings/COROPHIOID/00-DATA/Brittany/Dulichia_rhabdoplastis-BCPD0140_combined/Dulichia_rhabdoplastis_combined_1.fastq.gz \
  /bwdata3/bcummings/COROPHIOID/00-DATA/Brittany/Dulichia_rhabdoplastis-BCPD0140_combined/Dulichia_rhabdoplastis_combined_2.fastq.gz \
  Dulichia_rhabdoplastis-READ1.fastq.gz \
  Dulichia_rhabdoplastis.unp1.fq \
  Dulichia_rhabdoplastis-READ2.fastq.gz \
  Dulichia_rhabdoplastis.unp2.fq \
  ILLUMINACLIP:/usr/local/Trimmomatic-0.39/adapters/NexteraPE-PE.fa:2:30:10 \
  LEADING:5 \
  TRAILING:5 \
  SLIDINGWINDOW:4:5 \
  MINLEN:25 \
  > Dulichia_rhabdoplastis.trimmo.out 2> Dulichia_rhabdoplastis.trimmo.err

java -jar /usr/local/Trimmomatic-0.39/trimmomatic-0.39.jar PE \
  -threads 50 \
  -phred33 \
  /bwdata3/bcummings/COROPHIOID/00-DATA/Brittany/Gammaropsis_thompsoni-BCPD0161/Gammaropsis_thompsoni_1.fastq.gz \
  /bwdata3/bcummings/COROPHIOID/00-DATA/Brittany/Gammaropsis_thompsoni-BCPD0161/Gammaropsis_thompsoni_2.fastq.gz \
  Gammaropsis_thompsoni-READ1.fastq.gz \
  Gammaropsis_thompsoni.unp1.fq \
  Gammaropsis_thompsoni-READ2.fastq.gz \
  Gammaropsis_thompsoni.unp2.fq \
  ILLUMINACLIP:/usr/local/Trimmomatic-0.39/adapters/NexteraPE-PE.fa:2:30:10 \
  LEADING:5 \
  TRAILING:5 \
  SLIDINGWINDOW:4:5 \
  MINLEN:25 \
  > Gammaropsis_thompsoni.trimmo.out 2> Gammaropsis_thompsoni.trimmo.err

java -jar /usr/local/Trimmomatic-0.39/trimmomatic-0.39.jar PE \
  -threads 50 \
  -phred33 \
  /bwdata3/bcummings/COROPHIOID/00-DATA/Brittany/Globosolembos_spp-BCPD0704/Globosolembos_spp_1.fastq.gz \
  /bwdata3/bcummings/COROPHIOID/00-DATA/Brittany/Globosolembos_spp-BCPD0704/Globosolembos_spp_2.fastq.gz \
  Globosolembos_spp-READ1.fastq.gz \
  Globosolembos_spp.unp1.fq \
  Globosolembos_spp-READ2.fastq.gz \
  Globosolembos_spp.unp2.fq \
  ILLUMINACLIP:/usr/local/Trimmomatic-0.39/adapters/TruSeq3-PE.fa:2:30:10 \
  LEADING:5 \
  TRAILING:5 \
  SLIDINGWINDOW:4:5 \
  MINLEN:25 \
  > Globosolembos_spp.trimmo.out 2> Globosolembos_spp.trimmo.err

java -jar /usr/local/Trimmomatic-0.39/trimmomatic-0.39.jar PE \
  -threads 50 \
  -phred33 \
  /bwdata3/bcummings/COROPHIOID/00-DATA/Brittany/Ischyrocerus_anguipes-BCPD0124/Ischyrocerus_anguipes_1.fastq.gz \
  /bwdata3/bcummings/COROPHIOID/00-DATA/Brittany/Ischyrocerus_anguipes-BCPD0124/Ischyrocerus_anguipes_2.fastq.gz \
  Ischyrocerus_anguipes-READ1.fastq.gz \
  Ischyrocerus_anguipes.unp1.fq \
  Ischyrocerus_anguipes-READ2.fastq.gz \
  Ischyrocerus_anguipes.unp2.fq \
  ILLUMINACLIP:/usr/local/Trimmomatic-0.39/adapters/TruSeq3-PE.fa:2:30:10 \
  LEADING:5 \
  TRAILING:5 \
  SLIDINGWINDOW:4:5 \
  MINLEN:25 \
  > Ischyrocerus_anguipes.trimmo.out 2> Ischyrocerus_anguipes.trimmo.err

java -jar /usr/local/Trimmomatic-0.39/trimmomatic-0.39.jar PE \
  -threads 50 \
  -phred33 \
  /bwdata3/bcummings/COROPHIOID/00-DATA/Brittany/Metacaprella_anomala-BCPD0032/Metacaprella_anomala_1.fastq.gz \
  /bwdata3/bcummings/COROPHIOID/00-DATA/Brittany/Metacaprella_anomala-BCPD0032/Metacaprella_anomala_2.fastq.gz \
  Metacaprella_anomala-READ1.fastq.gz \
  Metacaprella_anomala.unp1.fq \
  Metacaprella_anomala-READ2.fastq.gz \
  Metacaprella_anomala.unp2.fq \
  ILLUMINACLIP:/usr/local/Trimmomatic-0.39/adapters/NexteraPE-PE.fa:2:30:10 \
  LEADING:5 \
  TRAILING:5 \
  SLIDINGWINDOW:4:5 \
  MINLEN:25 \
  > Metacaprella_anomala.trimmo.out 2> Metacaprella_anomala.trimmo.err

java -jar /usr/local/Trimmomatic-0.39/trimmomatic-0.39.jar PE \
  -threads 50 \
  -phred33 \
  /bwdata3/bcummings/COROPHIOID/00-DATA/Brittany/Microjassa_litotes-BCPD0131/Microjassa_litotes_1.fastq.gz \
  /bwdata3/bcummings/COROPHIOID/00-DATA/Brittany/Microjassa_litotes-BCPD0131/Microjassa_litotes_2.fastq.gz \
  Microjassa_litotes-READ1.fastq.gz \
  Microjassa_litotes.unp1.fq \
  Microjassa_litotes-READ2.fastq.gz \
  Microjassa_litotes.unp2.fq \
  ILLUMINACLIP:/usr/local/Trimmomatic-0.39/adapters/TruSeq3-PE.fa:2:30:10 \
  LEADING:5 \
  TRAILING:5 \
  SLIDINGWINDOW:4:5 \
  MINLEN:25 \
  > Microjassa_litotes.trimmo.out 2> Microjassa_litotes.trimmo.err

java -jar /usr/local/Trimmomatic-0.39/trimmomatic-0.39.jar PE \
  -threads 50 \
  -phred33 \
  /bwdata3/bcummings/COROPHIOID/00-DATA/Brittany/Monocorophium_acherusicum-BCPD0174/Monocorophium_acherusicum_1.fastq.gz \
  /bwdata3/bcummings/COROPHIOID/00-DATA/Brittany/Monocorophium_acherusicum-BCPD0174/Monocorophium_acherusicum_2.fastq.gz \
  Monocorophium_acherusicum-READ1.fastq.gz \
  Monocorophium_acherusicum.unp1.fq \
  Monocorophium_acherusicum-READ2.fastq.gz \
  Monocorophium_acherusicum.unp2.fq \
  ILLUMINACLIP:/usr/local/Trimmomatic-0.39/adapters/TruSeq3-PE.fa:2:30:10 \
  LEADING:5 \
  TRAILING:5 \
  SLIDINGWINDOW:4:5 \
  MINLEN:25 \
  > Monocorophium_acherusicum.trimmo.out 2> Monocorophium_acherusicum.trimmo.err

java -jar /usr/local/Trimmomatic-0.39/trimmomatic-0.39.jar PE \
  -threads 50 \
  -phred33 \
  /bwdata3/bcummings/COROPHIOID/00-DATA/Brittany/Monocorophium_insidiosum-BCPD0170/Monocorophium_insidiosum_1.fastq.gz \
  /bwdata3/bcummings/COROPHIOID/00-DATA/Brittany/Monocorophium_insidiosum-BCPD0170/Monocorophium_insidiosum_2.fastq.gz \
  Monocorophium_insidiosum-READ1.fastq.gz \
  Monocorophium_insidiosum.unp1.fq \
  Monocorophium_insidiosum-READ2.fastq.gz \
  Monocorophium_insidiosum.unp2.fq \
  ILLUMINACLIP:/usr/local/Trimmomatic-0.39/adapters/TruSeq3-PE.fa:2:30:10 \
  LEADING:5 \
  TRAILING:5 \
  SLIDINGWINDOW:4:5 \
  MINLEN:25 \
  > Monocorophium_insidiosum.trimmo.out 2> Monocorophium_insidiosum.trimmo.err

java -jar /usr/local/Trimmomatic-0.39/trimmomatic-0.39.jar PE \
  -threads 50 \
  -phred33 \
  /bwdata3/bcummings/COROPHIOID/00-DATA/Brittany/Sunamphitoe_spp_1-BCPD0610/Sunamphitoe_spp_1_1.fastq.gz \
  /bwdata3/bcummings/COROPHIOID/00-DATA/Brittany/Sunamphitoe_spp_1-BCPD0610/Sunamphitoe_spp_1_2.fastq.gz \
  Sunamphitoe_spp_1-READ1.fastq.gz \
  Sunamphitoe_spp_1.unp1.fq \
  Sunamphitoe_spp_1-READ2.fastq.gz \
  Sunamphitoe_spp_1.unp2.fq \
  ILLUMINACLIP:/usr/local/Trimmomatic-0.39/adapters/TruSeq3-PE.fa:2:30:10 \
  LEADING:5 \
  TRAILING:5 \
  SLIDINGWINDOW:4:5 \
  MINLEN:25 \
  > Sunamphitoe_spp_1.trimmo.out 2> Sunamphitoe_spp_1.trimmo.err

java -jar /usr/local/Trimmomatic-0.39/trimmomatic-0.39.jar PE \
  -threads 50 \
  -phred33 \
  /bwdata3/bcummings/COROPHIOID/00-DATA/Brittany/Sunamphitoe_spp_2-BCPD0027/Sunamphitoe_spp_2_1.fastq.gz \
  /bwdata3/bcummings/COROPHIOID/00-DATA/Brittany/Sunamphitoe_spp_2-BCPD0027/Sunamphitoe_spp_2_2.fastq.gz \
  Sunamphitoe_spp_2-READ1.fastq.gz \
  Sunamphitoe_spp_2.unp1.fq \
  Sunamphitoe_spp_2-READ2.fastq.gz \
  Sunamphitoe_spp_2.unp2.fq \
  ILLUMINACLIP:/usr/local/Trimmomatic-0.39/adapters/TruSeq3-PE.fa:2:30:10 \
  LEADING:5 \
  TRAILING:5 \
  SLIDINGWINDOW:4:5 \
  MINLEN:25 \
  > Sunamphitoe_spp_2.trimmo.out 2> Sunamphitoe_spp_2.trimmo.err

java -jar /usr/local/Trimmomatic-0.39/trimmomatic-0.39.jar PE \
  -threads 50 \
  -phred33 \
  /bwdata3/bcummings/COROPHIOID/00-DATA/Brittany/Tritella_laevis-BCPD0402/Tritella_laevis_1.fastq.gz \
  /bwdata3/bcummings/COROPHIOID/00-DATA/Brittany/Tritella_laevis-BCPD0402/Tritella_laevis_2.fastq.gz \
  Tritella_laevis-READ1.fastq.gz \
  Tritella_laevis.unp1.fq \
  Tritella_laevis-READ2.fastq.gz \
  Tritella_laevis.unp2.fq \
  ILLUMINACLIP:/usr/local/Trimmomatic-0.39/adapters/TruSeq3-PE.fa:2:30:10 \
  LEADING:5 \
  TRAILING:5 \
  SLIDINGWINDOW:4:5 \
  MINLEN:25 \
  > Tritella_laevis.trimmo.out 2> Tritella_laevis.trimmo.err

java -jar /usr/local/Trimmomatic-0.39/trimmomatic-0.39.jar PE \
  -threads 50 \
  -phred33 \
  /bwdata3/bcummings/COROPHIOID/00-DATA/Kevin/Neoxenodice_spp_1-KK1921.2C/KK1921-2C_S1_L001_R1_001.fastq.gz \
  /bwdata3/bcummings/COROPHIOID/00-DATA/Kevin/Neoxenodice_spp_1-KK1921.2C/KK1921-2C_S1_L001_R2_001.fastq.gz \
  Neoxenodice_spp_1-READ1.fastq.gz \
  Neoxenodice_spp_1.unp1.fq \
  Neoxenodice_spp_1-READ2.fastq.gz \
  Neoxenodice_spp_1.unp2.fq \
  ILLUMINACLIP:/usr/local/Trimmomatic-0.39/adapters/TruSeq3-PE.fa:2:30:10 \
  LEADING:5 \
  TRAILING:5 \
  SLIDINGWINDOW:4:5 \
  MINLEN:25 \
  > Neoxenodice_spp_1.trimmo.out 2> Neoxenodice_spp_1.trimmo.err

java -jar /usr/local/Trimmomatic-0.39/trimmomatic-0.39.jar PE \
  -threads 50 \
  -phred33 \
  /bwdata3/bcummings/COROPHIOID/00-DATA/Kevin/Neoxenodice_spp_2-KK4785.2R/KK4785-2R_S1_L001_R1_001.fastq.gz \
  /bwdata3/bcummings/COROPHIOID/00-DATA/Kevin/Neoxenodice_spp_2-KK4785.2R/KK4785-2R_S1_L001_R2_001.fastq.gz \
  Neoxenodice_spp_2-READ1.fastq.gz \
  Neoxenodice_spp_2.unp1.fq \
  Neoxenodice_spp_2-READ2.fastq.gz \
  Neoxenodice_spp_2.unp2.fq \
  ILLUMINACLIP:/usr/local/Trimmomatic-0.39/adapters/TruSeq3-PE.fa:2:30:10 \
  LEADING:5 \
  TRAILING:5 \
  SLIDINGWINDOW:4:5 \
  MINLEN:25 \
  > Neoxenodice_spp_2.trimmo.out 2> Neoxenodice_spp_2.trimmo.err

java -jar /usr/local/Trimmomatic-0.39/trimmomatic-0.39.jar PE \
  -threads 50 \
  -phred33 \
  /bwdata3/bcummings/COROPHIOID/00-DATA/Kevin/Paragammaropsis_spp-KK1749.2C/KK1749-2C_R1_001.fastq.gz \
  /bwdata3/bcummings/COROPHIOID/00-DATA/Kevin/Paragammaropsis_spp-KK1749.2C/KK1749-2C_R2_001.fastq.gz \
  Paragammaropsis_spp-READ1.fastq.gz \
  Paragammaropsis_spp.unp1.fq \
  Paragammaropsis_spp-READ2.fastq.gz \
  Paragammaropsis_spp.unp2.fq \
  ILLUMINACLIP:/usr/local/Trimmomatic-0.39/adapters/TruSeq3-PE.fa:2:30:10 \
  LEADING:5 \
  TRAILING:5 \
  SLIDINGWINDOW:4:5 \
  MINLEN:25 \
  > Paragammaropsis_spp.trimmo.out 2> Paragammaropsis_spp.trimmo.err

java -jar /usr/local/Trimmomatic-0.39/trimmomatic-0.39.jar PE \
  -threads 50 \
  -phred33 \
  /bwdata3/bcummings/COROPHIOID/00-DATA/Kevin/Podocerus_septumcarinatus-KK2385.1C/KK2385-1C_S1_L001_R1_001.fastq.gz \
  /bwdata3/bcummings/COROPHIOID/00-DATA/Kevin/Podocerus_septumcarinatus-KK2385.1C/KK2385-1C_S1_L001_R2_001.fastq.gz \
  Podocerus_septumcarinatus-READ1.fastq.gz \
  Podocerus_septumcarinatus.unp1.fq \
  Podocerus_septumcarinatus-READ2.fastq.gz \
  Podocerus_septumcarinatus.unp2.fq \
  ILLUMINACLIP:/usr/local/Trimmomatic-0.39/adapters/NexteraPE-PE.fa:2:30:10 \
  LEADING:5 \
  TRAILING:5 \
  SLIDINGWINDOW:4:5 \
  MINLEN:25 \
  > Podocerus_septumcarinatus.trimmo.out 2> Podocerus_septumcarinatus.trimmo.err

java -jar /usr/local/Trimmomatic-0.39/trimmomatic-0.39.jar PE \
  -threads 50 \
  -phred33 \
  /bwdata3/bcummings/COROPHIOID/00-DATA/Siena/Cerapus_spp-SM121/Cerapus_spp_1.fastq.gz \
  /bwdata3/bcummings/COROPHIOID/00-DATA/Siena/Cerapus_spp-SM121/Cerapus_spp_2.fastq.gz \
  Cerapus_spp-READ1.fastq.gz \
  Cerapus_spp.unp1.fq \
  Cerapus_spp-READ2.fastq.gz \
  Cerapus_spp.unp2.fq \
  ILLUMINACLIP:/usr/local/Trimmomatic-0.39/adapters/NexteraPE-PE.fa:2:30:10 \
  LEADING:5 \
  TRAILING:5 \
  SLIDINGWINDOW:4:5 \
  MINLEN:25 \
  > Cerapus_spp.trimmo.out 2> Cerapus_spp.trimmo.err

java -jar /usr/local/Trimmomatic-0.39/trimmomatic-0.39.jar PE \
  -threads 50 \
  -phred33 \
  /bwdata3/bcummings/COROPHIOID/00-DATA/Siena/Dulichia_spp-SM130/Dulichia_spp_1.fastq.gz \
  /bwdata3/bcummings/COROPHIOID/00-DATA/Siena/Dulichia_spp-SM130/Dulichia_spp_2.fastq.gz \
  Dulichia_spp-READ1.fastq.gz \
  Dulichia_spp.unp1.fq \
  Dulichia_spp-READ2.fastq.gz \
  Dulichia_spp.unp2.fq \
  ILLUMINACLIP:/usr/local/Trimmomatic-0.39/adapters/TruSeq3-PE.fa:2:30:10 \
  LEADING:5 \
  TRAILING:5 \
  SLIDINGWINDOW:4:5 \
  MINLEN:25 \
  > Dulichia_spp.trimmo.out 2> Dulichia_spp.trimmo.err

java -jar /usr/local/Trimmomatic-0.39/trimmomatic-0.39.jar PE \
  -threads 50 \
  -phred33 \
  /bwdata3/bcummings/COROPHIOID/00-DATA/Siena/Jassa_carltoni-SM166/Jassa_carltoni_1.fastq.gz \
  /bwdata3/bcummings/COROPHIOID/00-DATA/Siena/Jassa_carltoni-SM166/Jassa_carltoni_2.fastq.gz \
  Jassa_carltoni-READ1.fastq.gz \
  Jassa_carltoni.unp1.fq \
  Jassa_carltoni-READ2.fastq.gz \
  Jassa_carltoni.unp2.fq \
  ILLUMINACLIP:/usr/local/Trimmomatic-0.39/adapters/TruSeq3-PE.fa:2:30:10 \
  LEADING:5 \
  TRAILING:5 \
  SLIDINGWINDOW:4:5 \
  MINLEN:25 \
  > Jassa_carltoni.trimmo.out 2> Jassa_carltoni.trimmo.err

java -jar /usr/local/Trimmomatic-0.39/trimmomatic-0.39.jar PE \
  -threads 50 \
  -phred33 \
  /bwdata3/bcummings/COROPHIOID/00-DATA/Siena/Jassa_marmorata-SM185/Jassa_marmorata_1.fastq.gz \
  /bwdata3/bcummings/COROPHIOID/00-DATA/Siena/Jassa_marmorata-SM185/Jassa_marmorata_2.fastq.gz \
  Jassa_marmorata-READ1.fastq.gz \
  Jassa_marmorata.unp1.fq \
  Jassa_marmorata-READ2.fastq.gz \
  Jassa_marmorata.unp2.fq \
  ILLUMINACLIP:/usr/local/Trimmomatic-0.39/adapters/TruSeq3-PE.fa:2:30:10 \
  LEADING:5 \
  TRAILING:5 \
  SLIDINGWINDOW:4:5 \
  MINLEN:25 \
  > Jassa_marmorata.trimmo.out 2> Jassa_marmorata.trimmo.err

java -jar /usr/local/Trimmomatic-0.39/trimmomatic-0.39.jar PE \
  -threads 50 \
  -phred33 \
  /bwdata3/bcummings/COROPHIOID/00-DATA/Siena/Laticorophium_baconi-SM110_combined/Laticorophium_baconi_1.fastq.gz \
  /bwdata3/bcummings/COROPHIOID/00-DATA/Siena/Laticorophium_baconi-SM110_combined/Laticorophium_baconi_2.fastq.gz \
  Laticorophium_baconi-READ1.fastq.gz \
  Laticorophium_baconi.unp1.fq \
  Laticorophium_baconi-READ2.fastq.gz \
  Laticorophium_baconi.unp2.fq \
  ILLUMINACLIP:/usr/local/Trimmomatic-0.39/adapters/TruSeq3-PE.fa:2:30:10 \
  LEADING:5 \
  TRAILING:5 \
  SLIDINGWINDOW:4:5 \
  MINLEN:25 \
  > Laticorophium_baconi.trimmo.out 2> Laticorophium_baconi.trimmo.err

java -jar /usr/local/Trimmomatic-0.39/trimmomatic-0.39.jar PE \
  -threads 50 \
  -phred33 \
  /bwdata3/bcummings/COROPHIOID/00-DATA/Siena/Photis_conchicola-SM123/Photis_conchicola_1.fastq.gz \
  /bwdata3/bcummings/COROPHIOID/00-DATA/Siena/Photis_conchicola-SM123/Photis_conchicola_2.fastq.gz \
  Photis_conchicola-READ1.fastq.gz \
  Photis_conchicola.unp1.fq \
  Photis_conchicola-READ2.fastq.gz \
  Photis_conchicola.unp2.fq \
  ILLUMINACLIP:/usr/local/Trimmomatic-0.39/adapters/NexteraPE-PE.fa:2:30:10 \
  LEADING:5 \
  TRAILING:5 \
  SLIDINGWINDOW:4:5 \
  MINLEN:25 \
  > Photis_conchicola.trimmo.out 2> Photis_conchicola.trimmo.err

java -jar /usr/local/Trimmomatic-0.39/trimmomatic-0.39.jar PE \
  -threads 50 \
  -phred33 \
  /bwdata3/bcummings/COROPHIOID/00-DATA/Siena/Podocerus_spp-SM119.2/Podocerus_spp_1.fastq.gz \
  /bwdata3/bcummings/COROPHIOID/00-DATA/Siena/Podocerus_spp-SM119.2/Podocerus_spp_2.fastq.gz \
  Podocerus_spp-READ1.fastq.gz \
  Podocerus_spp.unp1.fq \
  Podocerus_spp-READ2.fastq.gz \
  Podocerus_spp.unp2.fq \
  ILLUMINACLIP:/usr/local/Trimmomatic-0.39/adapters/NexteraPE-PE.fa:2:30:10 \
  LEADING:5 \
  TRAILING:5 \
  SLIDINGWINDOW:4:5 \
  MINLEN:25 \
  > Podocerus_spp.trimmo.out 2> Podocerus_spp.trimmo.err

java -jar /usr/local/Trimmomatic-0.39/trimmomatic-0.39.jar PE \
  -threads 50 \
  -phred33 \
  /bwdata3/bcummings/COROPHIOID/00-DATA/NCBI/Abyssorchomene_distinctus-SRR8591419/SRR8591419_pass_1.fastq.gz \
  /bwdata3/bcummings/COROPHIOID/00-DATA/NCBI/Abyssorchomene_distinctus-SRR8591419/SRR8591419_pass_2.fastq.gz \
  Abyssorchomene_distinctus-READ1.fastq.gz \
  Abyssorchomene_distinctus.unp1.fq \
  Abyssorchomene_distinctus-READ2.fastq.gz \
  Abyssorchomene_distinctus.unp2.fq \
  ILLUMINACLIP:/usr/local/Trimmomatic-0.39/adapters/TruSeq3-PE.fa:2:30:10 \
  LEADING:5 \
  TRAILING:5 \
  SLIDINGWINDOW:4:5 \
  MINLEN:25 \
  > Abyssorchomene_distinctus.trimmo.out 2> Abyssorchomene_distinctus.trimmo.err

java -jar /usr/local/Trimmomatic-0.39/trimmomatic-0.39.jar PE \
  -threads 50 \
  -phred33 \
  /bwdata3/bcummings/COROPHIOID/00-DATA/NCBI/Alicella_gigantea-SRR14866259/SRR14866259_pass_1.fastq.gz \
  /bwdata3/bcummings/COROPHIOID/00-DATA/NCBI/Alicella_gigantea-SRR14866259/SRR14866259_pass_2.fastq.gz \
  Alicella_gigantea-READ1.fastq.gz \
  Alicella_gigantea.unp1.fq \
  Alicella_gigantea-READ2.fastq.gz \
  Alicella_gigantea.unp2.fq \
  ILLUMINACLIP:/usr/local/Trimmomatic-0.39/adapters/TruSeq3-PE.fa:2:30:10 \
  LEADING:5 \
  TRAILING:5 \
  SLIDINGWINDOW:4:5 \
  MINLEN:25 \
  > Alicella_gigantea.trimmo.out 2> Alicella_gigantea.trimmo.err

java -jar /usr/local/Trimmomatic-0.39/trimmomatic-0.39.jar PE \
  -threads 50 \
  -phred33 \
  /bwdata3/bcummings/COROPHIOID/00-DATA/NCBI/Apseudomorpha_spp-SRR14135860/SRR14135860_pass_1.fastq.gz \
  /bwdata3/bcummings/COROPHIOID/00-DATA/NCBI/Apseudomorpha_spp-SRR14135860/SRR14135860_pass_2.fastq.gz \
  Apseudomorpha_spp-READ1.fastq.gz \
  Apseudomorpha_spp.unp1.fq \
  Apseudomorpha_spp-READ2.fastq.gz \
  Apseudomorpha_spp.unp2.fq \
  ILLUMINACLIP:/usr/local/Trimmomatic-0.39/adapters/TruSeq3-PE.fa:2:30:10 \
  LEADING:5 \
  TRAILING:5 \
  SLIDINGWINDOW:4:5 \
  MINLEN:25 \
  > Apseudomorpha_spp.trimmo.out 2> Apseudomorpha_spp.trimmo.err

java -jar /usr/local/Trimmomatic-0.39/trimmomatic-0.39.jar PE \
  -threads 50 \
  -phred33 \
  /bwdata3/bcummings/COROPHIOID/00-DATA/NCBI/Armadillidium_vulgare-SRR5604243/SRR5604243_pass_1.fastq.gz \
  /bwdata3/bcummings/COROPHIOID/00-DATA/NCBI/Armadillidium_vulgare-SRR5604243/SRR5604243_pass_2.fastq.gz \
  Armadillidium_vulgare-READ1.fastq.gz \
  Armadillidium_vulgare.unp1.fq \
  Armadillidium_vulgare-READ2.fastq.gz \
  Armadillidium_vulgare.unp2.fq \
  ILLUMINACLIP:/usr/local/Trimmomatic-0.39/adapters/TruSeq3-PE.fa:2:30:10 \
  LEADING:5 \
  TRAILING:5 \
  SLIDINGWINDOW:4:5 \
  MINLEN:25 \
  > Armadillidium_vulgare.trimmo.out 2> Armadillidium_vulgare.trimmo.err

java -jar /usr/local/Trimmomatic-0.39/trimmomatic-0.39.jar PE \
  -threads 50 \
  -phred33 \
  /bwdata3/bcummings/COROPHIOID/00-DATA/NCBI/Asellus_hilgendorfii-SRR14135880/SRR14135880_pass_1.fastq.gz \
  /bwdata3/bcummings/COROPHIOID/00-DATA/NCBI/Asellus_hilgendorfii-SRR14135880/SRR14135880_pass_2.fastq.gz \
  Asellus_hilgendorfii-READ1.fastq.gz \
  Asellus_hilgendorfii.unp1.fq \
  Asellus_hilgendorfii-READ2.fastq.gz \
  Asellus_hilgendorfii.unp2.fq \
  ILLUMINACLIP:/usr/local/Trimmomatic-0.39/adapters/TruSeq3-PE.fa:2:30:10 \
  LEADING:5 \
  TRAILING:5 \
  SLIDINGWINDOW:4:5 \
  MINLEN:25 \
  > Asellus_hilgendorfii.trimmo.out 2> Asellus_hilgendorfii.trimmo.err

java -jar /usr/local/Trimmomatic-0.39/trimmomatic-0.39.jar PE \
  -threads 50 \
  -phred33 \
  /bwdata3/bcummings/COROPHIOID/00-DATA/NCBI/Cymothoa_exigua-SRR8281006/SRR8281006_pass_1.fastq.gz \
  /bwdata3/bcummings/COROPHIOID/00-DATA/NCBI/Cymothoa_exigua-SRR8281006/SRR8281006_pass_2.fastq.gz \
  Cymothoa_exigua-READ1.fastq.gz \
  Cymothoa_exigua.unp1.fq \
  Cymothoa_exigua-READ2.fastq.gz \
  Cymothoa_exigua.unp2.fq \
  ILLUMINACLIP:/usr/local/Trimmomatic-0.39/adapters/TruSeq3-PE.fa:2:30:10 \
  LEADING:5 \
  TRAILING:5 \
  SLIDINGWINDOW:4:5 \
  MINLEN:25 \
  > Cymothoa_exigua.trimmo.out 2> Cymothoa_exigua.trimmo.err

java -jar /usr/local/Trimmomatic-0.39/trimmomatic-0.39.jar PE \
  -threads 50 \
  -phred33 \
  /bwdata3/bcummings/COROPHIOID/00-DATA/NCBI/Eusirus_giganteus-SRR13341529/SRR13341529_pass_1.fastq.gz \
  /bwdata3/bcummings/COROPHIOID/00-DATA/NCBI/Eusirus_giganteus-SRR13341529/SRR13341529_pass_2.fastq.gz \
  Eusirus_giganteus-READ1.fastq.gz \
  Eusirus_giganteus.unp1.fq \
  Eusirus_giganteus-READ2.fastq.gz \
  Eusirus_giganteus.unp2.fq \
  ILLUMINACLIP:/usr/local/Trimmomatic-0.39/adapters/TruSeq3-PE.fa:2:30:10 \
  LEADING:5 \
  TRAILING:5 \
  SLIDINGWINDOW:4:5 \
  MINLEN:25 \
  > Eusirus_giganteus.trimmo.out 2> Eusirus_giganteus.trimmo.err

java -jar /usr/local/Trimmomatic-0.39/trimmomatic-0.39.jar PE \
  -threads 50 \
  -phred33 \
  /bwdata3/bcummings/COROPHIOID/00-DATA/NCBI/Gammarus_lacustris-SRR3467069/SRR3467069_pass_1.fastq.gz \
  /bwdata3/bcummings/COROPHIOID/00-DATA/NCBI/Gammarus_lacustris-SRR3467069/SRR3467069_pass_2.fastq.gz \
  Gammarus_lacustris-READ1.fastq.gz \
  Gammarus_lacustris.unp1.fq \
  Gammarus_lacustris-READ2.fastq.gz \
  Gammarus_lacustris.unp2.fq \
  ILLUMINACLIP:/usr/local/Trimmomatic-0.39/adapters/TruSeq3-PE.fa:2:30:10 \
  LEADING:5 \
  TRAILING:5 \
  SLIDINGWINDOW:4:5 \
  MINLEN:25 \
  > Gammarus_lacustris.trimmo.out 2> Gammarus_lacustris.trimmo.err

java -jar /usr/local/Trimmomatic-0.39/trimmomatic-0.39.jar PE \
  -threads 50 \
  -phred33 \
  /bwdata3/bcummings/COROPHIOID/00-DATA/NCBI/Grandidierella_japonica-DRR128008/DRR128008_pass_1.fastq.gz \
  /bwdata3/bcummings/COROPHIOID/00-DATA/NCBI/Grandidierella_japonica-DRR128008/DRR128008_pass_2.fastq.gz \
  Grandidierella_japonica-READ1.fastq.gz \
  Grandidierella_japonica.unp1.fq \
  Grandidierella_japonica-READ2.fastq.gz \
  Grandidierella_japonica.unp2.fq \
  ILLUMINACLIP:/usr/local/Trimmomatic-0.39/adapters/TruSeq3-PE.fa:2:30:10 \
  LEADING:5 \
  TRAILING:5 \
  SLIDINGWINDOW:4:5 \
  MINLEN:25 \
  > Grandidierella_japonica.trimmo.out 2> Grandidierella_japonica.trimmo.err

java -jar /usr/local/Trimmomatic-0.39/trimmomatic-0.39.jar PE \
  -threads 50 \
  -phred33 \
  /bwdata3/bcummings/COROPHIOID/00-DATA/NCBI/Hirondellea_gigas-SRR3822238/SRR3822238_pass_1.fastq.gz \
  /bwdata3/bcummings/COROPHIOID/00-DATA/NCBI/Hirondellea_gigas-SRR3822238/SRR3822238_pass_2.fastq.gz \
  Hirondellea_gigas-READ1.fastq.gz \
  Hirondellea_gigas.unp1.fq \
  Hirondellea_gigas-READ2.fastq.gz \
  Hirondellea_gigas.unp2.fq \
  ILLUMINACLIP:/usr/local/Trimmomatic-0.39/adapters/TruSeq3-PE.fa:2:30:10 \
  LEADING:5 \
  TRAILING:5 \
  SLIDINGWINDOW:4:5 \
  MINLEN:25 \
  > Hirondellea_gigas.trimmo.out 2> Hirondellea_gigas.trimmo.err

java -jar /usr/local/Trimmomatic-0.39/trimmomatic-0.39.jar PE \
  -threads 50 \
  -phred33 \
  /bwdata3/bcummings/COROPHIOID/00-DATA/NCBI/Hyperia_spp-SRR20015048/SRR20015048_pass_1.fastq.gz \
  /bwdata3/bcummings/COROPHIOID/00-DATA/NCBI/Hyperia_spp-SRR20015048/SRR20015048_pass_2.fastq.gz \
  Hyperia_spp-READ1.fastq.gz \
  Hyperia_spp.unp1.fq \
  Hyperia_spp-READ2.fastq.gz \
  Hyperia_spp.unp2.fq \
  ILLUMINACLIP:/usr/local/Trimmomatic-0.39/adapters/TruSeq3-PE.fa:2:30:10 \
  LEADING:5 \
  TRAILING:5 \
  SLIDINGWINDOW:4:5 \
  MINLEN:25 \
  > Hyperia_spp.trimmo.out 2> Hyperia_spp.trimmo.err

java -jar /usr/local/Trimmomatic-0.39/trimmomatic-0.39.jar PE \
  -threads 50 \
  -phred33 \
  /bwdata3/bcummings/COROPHIOID/00-DATA/NCBI/Idotea_balthica-SRR7056353/SRR7056353_pass_1.fastq.gz \
  /bwdata3/bcummings/COROPHIOID/00-DATA/NCBI/Idotea_balthica-SRR7056353/SRR7056353_pass_2.fastq.gz \
  Idotea_balthica-READ1.fastq.gz \
  Idotea_balthica.unp1.fq \
  Idotea_balthica-READ2.fastq.gz \
  Idotea_balthica.unp2.fq \
  ILLUMINACLIP:/usr/local/Trimmomatic-0.39/adapters/TruSeq3-PE.fa:2:30:10 \
  LEADING:5 \
  TRAILING:5 \
  SLIDINGWINDOW:4:5 \
  MINLEN:25 \
  > Idotea_balthica.trimmo.out 2> Idotea_balthica.trimmo.err

java -jar /usr/local/Trimmomatic-0.39/trimmomatic-0.39.jar PE \
  -threads 50 \
  -phred33 \
  /bwdata3/bcummings/COROPHIOID/00-DATA/NCBI/Leptochelia_spp-SRR5140116/SRR5140116_pass_1.fastq.gz \
  /bwdata3/bcummings/COROPHIOID/00-DATA/NCBI/Leptochelia_spp-SRR5140116/SRR5140116_pass_2.fastq.gz \
  Leptochelia_spp-READ1.fastq.gz \
  Leptochelia_spp.unp1.fq \
  Leptochelia_spp-READ2.fastq.gz \
  Leptochelia_spp.unp2.fq \
  ILLUMINACLIP:/usr/local/Trimmomatic-0.39/adapters/NexteraPE-PE.fa:2:30:10 \
  LEADING:5 \
  TRAILING:5 \
  SLIDINGWINDOW:4:5 \
  MINLEN:25 \
  > Leptochelia_spp.trimmo.out 2> Leptochelia_spp.trimmo.err

java -jar /usr/local/Trimmomatic-0.39/trimmomatic-0.39.jar PE \
  -threads 50 \
  -phred33 \
  /bwdata3/bcummings/COROPHIOID/00-DATA/NCBI/Neomysis_awatschensis-SRR2070625/SRR2070625_pass_1.fastq.gz \
  /bwdata3/bcummings/COROPHIOID/00-DATA/NCBI/Neomysis_awatschensis-SRR2070625/SRR2070625_pass_2.fastq.gz \
  Neomysis_awatschensis-READ1.fastq.gz \
  Neomysis_awatschensis.unp1.fq \
  Neomysis_awatschensis-READ2.fastq.gz \
  Neomysis_awatschensis.unp2.fq \
  ILLUMINACLIP:/usr/local/Trimmomatic-0.39/adapters/TruSeq3-PE.fa:2:30:10 \
  LEADING:5 \
  TRAILING:5 \
  SLIDINGWINDOW:4:5 \
  MINLEN:25 \
  > Neomysis_awatschensis.trimmo.out 2> Neomysis_awatschensis.trimmo.err

java -jar /usr/local/Trimmomatic-0.39/trimmomatic-0.39.jar PE \
  -threads 50 \
  -phred33 \
  /bwdata3/bcummings/COROPHIOID/00-DATA/NCBI/Niphargus_hrabei-SRR13297208/SRR13297208_pass_1.fastq.gz \
  /bwdata3/bcummings/COROPHIOID/00-DATA/NCBI/Niphargus_hrabei-SRR13297208/SRR13297208_pass_2.fastq.gz \
  Niphargus_hrabei-READ1.fastq.gz \
  Niphargus_hrabei.unp1.fq \
  Niphargus_hrabei-READ2.fastq.gz \
  Niphargus_hrabei.unp2.fq \
  ILLUMINACLIP:/usr/local/Trimmomatic-0.39/adapters/TruSeq3-PE.fa:2:30:10 \
  LEADING:5 \
  TRAILING:5 \
  SLIDINGWINDOW:4:5 \
  MINLEN:25 \
  > Niphargus_hrabei.trimmo.out 2> Niphargus_hrabei.trimmo.err

java -jar /usr/local/Trimmomatic-0.39/trimmomatic-0.39.jar PE \
  -threads 50 \
  -phred33 \
  /bwdata3/bcummings/COROPHIOID/00-DATA/NCBI/Orchestia_grillus-SRR9870982/SRR9870982_pass_1.fastq.gz \
  /bwdata3/bcummings/COROPHIOID/00-DATA/NCBI/Orchestia_grillus-SRR9870982/SRR9870982_pass_2.fastq.gz \
  Orchestia_grillus-READ1.fastq.gz \
  Orchestia_grillus.unp1.fq \
  Orchestia_grillus-READ2.fastq.gz \
  Orchestia_grillus.unp2.fq \
  ILLUMINACLIP:/usr/local/Trimmomatic-0.39/adapters/TruSeq3-PE.fa:2:30:10 \
  LEADING:5 \
  TRAILING:5 \
  SLIDINGWINDOW:4:5 \
  MINLEN:25 \
  > Orchestia_grillus.trimmo.out 2> Orchestia_grillus.trimmo.err

java -jar /usr/local/Trimmomatic-0.39/trimmomatic-0.39.jar PE \
  -threads 50 \
  -phred33 \
  /bwdata3/bcummings/COROPHIOID/00-DATA/NCBI/Parhyale_hawaiiensis-SRR5947979/SRR5947979_pass_1.fastq.gz \
  /bwdata3/bcummings/COROPHIOID/00-DATA/NCBI/Parhyale_hawaiiensis-SRR5947979/SRR5947979_pass_2.fastq.gz \
  Parhyale_hawaiiensis-READ1.fastq.gz \
  Parhyale_hawaiiensis.unp1.fq \
  Parhyale_hawaiiensis-READ2.fastq.gz \
  Parhyale_hawaiiensis.unp2.fq \
  ILLUMINACLIP:/usr/local/Trimmomatic-0.39/adapters/TruSeq3-PE.fa:2:30:10 \
  LEADING:5 \
  TRAILING:5 \
  SLIDINGWINDOW:4:5 \
  MINLEN:25 \
  > Parhyale_hawaiiensis.trimmo.out 2> Parhyale_hawaiiensis.trimmo.err

java -jar /usr/local/Trimmomatic-0.39/trimmomatic-0.39.jar PE \
  -threads 50 \
  -phred33 \
  /bwdata3/bcummings/COROPHIOID/00-DATA/NCBI/Phoxokalliapseudes_tomiokaensis-SRR14135877/SRR14135877_pass_1.fastq.gz \
  /bwdata3/bcummings/COROPHIOID/00-DATA/NCBI/Phoxokalliapseudes_tomiokaensis-SRR14135877/SRR14135877_pass_2.fastq.gz \
  Phoxokalliapseudes_tomiokaensis-READ1.fastq.gz \
  Phoxokalliapseudes_tomiokaensis.unp1.fq \
  Phoxokalliapseudes_tomiokaensis-READ2.fastq.gz \
  Phoxokalliapseudes_tomiokaensis.unp2.fq \
  ILLUMINACLIP:/usr/local/Trimmomatic-0.39/adapters/TruSeq3-PE.fa:2:30:10 \
  LEADING:5 \
  TRAILING:5 \
  SLIDINGWINDOW:4:5 \
  MINLEN:25 \
  > Phoxokalliapseudes_tomiokaensis.trimmo.out 2> Phoxokalliapseudes_tomiokaensis.trimmo.err

java -jar /usr/local/Trimmomatic-0.39/trimmomatic-0.39.jar PE \
  -threads 50 \
  -phred33 \
  /bwdata3/bcummings/COROPHIOID/00-DATA/NCBI/Platorchestia_hallaensis-SRR12464060/SRR12464060_pass_1.fastq.gz \
  /bwdata3/bcummings/COROPHIOID/00-DATA/NCBI/Platorchestia_hallaensis-SRR12464060/SRR12464060_pass_2.fastq.gz \
  Platorchestia_hallaensis-READ1.fastq.gz \
  Platorchestia_hallaensis.unp1.fq \
  Platorchestia_hallaensis-READ2.fastq.gz \
  Platorchestia_hallaensis.unp2.fq \
  ILLUMINACLIP:/usr/local/Trimmomatic-0.39/adapters/TruSeq3-PE.fa:2:30:10 \
  LEADING:5 \
  TRAILING:5 \
  SLIDINGWINDOW:4:5 \
  MINLEN:25 \
  > Platorchestia_hallaensis.trimmo.out 2> Platorchestia_hallaensis.trimmo.err

java -jar /usr/local/Trimmomatic-0.39/trimmomatic-0.39.jar PE \
  -threads 50 \
  -phred33 \
  /bwdata3/bcummings/COROPHIOID/00-DATA/NCBI/Scalpellum_stearnsi-SRR23562283/SRR23562283_pass_1.fastq.gz \
  /bwdata3/bcummings/COROPHIOID/00-DATA/NCBI/Scalpellum_stearnsi-SRR23562283/SRR23562283_pass_2.fastq.gz \
  Scalpellum_stearnsi-READ1.fastq.gz \
  Scalpellum_stearnsi.unp1.fq \
  Scalpellum_stearnsi-READ2.fastq.gz \
  Scalpellum_stearnsi.unp2.fq \
  ILLUMINACLIP:/usr/local/Trimmomatic-0.39/adapters/TruSeq3-PE.fa:2:30:10 \
  LEADING:5 \
  TRAILING:5 \
  SLIDINGWINDOW:4:5 \
  MINLEN:25 \
  > Scalpellum_stearnsi.trimmo.out 2> Scalpellum_stearnsi.trimmo.err

java -jar /usr/local/Trimmomatic-0.39/trimmomatic-0.39.jar PE \
  -threads 50 \
  -phred33 \
  /bwdata3/bcummings/COROPHIOID/00-DATA/NCBI/Scopelocheirus_schellenbergi-SRR14866420/SRR14866420_pass_1.fastq.gz \
  /bwdata3/bcummings/COROPHIOID/00-DATA/NCBI/Scopelocheirus_schellenbergi-SRR14866420/SRR14866420_pass_2.fastq.gz \
  Scopelocheirus_schellenbergi-READ1.fastq.gz \
  Scopelocheirus_schellenbergi.unp1.fq \
  Scopelocheirus_schellenbergi-READ2.fastq.gz \
  Scopelocheirus_schellenbergi.unp2.fq \
  ILLUMINACLIP:/usr/local/Trimmomatic-0.39/adapters/TruSeq3-PE.fa:2:30:10 \
  LEADING:5 \
  TRAILING:5 \
  SLIDINGWINDOW:4:5 \
  MINLEN:25 \
  > Scopelocheirus_schellenbergi.trimmo.out 2> Scopelocheirus_schellenbergi.trimmo.err

java -jar /usr/local/Trimmomatic-0.39/trimmomatic-0.39.jar PE \
  -threads 50 \
  -phred33 \
  /bwdata3/bcummings/COROPHIOID/00-DATA/NCBI/Talitrus_saltador-SRR2552911/SRR2552911_pass_1.fastq.gz \
  /bwdata3/bcummings/COROPHIOID/00-DATA/NCBI/Talitrus_saltador-SRR2552911/SRR2552911_pass_2.fastq.gz \
  Talitrus_saltador-READ1.fastq.gz \
  Talitrus_saltador.unp1.fq \
  Talitrus_saltador-READ2.fastq.gz \
  Talitrus_saltador.unp2.fq \
  ILLUMINACLIP:/usr/local/Trimmomatic-0.39/adapters/TruSeq3-PE.fa:2:30:10 \
  LEADING:5 \
  TRAILING:5 \
  SLIDINGWINDOW:4:5 \
  MINLEN:25 \
  > Talitrus_saltador.trimmo.out 2> Talitrus_saltador.trimmo.err

java -jar /usr/local/Trimmomatic-0.39/trimmomatic-0.39.jar PE \
  -threads 50 \
  -phred33 \
  /bwdata3/bcummings/COROPHIOID/00-DATA/NCBI/Tanaella_kommritzia-SRR14135867/SRR14135867_pass_1.fastq.gz \
  /bwdata3/bcummings/COROPHIOID/00-DATA/NCBI/Tanaella_kommritzia-SRR14135867/SRR14135867_pass_2.fastq.gz \
  Tanaella_kommritzia-READ1.fastq.gz \
  Tanaella_kommritzia.unp1.fq \
  Tanaella_kommritzia-READ2.fastq.gz \
  Tanaella_kommritzia.unp2.fq \
  ILLUMINACLIP:/usr/local/Trimmomatic-0.39/adapters/TruSeq3-PE.fa:2:30:10 \
  LEADING:5 \
  TRAILING:5 \
  SLIDINGWINDOW:4:5 \
  MINLEN:25 \
  > Tanaella_kommritzia.trimmo.out 2> Tanaella_kommritzia.trimmo.err

java -jar /usr/local/Trimmomatic-0.39/trimmomatic-0.39.jar PE \
  -threads 50 \
  -phred33 \
  /bwdata3/bcummings/COROPHIOID/00-DATA/NCBI/Zeuxo_ezoensis-SRR14135882/SRR14135882_pass_1.fastq.gz \
  /bwdata3/bcummings/COROPHIOID/00-DATA/NCBI/Zeuxo_ezoensis-SRR14135882/SRR14135882_pass_2.fastq.gz \
  Zeuxo_ezoensis-READ1.fastq.gz \
  Zeuxo_ezoensis.unp1.fq \
  Zeuxo_ezoensis-READ2.fastq.gz \
  Zeuxo_ezoensis.unp2.fq \
  ILLUMINACLIP:/usr/local/Trimmomatic-0.39/adapters/TruSeq3-PE.fa:2:30:10 \
  LEADING:5 \
  TRAILING:5 \
  SLIDINGWINDOW:4:5 \
  MINLEN:25 \
  > Zeuxo_ezoensis.trimmo.out 2> Zeuxo_ezoensis.trimmo.err

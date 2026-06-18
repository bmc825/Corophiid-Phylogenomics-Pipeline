#!/bin/bash
#
# Kevin M. Kocot, Nickellaus G. Roberts
#
#This script takes the output of OrthoFinder and performs several "cleaning" steps to remove groups and sequences that are not suitable for phylogenomic analysis.
#Note which programs must be included in $PATH
#Run this script from the working directory containing the input fasta files (extension must be .fa) where each file represents one putatively orthologous group.
#Fasta headers must be in the following format: >species_name_abbreviation|annotation_or_sequence_ID_information
#Example: >LGIG|Contig1234
#Fasta headers may not include spaces or non-alphanumeric characters except for underscores (pipes are OK as field delimiters only).

########################################################################
################## Change these before your first use ##################
########################################################################
#Set values for variables.
MIN_SEQUENCE_LENGTH=100 #Deletes original seqs shorter than this length
MIN_ALIGNMENT_LENGTH=100 #Minimum length of a trimmed alignment in amino acids
ALL_TAXA=54
HALF_TAXA=27
THREEFOURTHS_TAXA=41
CLASS_PATH=/usr/local/bin/ #Location of PhyloTreePruner .class files
CORES=40 #Number of CPU cores to use with Parallel
PREFIX=IQ-TREE2 #IQ-TREE 2 prefix for output files
########################################################################


##Fix headears and remove newlines.
echo "Removing linebreaks in sequences and fixing headers..."
find . -maxdepth 1 -type f -name "*.fa" -print0 | xargs -0 -L 1 -P 20 -I [] sed -i ':a; $!N; /^>/!s/\n\([^>]\)/\1/; ta; P; D' []
echo Done
echo


##Exclude fasta files with a number of sequences >10X the number of taxa
echo "Removing files with a number of sequences >10X the number of taxa..."
mkdir too_many_sequences
for FILENAME in *.fa
do
SEQS_IN_FASTA=`grep -c ">" $FILENAME`
AVG=`expr $SEQS_IN_FASTA / $ALL_TAXA`
if [ "$AVG" -gt 10 ]; then
mv $FILENAME too_many_sequences
fi
done


##If fewer than $MIN_TAXA different species are represented in the file, move that file to the "rejected_few_taxa" directory.
echo "Removing groups with fewer than $HALF_TAXA taxa..."
mkdir -p rejected_few_taxa_1
for FILENAME in *.fa
do
awk -F"|" '/^>/{ taxon[$1]++ } END{for(o in taxon){print o,taxon[o]}}' $FILENAME > $FILENAME\.taxon_count #Creates temporary file with taxon abbreviation and number of sequences for that taxon in $FILENAME
taxon_count=`grep -v 0 $FILENAME\.taxon_count | wc -l` #Counts the number of lines with an integer >0 (= the number of taxa with at least 1 sequence)
if [ "$taxon_count" -lt "$HALF_TAXA" ] ; then
echo $FILENAME
mv $FILENAME ./rejected_few_taxa_1/
fi
done
find . -maxdepth 1 -name "*.taxon_count" -print0 | xargs -0 rm
echo Done

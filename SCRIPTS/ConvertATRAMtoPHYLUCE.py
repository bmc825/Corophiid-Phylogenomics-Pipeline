### Convert aTRAM stitched exon files to PHYLUCE format
### Takes in fasta files with filename as uce###.stitched_exons.fasta
### Takes in fasta files with unwrapped sequences
### Outputs fasta file with sequences wrapped and sequence name to match PHYLUCE pipeline
### Replaces N's and ambiguous characters with '?' (otherwise PHYLUCE skips sequences)

import os
import textwrap

files_in_cwd = os.listdir(os.getcwd())

for file in files_in_cwd:

    if (str(file).find('.fasta')) != -1 and 'stitched_exons' in file:
        print(file)

        # Extract locus number from filename like uce001.stitched_exons.fasta
        locus = file[file.find('uce')+3:file.find('.')]
        print(locus)

        outfile1 = open(str(file).replace('.fasta', '-phyluce.fasta'), 'w')
        lines = open(file, 'r').readlines()

        for line in lines:
            if line[0] == '>':
                sample = line[line.find('>')+1:line.find('.')]
                print(sample)
                outfile1.write('>uce-' + locus + '_' + sample + ' |uce-' + locus + '\n')

            else:
                sequence = line.strip()
                newline = sequence.replace('-', '').replace('N','?').replace('M','?') \
                                  .replace('K','?').replace('R','?').replace('W','?') \
                                  .replace('S','?').replace('Y','?')
                wrappedseq = textwrap.wrap(newline, 60)
                for each in wrappedseq:
                    outfile1.write(each + '\n')

        outfile1.close()

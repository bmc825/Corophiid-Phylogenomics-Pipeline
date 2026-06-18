### Convert aTRAM stitched exon files to PHYLUCE format
### Takes in fasta files with filename as uce###.stitched_exons.fasta
### Takes in fasta files with unwrapped sequences
### Outputs fasta file with sequences wrapped and sequence name to match PHYLUCE pipeline
### Replaces N's and ambiguous characters with '?' (otherwise PHYLUCE skips sequences)

import os
import textwrap
from collections import defaultdict

sample_seqs = defaultdict(list)

for file in os.listdir():
    if file.endswith('.fasta') and 'stitched_exons' in file:
        locus = file[file.find('uce')+3:file.find('.')]

        with open(file, 'r') as f:
            lines = f.readlines()

        i = 0
        while i < len(lines):
            if lines[i].startswith('>'):
                header = lines[i].strip()
                seq = lines[i+1].strip()
                i += 2
            else:
                i += 1
                continue

            # 🛠️ FIX: properly extract taxon name (drop Contig_ and UCE ID)
            sample = header.replace(">", "").replace("Contig_", "").rsplit("_", 1)[0]

            cleanseq = seq.replace('-', '').replace('N','?').replace('M','?') \
                          .replace('K','?').replace('R','?').replace('W','?') \
                          .replace('S','?').replace('Y','?')
            wrappedseq = "\n".join(textwrap.wrap(cleanseq, 60))

            new_header = f">uce-{locus}_{sample} |uce-{locus}"
            sample_seqs[sample].append(f"{new_header}\n{wrappedseq}")

for sample, entries in sample_seqs.items():
    with open(f"{sample}-phyluce.fasta", 'w') as out:
        out.write("\n".join(entries) + "\n")

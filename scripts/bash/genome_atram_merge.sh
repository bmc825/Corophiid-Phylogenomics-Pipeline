#!/bin/bash

# Usage check
if [[ $# -ne 3 ]]; then
    echo "Usage: $0 <stitched_dir> <genome_dir> <output_dir>"
    exit 1
fi

STITCHED_DIR="$1"
GENOME_DIR="$2"
OUTPUT_DIR="$3"

mkdir -p "$OUTPUT_DIR"

# Loop through all stitched exon files
for stitched_file in "$STITCHED_DIR"/uce_*.stitched_exons.fasta; do
    base_stitched=$(basename "$stitched_file")
    uce_id=$(echo "$base_stitched" | cut -d. -f1)  # e.g., uce_001

    # Initialize output file
    output_file="$OUTPUT_DIR/$base_stitched"
    cp "$stitched_file" "$output_file"

    # Look for matching genome files
    genome_matches=$(find "$GENOME_DIR" -type f -name "${uce_id}.*.fasta")

    # Append genome data if found
    if [[ -n "$genome_matches" ]]; then
        for genome_file in $genome_matches; do
            echo "[$uce_id] Appending $(basename "$genome_file") to $base_stitched"
            cat "$genome_file" >> "$output_file"
        done

        # Sort all entries by taxon while retaining multiple contigs
        awk -v uce="$uce_id" '
            BEGIN { RS=">"; ORS="" }
            NR > 1 {
                split($1, hdr_parts, "\n")
                header = hdr_parts[1]
                seq = substr($0, length(header)+2)
                gsub(/\n+$/, "", seq)  # remove trailing newlines from sequence
                match(header, /^([^_]+_[^_]+)/, m)
                taxon = m[1]
                if (taxon != "") {
                    seqs[taxon] = (taxon in seqs ? seqs[taxon] "\n>" : ">") header "\n" seq
                }
            }
            END {
                n = asorti(seqs, keys)
                for (i = 1; i <= n; i++) {
                    print seqs[keys[i]] "\n"
                }
            }
        ' "$output_file" > "${output_file}.tmp" && mv "${output_file}.tmp" "$output_file"

    else
        echo "[$uce_id] No genome sequences found — copying stitched only"
    fi
done

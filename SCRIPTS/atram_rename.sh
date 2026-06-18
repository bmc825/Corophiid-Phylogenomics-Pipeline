#!/bin/bash

# Usage: bash atram_rename.sh /path/to/input_dir /path/to/output_dir

if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <input_dir> <output_dir>"
    exit 1
fi

INPUT_DIR="$1"
OUTPUT_DIR="$2"
mkdir -p "$OUTPUT_DIR"

# Recursively find all .fastq.gz files, including symlinks
find "$INPUT_DIR" \( -type f -o -type l \) -name "*.fastq.gz" | while read -r f; do
    out="$OUTPUT_DIR/$(basename "${f%.gz}")"

    perl -e '
        use strict;
        use warnings;
        use IO::Uncompress::Gunzip qw(gunzip $GunzipError);

        my ($infile, $outfile) = @ARGV;
        my $in = IO::Uncompress::Gunzip->new($infile)
            or die "Cannot open input $infile: $GunzipError\n";

        open(my $out, ">", $outfile) or die "Cannot write to $outfile: $!\n";

        my $line_num = 0;
        while (1) {
            my $header = <$in>;
            my $seq    = <$in>;
            my $plus   = <$in>;
            my $qual   = <$in>;
            last unless defined $header;

            $line_num += 4;

            unless (defined $seq && defined $plus && defined $qual) {
                last;  # Exit cleanly at EOF
            }

            chomp($header, $seq, $plus, $qual);

            if (length($seq) != length($qual)) {
                die "Length mismatch in $infile at line $line_num: sequence and quality lengths differ\n";
            }

            $header =~ s/^@//;
            my ($id_part) = split(/\s+/, $header);

            print $out "\@$id_part\n";
            print $out $seq . "\n";
            print $out "+\n";
            print $out $qual . "\n";
        }

        close($in);
        close($out);
    ' "$f" "$out"

    # Gzip the renamed .fastq
    gzip "$out"
done

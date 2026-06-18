#!/usr/bin/perl
use strict;
use warnings;
use File::Basename;

# Check if correct number of arguments is provided
if (@ARGV != 3) {
    die "Usage: $0 <fasta_directory> <select_files_directory> <output_directory>\n";
}

# Assign command line arguments to variables
my ($fa_dir, $select_dir, $output_dir) = @ARGV;

# Create output directory if it doesn't exist
mkdir $output_dir unless -d $output_dir;

# Open the fasta directory
opendir(my $fa_dh, $fa_dir) or die "Cannot open directory $fa_dir: $!\n";

# Loop over each .fa file in the orthogroup directory
while (my $fa_file = readdir($fa_dh)) {
    next unless $fa_file =~ /\.fa$/;

    # Extract the orthogroup name from the fasta file (e.g., OG0005557)
    my ($basename) = $fa_file =~ /^(.*)\.fa$/;

    # Set the corresponding select_file name (e.g., select_file_OG0005557.fa)
    my $select_file = "$select_dir/select_file_${basename}.tsv";

    # Print diagnostic information
    print "Looking for select file: $select_file\n";

    # Check if select_file exists
    if (-f $select_file) {
        # Run select_contigs.pl on the current .fa file using the corresponding select_file
        my $fa_path = "$fa_dir/$fa_file";
        my $output_file = "$output_dir/${basename}_selected.fa";

        system("perl select_contigs.pl $fa_path $select_file > $output_file") == 0
            or warn "Error processing $basename: $!\n";

        print "Processed $basename\n";
    } else {
        print "Select file for $basename not found, skipping...\n";
    }
}

closedir($fa_dh);

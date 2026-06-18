#!/usr/bin/perl
use strict;
use warnings;

# Check for correct number of command-line arguments
if (@ARGV != 3) {
    die "Usage: perl extract_sequences.pl <folder_with_fa_files> <tsv_file> <output_file>\n";
}

# Get command-line arguments
my ($directory, $tsv_file, $output_file) = @ARGV;

# Read the first column names from the TSV file into a hash for quick lookup
open my $tsv_fh, '<', $tsv_file or die "Could not open '$tsv_file': $!";
my %names;
while (my $line = <$tsv_fh>) {
    chomp $line;
    my @fields = split /\t/, $line;  # Split line by tab
    $names{lc $fields[0]} = 1;  # Store the first column value in lowercase for case-insensitive matching
}
close $tsv_fh;

# Open output file for writing
open my $output_fh, '>', $output_file or die "Could not open '$output_file': $!";

# Process each .fa file in the specified directory
opendir my $dir, $directory or die "Could not open directory '$directory': $!";
while (my $file = readdir($dir)) {
    next unless $file =~ /\.fa$/;  # Process only .fa files

    open my $fa_fh, '<', "$directory/$file" or die "Could not open '$file': $!";
    my $current_defline = '';
    my $current_sequence = '';

    while (my $line = <$fa_fh>) {
        chomp $line;

        if ($line =~ /^>(.*)/) {  # Check for defline
            if ($current_defline && exists $names{lc $current_defline}) {
                print $output_fh ">$current_defline\n$current_sequence\n";  # Write the sequence to output
            }
            $current_defline = $1;  # Store the new defline without '>'
            $current_sequence = '';   # Reset sequence for new defline
        } else {
            $current_sequence .= $line;  # Append to the current sequence
        }
    }

    # Check last entry in the file
    if ($current_defline && exists $names{lc $current_defline}) {
        print $output_fh ">$current_defline\n$current_sequence\n";  # Write the sequence to output
    }

    close $fa_fh;
}
closedir $dir;
close $output_fh;

print "Extraction complete! Sequences saved to '$output_file'.\n";

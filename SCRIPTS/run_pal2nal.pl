#!/usr/bin/perl

use strict;
use warnings;

# Check for the correct number of command-line arguments
if (@ARGV != 3) {
    die "Usage: $0 <protein_directory> <nucleotide_directory> <output_directory>\n";
}

# Get input and output directories from command-line arguments
my ($protein_dir, $nucleotide_dir, $output_dir) = @ARGV;

# Create output directory if it doesn't exist
mkdir $output_dir unless -d $output_dir;

# Get a list of protein files
my @protein_files = glob("$protein_dir/*.fa");

foreach my $protein_file (@protein_files) {
    # Construct the corresponding nucleotide file path
    my $nucleotide_file = "$nucleotide_dir/" . (substr $protein_file, rindex($protein_file, '/') + 1);

    # Construct the output file path
    my $output_file = "$output_dir/" . substr($protein_file, rindex($protein_file, '/') + 1);

    # Create a log file path
    my $log_file = "$output_file";
    $log_file =~ s/\.fa/_log.txt/;

    # Run pal2nal.pl and redirect both stdout and stderr to the log file
    my $command = "../pal2nal.pl $protein_file $nucleotide_file -output fasta > $output_file 2> $log_file";
    system($command);
}

# Create a combined log file path
my $combined_log_file = "$output_dir/combined_log.txt";

# Open the combined log file for writing
open my $combined_log_fh, '>', $combined_log_file or die "Could not open $combined_log_file: $!";

foreach my $protein_file (@protein_files) {
    # Create a log file path
    my $log_file = "$output_dir/" . substr($protein_file, rindex($protein_file, '/') + 1);
    $log_file =~ s/\.fa/_log.txt/;

    # Append the current log file to the combined log file
    open my $log_fh, '<', $log_file or die "Could not open $log_file: $!";
    print $combined_log_fh "\n\n=========== Log file for $protein_file ===========\n\n";
    print $combined_log_fh $_ while <$log_fh>;
    close $log_fh;
}

# Close the combined log file
close $combined_log_fh;

# Print a message indicating the location of the combined log file
print "Combined log file saved to: $combined_log_file\n";

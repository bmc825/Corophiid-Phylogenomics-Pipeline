#!/usr/bin/perl
use strict;
use warnings;
use File::Copy;
use File::Spec;

# Check if the correct number of arguments are provided
if (@ARGV != 3) {
    die "Usage: perl copy_genesortR_files.pl <gene_list_file> <input_folder> <output_folder>\n";
}

# Read command line arguments
my ($gene_list_file, $input_folder, $output_folder) = @ARGV;

# Create the output folder if it does not exist
unless (-d $output_folder) {
    mkdir $output_folder or die "Unable to create output folder '$output_folder': $!";
}

# Open the gene list file
open my $fh, '<', $gene_list_file or die "Could not open gene list file '$gene_list_file': $!";

# Read each gene name from the gene list file
while (my $gene_name = <$fh>) {
    chomp $gene_name;
    $gene_name =~ s/^\s+|\s+$//g; # Trim leading and trailing whitespace

    # Add .fa extension to the gene name
    my $file_name = $gene_name . '.fa';

    # Build the full paths to the input file and output location
    my $input_file_path = File::Spec->catfile($input_folder, $file_name);
    my $output_file_path = File::Spec->catfile($output_folder, $file_name);

    # Copy the file if it exists
    if (-e $input_file_path) {
        copy($input_file_path, $output_file_path) or warn "Could not copy '$input_file_path' to '$output_file_path': $!";
    } else {
        warn "File '$input_file_path' not found, skipping.\n";
    }
}

# Close the file handle
close $fh;

print "Finished copying files.\n";

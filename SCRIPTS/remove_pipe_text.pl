#!/usr/bin/env perl

use strict;
use warnings;
use File::Basename;

# Check for the input folder path with wildcards
my $folder_path = shift;

# Check if the folder path is provided
if (!$folder_path) {
    die "Usage: $0 folder_path_with_wildcards\n";
}

# Use glob to expand wildcards and get a list of matching files
my @files = glob($folder_path);

# Process each file in the list
foreach my $input_file (@files) {
    # Check if it's a file and not a directory
    if (-f $input_file) {
        my $output_file = basename($input_file);
        $output_file =~ s/^(OG\d+).*\.fa.*/$1.fa/;

        open my $in,  '<', $input_file  or die "Cannot open input file '$input_file': $!";
        open my $out, '>', $output_file or die "Cannot open output file '$output_file': $!";

        while (my $line = <$in>) {
            if ($line =~ /^>/) {
                # Remove text after the first pipe character '|'
                $line =~ s/\|.*$//;
            }
            print $out $line;
        }

        close $in;
        close $out;

        print "Processed: $input_file -> $output_file\n";
    }
}

print "Done\n";

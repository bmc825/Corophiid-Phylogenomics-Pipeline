#!/usr/bin/perl
use strict;
use warnings;

# Check for input file argument
if (@ARGV != 1) {
    die "Usage: $0 input_partition_file.nex\n";
}

# Input partition file
my $input_file = $ARGV[0];

# Open the input file for reading
open(my $in, '<', $input_file) or die "Could not open file '$input_file' $!";

# Process lines in the input file
while (my $line = <$in>) {
    # Exit loop if we encounter "charpartition mine"
    last if $line =~ /^charpartition mine/;

    # If the line contains a "charset" definition, remove "charset ", the trailing semicolon, and print it
    if ($line =~ /^charset\s+(.+);$/) {
        print "$1\n";  # Print the line without "charset " and without the trailing semicolon
    }
}

# Close the file handle
close $in;

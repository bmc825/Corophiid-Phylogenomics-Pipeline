#!/usr/bin/perl

use strict;
use warnings;
use Getopt::Long;

my ($input_file, $output_file);

# Get command-line options
GetOptions(
    'input=s'  => \$input_file,
    'output=s' => \$output_file,
);

# Check if input and output file names are provided
unless (defined $input_file && defined $output_file) {
    die "Usage: $0 --input=input_partition.txt --output=output.nexus\n";
}

# Open input and output files
open my $input_fh, '<', $input_file or die "Cannot open $input_file: $!";
open my $output_fh, '>', $output_file or die "Cannot create $output_file: $!";

# Write Nexus file header
print $output_fh "#nexus\n";
print $output_fh "begin sets;\n";

# Process each line in the input partition file
while (my $line = <$input_fh>) {
    chomp $line;
    next if $line =~ /^\s*$/;  # Skip empty lines

    # Extract the orthogroup name and start/end values
    if ($line =~ /^DNA,\s*([\w-]+)\s*=\s*([\d.e+-]+)-([\d.e+-]+)$/) {
        my ($orthogroup_name, $start, $end) = ($1, $2, $3);

        # Write in Nexus format
        print $output_fh "charset $orthogroup_name = $start-$end;\n";
    } else {
        warn "Line does not match expected format: $line\n";  # Warn about unmatched lines
    }
}

# Write Nexus file footer
print $output_fh "END;\n";

# Close input and output files
close $input_fh;
close $output_fh;

print "Conversion complete. Output written to $output_file\n";

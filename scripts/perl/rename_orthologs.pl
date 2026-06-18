#!/usr/bin/perl
use strict;
use warnings;
use File::Copy;

# Get the input directory from command line arguments
my $folder = shift @ARGV // ".";

# Ensure the directory exists
-d $folder or die "Directory $folder does not exist!";

# Get list of fasta files
opendir(my $dh, $folder) or die "Cannot open directory: $!";
my @files = grep { /\.orthologs\.fasta$/ } readdir($dh);
closedir($dh);

foreach my $file (@files) {
    my $input_file = "$folder/$file";
    my $temp_file = "$folder/$file.tmp";
    print "Processing: $file\n";  # Log processing

    # Extract prefix before ".orthologs.fasta"
    (my $prefix = $file) =~ s/\.orthologs\.fasta$//;

    open(my $in, '<', $input_file) or warn "Cannot open $input_file: $! Skipping..." and next;
    open(my $out, '>', $temp_file) or warn "Cannot open $temp_file: $! Skipping..." and next;

    my $node_counter = 1;

    while (my $line = <$in>) {
        if ($line =~ /^>(\S+)/) {  # Match any FASTA header
            my $formatted_node = sprintf("%06d", $node_counter++);  # zero-pad to 6 digits
            print $out ">$prefix.$formatted_node\n";
        } else {
            print $out $line;
        }
    }

    close $in;
    close $out;
    move($temp_file, $input_file) or warn "Cannot overwrite $input_file: $!";
}

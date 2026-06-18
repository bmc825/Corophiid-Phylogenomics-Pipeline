#!/usr/bin/perl
use strict;
use warnings;
use File::Basename;
use Cwd;

# Ensure an input directory is provided
if (@ARGV != 1) {
    die "Usage: $0 <input_directory>\n";
}

my $input_dir = $ARGV[0];
my $output_dir = getcwd();  # Get the current working directory

# Hash to store sequences by species
my %species_sequences;

# Read all files in the directory
opendir(DIR, $input_dir) or die "Cannot open directory: $!";
my @files = grep { /\.fa$/ } readdir(DIR);
closedir(DIR);

foreach my $file (@files) {
    my $filepath = "$input_dir/$file";
    open(my $fh, '<', $filepath) or die "Cannot open file $filepath: $!";

    my ($species, $header, $seq);

    while (my $line = <$fh>) {
        chomp($line);

        if ($line =~ /^>(\w+)\|(.+)/) {
            # Store the previous sequence if it exists
            if ($species && $seq) {
                $seq =~ s/-//g;  # Remove dashes from sequence
                push @{$species_sequences{$species}}, ">$header\n$seq";
            }

            # Start a new header and sequence
            $species = $1;
            $header = "${species}_$2";  # Replace '|' with '_'
            $seq = "";
        } else {
            $seq .= $line;
        }
    }

    # Store the last sequence in the file
    if ($species && $seq) {
        $seq =~ s/-//g;
        push @{$species_sequences{$species}}, ">$header\n$seq";
    }

    close($fh);
}

# Write sequences to species-specific files in the current directory with .orthologs.fasta extension
foreach my $species (keys %species_sequences) {
    my $output_file = "$output_dir/${species}.orthologs.fasta";
    open(my $out_fh, '>', $output_file) or die "Cannot write to file $output_file: $!";

    print $out_fh join("\n", @{$species_sequences{$species}}) . "\n";

    close($out_fh);
}

print "Processing complete. Species-specific files created in $output_dir with .orthologs.fasta extension\n";

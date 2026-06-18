#!/usr/bin/perl
use strict;
use warnings;
use File::Basename;

# Usage: perl extract_refs_from_probes.pl probes.fasta OG_DIR output.fasta output.tsv

my ($probe_file, $og_dir, $output_fasta, $output_tsv) = @ARGV;
die "Usage: $0 probes.fasta OG_DIR output.fasta output.tsv\n" unless $output_tsv;

# Parse probes into hash
my %probes;
open(my $pfh, '<', $probe_file) or die "Can't open $probe_file: $!";
while (<$pfh>) {
    chomp;
    if (/^>(uce[-_]?\d+)_p\d+\s+\|taxon:(\w+),locus:([\w\.]+)/) {
        my ($uce, $taxon, $locus) = ($1, $2, $3);
        $uce =~ s/-/_/;
        $probes{"$taxon|$locus"} = $uce;
    }
}
close $pfh;

# Prepare output
open(my $tsv, '>', $output_tsv) or die "Can't write to $output_tsv: $!";
print $tsv "locusID\tuceID\ttaxon\tOG\n";

my %sequences;

# Process orthogroup files
opendir(my $dh, $og_dir) or die "Can't open $og_dir: $!";
my @files = grep { /\.fa(sta)?$/ } readdir($dh);
closedir $dh;

foreach my $file (@files) {
    my ($og) = $file =~ /(OG\d{7})/ or next;
    open(my $fh, '<', "$og_dir/$file") or die "Can't open $file: $!";

    my ($header, $seq) = ('', '');
    while (<$fh>) {
        chomp;
        if (/^>(\S+)/) {
            process_record($header, $seq, $og) if $header;
            $header = $1;
            $seq = '';
        } else {
            $seq .= $_;
        }
    }
    process_record($header, $seq, $og) if $header;
    close $fh;
}

close $tsv;

# Write reference FASTA
open(my $out, '>', $output_fasta) or die "Can't open $output_fasta: $!";
foreach my $header (sort {
    ($a =~ /uce_(\d+)/)[0] <=> ($b =~ /uce_(\d+)/)[0]
} keys %sequences) {
    print $out ">$header\n$sequences{$header}\n";
}
close $out;

sub process_record {
    my ($header, $seq, $og) = @_;
    my ($taxon, $locus) = split /\|/, $header;
    return unless $taxon && $locus;

    my $key = "$taxon|$locus";
    return unless exists $probes{$key};

    my $uce_id = $probes{$key};
    $seq =~ s/-//g;
    my $new_header = "${uce_id}_${taxon}_$og";

    $sequences{$new_header} = $seq;
    print $tsv "$locus\t$uce_id\t$taxon\t$og\n";

    delete $probes{$key};
}

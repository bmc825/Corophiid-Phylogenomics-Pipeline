#!/usr/bin/env perl
use strict;
use warnings;
use Getopt::Long;
use File::Basename;

# Input arguments
my ($cds_file, $blast_file, $taxon, $output_dir);
GetOptions(
    'cds=s'       => \$cds_file,
    'blast=s'     => \$blast_file,
    'taxon=s'     => \$taxon,
    'output-dir=s'=> \$output_dir,
) or die "Usage: $0 --cds file.fa --blast hits.tsv --taxon TaxonName --output-dir path\n";

# Load CDS sequences into hash
my %cds;
{
    local $/ = ">";
    open(my $fh, $cds_file) or die "Cannot open $cds_file: $!";
    <$fh>;  # skip first empty
    while (<$fh>) {
        chomp;
        my ($id, @seq) = split(/\n/, $_);
        my $seq = join("", @seq);
        $id =~ s/\s+.*//;  # keep only first token
        $cds{$id} = $seq;
    }
    close $fh;
}

# Parse BLAST output
open(my $blast, $blast_file) or die "Cannot open $blast_file: $!";
my %matches;
while (<$blast>) {
    chomp;
    my ($uce, $seqid, $pident, $length, $mismatch, $gapopen,
        $qstart, $qend, $sstart, $send, $evalue, $bitscore) = split(/\t/);

    # Normalize UCE name
    $uce =~ /(uce[_]?\d+)/ or next;
    $uce = $1;
    $uce =~ s/^uce(\d{1,3})$/sprintf("uce_%03d", $1)/e;

    # Extract coordinates
    my ($start, $end) = ($sstart < $send) ? ($sstart, $send) : ($send, $sstart);
    my $seq = substr($cds{$seqid}, $start - 1, $end - $start + 1);
    $seq = revcomp($seq) if $sstart > $send;

    # Format header: Taxon_uce_###. GENOME
    my $header = ">$taxon\_$uce. GENOME";

    push @{$matches{$uce}}, [$header, $seq];
}
close $blast;

# Write output files
mkdir $output_dir unless -d $output_dir;
foreach my $uce (keys %matches) {
    my $outfile = "$output_dir/${uce}.${taxon}.fasta";
    open(my $out, ">", $outfile) or die "Cannot write to $outfile: $!";
    foreach my $entry (@{$matches{$uce}}) {
        my ($header, $seq) = @$entry;
        print $out "$header\n$seq\n";
    }
    close $out;
}

sub revcomp {
    my ($dna) = @_;
    $dna =~ tr/ACGTacgt/TGCAtgca/;
    return scalar reverse $dna;
}

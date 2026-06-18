#!/usr/bin/perl
use strict;
use warnings;

my ($tsv_file, $aa_dir, $output_fasta) = @ARGV;

my %locus_map;
open(my $tfh, '<', $tsv_file) or die "Can't open $tsv_file: $!";
<$tfh>;
while (<$tfh>) {
    chomp;
    my ($locus, $uce, $taxon, $og) = split /\t/;
    $uce =~ s/-/_/;
    my $new_header = "${uce}_${taxon}_$og";
    $locus_map{$locus} = $new_header;
}
close $tfh;

my %sequences;

opendir(my $dh, $aa_dir) or die "Can't open directory $aa_dir: $!";
my @files = grep { /\.fa(sta)?$/ } readdir($dh);
closedir $dh;

foreach my $file (@files) {
    my $path = "$aa_dir/$file";
    open(my $fh, '<', $path) or die "Can't open $path: $!";

    my ($header, $seq) = ('', '');
    while (<$fh>) {
        chomp;
        if (/^>(\S+)/) {
            process_record($header, $seq) if $header;
            $header = $1;
            $seq = '';
        } else {
            $seq .= $_;
        }
    }
    process_record($header, $seq) if $header;
    close $fh;
}

# Sort and write output
open(my $out, '>', $output_fasta) or die "Can't write $output_fasta: $!";
foreach my $header (sort {
    ($a =~ /uce_(\d+)/)[0] <=> ($b =~ /uce_(\d+)/)[0]
} keys %sequences) {
    print $out ">$header\n$sequences{$header}\n";
}
close $out;

sub process_record {
    my ($header, $seq) = @_;
    my ($locus) = $header =~ /\|(.+)/;
    return unless defined $locus && exists $locus_map{$locus};
    $seq =~ s/-//g;
    $sequences{$locus_map{$locus}} = $seq;
}

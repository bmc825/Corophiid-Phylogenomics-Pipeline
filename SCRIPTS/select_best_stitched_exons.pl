#!/usr/bin/perl
use strict;
use warnings;
use File::Find;
use File::Path qw(make_path);

# Usage: perl select_best_by_uce.pl stitched_output_dir/ output_final_dir/

my ($base_dir, $outdir) = @ARGV;
die "Usage: $0 stitched_output_dir/ output_final_dir/\n" unless $base_dir && $outdir;

make_path($outdir) unless -d $outdir;

my %best_seqs;  # key = taxon|uce

find(\&process_file, $base_dir);

sub process_file {
    return unless -f $_ && /\.stitched_exons\.fasta$/;

    my $uce_file = $File::Find::name;

    # Extract UCE ID from the filename (e.g., uce_001 from uce_001_Cer_spp_OG0001610.stitched_exons.fasta)
    my ($uce_id) = $uce_file =~ m{/(uce_\d+)_};  # match uce_001 from filename

    unless ($uce_id) {
        warn "⚠️  Could not extract UCE ID from filename: $uce_file\n";
        return;
    }

    open my $fh, "<", $uce_file or die "Cannot open $uce_file: $!";

    local $/ = ">";
    while (<$fh>) {
        chomp;
        next unless /\S/;

        my ($header, @seq_lines) = split /\n/, $_;
        my $seq = join("", @seq_lines);
        $seq =~ s/\s+//g;

        # Extract taxon from header (up to first space or period)
        my ($taxon) = $header =~ /^([A-Za-z0-9_]+)[\.\s]/;
        unless ($taxon) {
            warn "⚠️  Could not parse taxon from header: $header\n";
            next;
        }

        my $key = "$taxon|$uce_id";

        if (!exists $best_seqs{$key} || length($seq) > length($best_seqs{$key}{seq})) {
            $best_seqs{$key} = {
                taxon  => $taxon,
                uce    => $uce_id,
                header => $header,     # preserve full original header
                seq    => $seq
            };
        }
    }

    close $fh;
}

# Group by UCE and write one file per UCE
my %uce_files;
foreach my $key (keys %best_seqs) {
    my $entry = $best_seqs{$key};
    push @{ $uce_files{ $entry->{uce} } }, $entry;
}

foreach my $uce (sort keys %uce_files) {
    my $filename = "$outdir/$uce.stitched_exons.fasta";
    open my $out, ">", $filename or die "Cannot write to $filename: $!";

    foreach my $entry (sort { $a->{taxon} cmp $b->{taxon} } @{ $uce_files{$uce} }) {
        print $out ">$entry->{header}\n$entry->{seq}\n";
    }

    close $out;
}

print "✅ Done: wrote one stitched exon file per UCE to $outdir/\n";

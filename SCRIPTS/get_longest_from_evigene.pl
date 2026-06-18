#!/usr/bin/perl

use strict;
use warnings; 
use JFR::Fasta;
use Data::Dumper;

MAIN: {
    my $fa  = $ARGV[0] or die "usage: $0 FASTA GENUS_SPECIES_CODE\n";
    my $pre = $ARGV[1] or die "usage: $0 FASTA GENUS_SPECIES_CODE\n";
    my $rh_seqs = get_longest_seqs($fa);
    foreach my $gid (sort keys %{$rh_seqs}) {
        print ">$pre|$rh_seqs->{$gid}->{'tid'}\n$rh_seqs->{$gid}->{'seq'}\n";
    }
}

sub get_longest_seqs {
    my $fa = shift;
    my $fp = JFR::Fasta->new($fa);
    my %seqs = ();
    while (my $rec = $fp->get_record()) {
        next if ($rec->{'def'} =~ m/utrorf /);
        my $len = length($rec->{'seq'});
        die "unexpected:$rec->{'def'}" unless ($rec->{'def'} =~ m/^>((\S+)t\d+)/);
        my $gid = $2;
        my $tid = $1;
        if ($seqs{$gid}) {
            next if ($len < $seqs{$gid}->{'len'});
            $seqs{$gid} = {'tid' => $tid, 'seq' => $rec->{'seq'}, 'len' => $len};
        } else {
            $seqs{$gid} = {'tid' => $tid, 'seq' => $rec->{'seq'}, 'len' => $len};
        }
    }
    return \%seqs;
}

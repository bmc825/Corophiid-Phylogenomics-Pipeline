#!/usr/bin/perl

# This script concatenates multiple sequence alignments into a single
# "concatenated" matrix

use strict;
use warnings;
use Getopt::Long;
use Pod::Usage;
use JFR::Fasta;
use Data::Dumper;

our $VERSION = 0.02;

MAIN: {
    my $rh_opts = process_options();
    my $ra_files = get_files($rh_opts);
    my ($ra_seqs, $rh_ids) = get_seqs($ra_files);
    print_concat($ra_seqs, $rh_ids);
    if ($rh_opts->{'partition'}) {
        print_part_file($ra_seqs, $rh_opts->{'partition'}, $ra_files);
    }
}

sub print_part_file {
    my ($ra_seqs, $out, $ra_files) = @_;

    open OUT, ">$out" or die "cannot open >$out:$!";
    my $pos = 1;
    for (my $i = 0; $i < @{$ra_seqs}; $i++) {
        my $rh_s = $ra_seqs->[$i];
        my $filename = $ra_files->[$i];
        $filename =~ s{.*/}{};  # Remove directory path if present
        $filename =~ s/\.[^.]+$//;  # Remove file extension

        # Use the filename directly as the partition name
        my $partition_name = $filename;

        my $len = get_seq_len($rh_s);
        my $end = $pos + $len - 1;
        print OUT "DNA, $partition_name = $pos-$end\n";
        $pos += $len;
    }
    close OUT;
}

# Sub to print concatenated sequences, with added debugging
sub print_concat {
    my $ra_seqs = shift;
    my $rh_ids = shift;

    # Debugging: Print the keys of $rh_s to check sequence IDs
    foreach my $seq_hash (@{$ra_seqs}) {
        print "Keys in rh_s:\n";
        foreach my $key (keys %{$seq_hash}) {
            print "Key: $key\n";  # Check what keys are present
        }
    }

    foreach my $id (sort keys %{$rh_ids}) {
        next unless defined $id;  # Skip if $id is undefined
        print ">$id\n";

        # Flag to track if sequences are missing for any ID
        my $sequences_found = 0;

        foreach my $rh_s (@{$ra_seqs}) {
            # Trim any leading/trailing whitespace from the ID and the sequence data
            $id =~ s/^\s+|\s+$//g;

            # Fetch the sequence length
            my $len = get_seq_len($rh_s, $id);

            # If length is undefined, set to 0
            if (!defined $len) {
                warn "Warning: Undefined length for sequence with ID: $id\n";
                $len = 0;
            }

            # Create a sequence of dashes of the same length
            my $dashes = '-' x $len;

            # Check if the sequence exists in the hash for this ID
            if (defined $rh_s->{$id}) {
                print $rh_s->{$id};
                $sequences_found = 1;
            } else {
                print $dashes;
            }
        }
        print "\n";

        # If no sequences found for this ID, print a warning
        if (!$sequences_found) {
            warn "Warning: No sequence found for ID: $id\n";
        }
    }
}

# Sub to get the length of a sequence for the given ID
sub get_seq_len {
    my ($rh_s, $id) = @_;

    # Ensure no extra spaces in the ID key
    $id =~ s/^\s+|\s+$//g;

    # Check if the sequence exists in the hash for the given ID
    if (!defined $rh_s->{$id}) {
        warn "Warning: No sequence found for ID: $id in get_seq_len\n";
        return undef;
    }

    # Get the length of the sequence
    my $len = length($rh_s->{$id});
    return $len;
}



sub get_seqs {
    my $ra_files = shift;
    my @seqs = ();
    my %ids = ();
    my $count = 0;
    foreach my $f (@{$ra_files}) {
        my $fp = JFR::Fasta->new($f);
        my $len = 0;
        my %fileseqs = ();
        while (my $rec = $fp->get_record()) {
            my $id = JFR::Fasta->get_def_w_o_gt($rec->{'def'});
            print STDERR "Parsed ID: ", (defined $id ? $id : 'UNDEFINED'), "\n";  # Debugging line
            $ids{$id}++ if defined $id;  # Only store if $id is defined
            $fileseqs{$id} = $rec->{'seq'} if defined $id;
            $count++;
            if ($len && $len != length($rec->{'seq'})) {
                die "seqs in each fa must be same length. unequal in $f";
            }
        }
        push @seqs, \%fileseqs;
    }
    die "no shared ids in fasta files\n" if ($count == scalar(keys(%ids)));
    return \@seqs, \%ids;
}

sub get_files {
    my $rh_o = shift;
    my @files = ();
    if ($rh_o->{'fasta'}) {
        foreach my $f (@{$rh_o->{'fasta'}}) {
            push @files, $f;
        }
        my $num = scalar @files;
        die "need more than $num --fasta" unless ($num > 1);
    } elsif ($rh_o->{'dir'}) {
        opendir(my $dh, $rh_o->{'dir'}) || die "cant opendir $rh_o->{'dir'}:$!";
        my @filenames = grep { !/^\./ && -f "$rh_o->{'dir'}/$_" } readdir($dh);
        closedir $dh;
        foreach my $fn (@filenames) {
            push @files, "$rh_o->{'dir'}/$fn";
        }
        my $num = scalar @files;
        die "need more than $num files in $rh_o->{'dir'}" unless ($num > 1);
    } else {
        die "unexpected";
    }
    return \@files;
}

sub process_options {
    my $rh_opts = {'dir' => ''};
    my @fasta = ();
    my $res = Getopt::Long::GetOptions(
        "dir=s" => \$rh_opts->{'dir'},
        "fasta=s" => \@fasta,
        "partition=s" => \$rh_opts->{'partition'},
        "version" => \$rh_opts->{'version'},
        "v" => \$rh_opts->{'version'},
        "h" => \$rh_opts->{'help'},
        "help" => \$rh_opts->{'help'}
    );
    $rh_opts->{'fasta'} = \@fasta if (@fasta);
    die "fasta2phylomatrix version $VERSION\n" if ($rh_opts->{'v'} || $rh_opts->{'version'});
    pod2usage({-exitval => 0, -verbose => 2}) if ($rh_opts->{'help'});

    unless ($rh_opts->{'dir'} || $rh_opts->{'fasta'}) {
        warn "--dir or --fasta are necessary options\n";
        usage();
    }
    if ($rh_opts->{'dir'} && $rh_opts->{'fasta'}) {
        warn "don't use both of these options: --dir --fasta";
        usage();
    }
    return $rh_opts;
}

sub usage {
    print "fasta2phylomatrix  {--fasta=FILE1 --fasta=FILE2 ... or --dir=DIR_OF_FASTAFILES} [--partition=OUT_PARTITION_FILE] [--version] [--help]\n";
    exit;
}

__END__

=head1 NAME

B<fasta2phylomatrix> - Generate a concatenated matrix from individual alignments

=head1 AUTHOR

Joseph Ryan <joseph.ryan@whitney.ufl.edu>

=head1 SYNOPSIS

fasta2phylomatrix  {--fasta=FILE1 --fasta=FILE2 ... or --dir=DIR_OF_FASTAFILES} [--partition=OUT_PARTITION_FILE] [--version] [--help]

=head1 BUGS

Please report them to the author.

=head1 COPYRIGHT

Copyright (C) 2017, Joseph Ryan

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.

=cut

use strict;
use warnings;
use File::Basename;

# Check command line arguments
if (@ARGV != 3) {
    die "Usage: perl generate_select_files.pl <input_directory> <output_directory> <exclude_taxa_file>\n";
}

my ($input_dir, $output_dir, $exclude_file) = @ARGV;

# Read the exclude taxa file into a hash for quick lookup
my %exclude_taxa;
open(my $exclude_fh, '<', $exclude_file) or die "Could not open '$exclude_file' $!";
while (my $line = <$exclude_fh>) {
    chomp $line;
    $line =~ s/^\s+|\s+$//g;  # Trim whitespace
    $exclude_taxa{lc($line)} = 1;  # Store in hash for quick lookup in lowercase
}
close($exclude_fh);

# Print excluded taxa for debugging
print "Excluding taxa:\n" . join(", ", keys %exclude_taxa) . "\n";

# Process each .fa file in the input directory
opendir(my $dir, $input_dir) or die "Cannot open directory: $!";
while (my $file = readdir($dir)) {
    next unless ($file =~ /\.fa$/);  # Only process .fa files

    my $input_file = "$input_dir/$file";
    (my $orthogroup_name = $file) =~ s/\.fa$//;  # Extract the orthogroup name from the file name
    my $output_file = "$output_dir/select_file_${orthogroup_name}.tsv";  # Create output file with orthogroup name

    open(my $in_fh, '<', $input_file) or die "Could not open '$input_file' $!";
    open(my $out_fh, '>', $output_file) or die "Could not open '$output_file' $!";

    my $contig_name = '';
    my $sequence = '';

    while (my $line = <$in_fh>) {
        chomp $line;

        if ($line =~ /^>(.+)/) {
            # Process the previous contig if it exists
            if ($contig_name && $sequence ne '') {
                process_contig($contig_name, $sequence, $out_fh);
            }
            # Start a new contig
            $contig_name = $1;  # Extract contig name
            $sequence = '';      # Reset sequence
        } else {
            # Concatenate sequence lines
            $sequence .= $line;
        }
    }
    # Process the last contig
    if ($contig_name && $sequence ne '') {
        process_contig($contig_name, $sequence, $out_fh);
    }

    close($in_fh);
    close($out_fh);
}
closedir($dir);

sub process_contig {
    my ($contig_name, $sequence, $out_fh) = @_;

    # Split contig name into taxa and gene
    my ($taxa_name) = split(/\|/, $contig_name);

    # Trim any leading/trailing whitespace
    $taxa_name =~ s/^\s+|\s+$//g;

    # Exclude if taxa is in the exclude list (check case sensitivity)
    if (exists $exclude_taxa{lc($taxa_name)}) {
        return;  # Skip this contig if it's in the exclude list
    }

    # Determine the first nucleotide base (including dashes) and sequence length (including dashes)
    my $first_base = substr($sequence, 0, 1);  # Get the first character of the sequence
    my $length = length($sequence);  # Length including dashes

    # Determine the sequence direction based on the contig name
    my $direction = (substr($contig_name, -1, 1) eq 'R') ? 'R' : 'F';

    # Determine the first base output
    my $first_base_output;
    if ($first_base =~ /^[ACTG]$/) {
        $first_base_output = '1';  # Nucleotide
    } elsif ($first_base =~ /^[ARNDCEQGHILKMFPSTWYV]$/) {
        $first_base_output = '1';  # Amino acid
    } elsif ($first_base eq '-') {
        $first_base_output = '-';   # Dash
    } else {
        $first_base_output = '0';    # Not a recognized nucleotide or amino acid
    }

    # Write to output file
    print $out_fh join("\t", $contig_name, $direction, $first_base_output, $length), "\n";
}

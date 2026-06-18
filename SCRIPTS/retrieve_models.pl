#!/usr/bin/perl
use strict;
use warnings;
use Getopt::Long;

# Command-line options
my $input_partition_file;
my $output_partition_file;
my $log_files_dir;

GetOptions(
    'input=s'  => \$input_partition_file,
    'output=s' => \$output_partition_file,
    'logs=s'   => \$log_files_dir,
) or die "Error in command line arguments\n";

# Check that all required options are provided
die "Usage: $0 --input <input_partition_file> --output <output_partition_file> --logs <log_files_directory>\n"
    unless $input_partition_file && $output_partition_file && $log_files_dir;

# Hash to store partition models
my %partition_models;

# Read model from log files and store them in a hash
opendir(my $dh, $log_files_dir) or die "Cannot open directory $log_files_dir: $!";
while (my $file = readdir($dh)) {
    next unless $file =~ /^(OG\d+).*\.log$/;  # Match files with orthogroup name and .log extension
    my $partition_name = $1;
    my $file_path = "$log_files_dir/$file";

    open(my $log_fh, '<', $file_path) or die "Cannot open log file $file_path: $!";
    while (my $line = <$log_fh>) {
        if ($line =~ /Best-fit model:\s*([\w\+\-]+)\s+chosen according to BIC/) {
            $partition_models{$partition_name} = $1;
            last;
        }
    }
    close($log_fh);
}
closedir($dh);

# Open the input partition file and output partition file
open(my $in_fh, '<', $input_partition_file) or die "Cannot open input partition file $input_partition_file: $!";
open(my $out_fh, '>', $output_partition_file) or die "Cannot open output partition file $output_partition_file: $!";

# Copy input partition content to output and collect partitions
my @partitions;
while (my $line = <$in_fh>) {
    # Modify the regex to match OG numbers, even if they are part of a longer string
    if ($line =~ /^charset\s+.*(OG\d+)\s+=\s+(\d+-\d+);/) {
        my $partition_name = $1;  # Capture the OG number (e.g., OG0004674)
        print $out_fh $line;  # Write charset lines to output

        # Check if a model exists for this partition
        if (exists $partition_models{$partition_name}) {
            push @partitions, "$partition_models{$partition_name}:$partition_name";
        } else {
            warn "Model not found for partition $partition_name\n";
        }
    } elsif ($line =~ /^end;/i) {
        # Skip the "end;" line in the input file
        next;
    } else {
        print $out_fh $line;  # Print other lines as they are
    }
}

# Write the charpartition line and add "end;"
print $out_fh "charpartition mine = ", join(", ", @partitions), ";\nend;\n";

# Close file handles
close($in_fh);
close($out_fh);

print "Partition file with models has been generated: $output_partition_file\n";

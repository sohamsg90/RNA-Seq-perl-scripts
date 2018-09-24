#!/usr/bin/perl
#looks for a patter in multifasta file
#Modify input file and patterns
use strict;
use warnings;

#print STDOUT "Enter the motif: ";
#my $motif = "TGATAG";
#chomp $motif;
open OUT, ">present.txt" or die;
my %seqs = %{ read_fasta_as_hash( 'data.fa' ) };
foreach my $id ( keys %seqs ) {
	#Need to edit Strings and conditions for modified use
    if ( $seqs{$id} =~ /(TGATAA|AGATAA|AGATAG|TGATAG)/)  { #pattern
        print OUT $id, "\n";
        print OUT $seqs{$id}, "\n";
    }
}

sub read_fasta_as_hash {
    my $fn = "Multifasta_file.fasta";#multifasta input file

    my $current_id = '';
    my %seqs;
    open FILE, "<$fn" or die $!;
    while ( my $line = <FILE> ) {
        chomp $line;
        if ( $line =~ /^(>.*)$/ ) {
            $current_id  = $1;
        } elsif ( $line !~ /^\s*$/ ) { # skip blank lines
            $seqs{$current_id} .= $line
        }
    }
    close FILE or die $!;

    return \%seqs;
}

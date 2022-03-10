#usr/bin/perl -w
use Data::Dumper qw(Dumper);


@ARGV == 2 or die "usage: $0 <cluster_file> <main_list>\n";

my ($cluster_file, $list_of_genes) = @ARGV;
my $output = "common_genes.txt";

open IN1, '<', $cluster_file or die "Can't read from cluster file\n";
open IN2, '<', $list_of_genes or die "Can't read from list file\n";
open OUT, '>', $output or die "Can't open output file\n";
my @cluster = <IN1>;
my @maingenelist = <IN2>;
my $count = 0;
foreach my $j (@cluster){
	chomp $j;
	foreach my $i (@maingenelist){
	chomp $i;
		if ($i =~ m/$j/){
			$count++;
			print OUT "$i\n";
			}
			}
			}
my $sizeofgenecluster = $#cluster+1;
my $sizeofmaingenelist = $#maingenelist+1;
print "Size of file1 should be ALWAYS smaller that file2\n";
print "Size of gene cluster(file1) = $sizeofgenecluster \n";
print "Size of main gene list(file2) = $sizeofmaingenelist \n";
print "No. of common genes = $count \n";
my $percentage = ($count/$sizeofgenecluster)*100;
print "percentage = $percentage \n";
#printf " to copy = $count ('%.2f'.$percentage %)\n";

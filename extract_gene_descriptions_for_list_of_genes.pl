#usr/bin/perl -w
#Usage: perl extract_gene_descriptions_for_list_of_genes.pl <gene list> <gene description>
#Gene description file can be downloaded from TAIR website. Should have two columns: Gene and description.
$file1 = $ARGV[0];#gene list
$file2 = $ARGV[1];#gene description

open IN, $file1 or die;
open IN2, $file2 or die;
open OUT, ">$file1\_gene_description.txt" or die;
print OUT "gene_id\tGene_description\n";
my @f1 = <IN>; #takes each line as array element
my @f2 = <IN2>;

foreach my $l1 (@f1){
		chomp $l1;
		next if $l =~ /^g|G.+/;
		my @line1 = split(/\t/, $l1);
		foreach my $l2 (@f2){
			chomp $l2;
			next if $l =~ /^g|G.+/;
			my @line2 = split(/\t/, $l2);
			if ($line1[0] =~ m/$line2[0]/ ){
				print OUT "$line1[0]\t$line2[1]\n";
				}
				}
				}
				







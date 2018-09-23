#usr/bin/perl -w
#Usage: perl extract_everything_major_file_joiners_rnaseq.pl <DESeq2 output file> <average normalized counts file> <gene description>
#DESeq2 output file: default file should be used
#average normalized counts file: Normalized counts obtained from DESeq2 using "Counts" command and averaged over samples.
#Gene description file can be downloaded from TAIR website. Should have two columns: Gene and description.

$file1 = $ARGV[0];#deseq2 output file
$file2 = $ARGV[1];#average normalized count file
$file3 = $ARGV[2];#gene description file
open IN, $file1 or die;
open IN2, $file2 or die;
open IN3, $file3 or die;
my @f1 = <IN>; 
my @f2 = <IN2>;
my @f3 = <IN3>;


open OUT, ">$file1\_upregulated.txt" or die;
print OUT "gene_id\tCount_Col\tCount_NEET12\tFoldChange\tGene_description\n";#Needs to be changed as and when needed
open OUT2, ">$file1\_downregulated.txt" or die;
print OUT2 "gene_id\tCount_Col\tCount_NEET12\tFoldChange\tGene_description\n";#Needs to be changed as and when needed


my %gene_description;
foreach my $line3 (@f3){
		chomp;
		my @line3 = split(/\t/, $line3);	
		$gene_description{$line3[0]} = $line3[2];
		}

#print Dumper \%gene_description;
foreach my $l1 (@f1){
		chomp $l1;
		next if $l1 =~ /^basemean/;
		my @line1 = split(/\t/, $l1);
		foreach my $l2 (@f2){
				chomp $l2;
				next if $l2 =~ /^genes/;
				my @line2 = split(/\t/, $l2);
				if ($line1[0] =~ m/$line2[0]/ ){
						my $key = $line1[0];
						my $value = $gene_description{$key};
						my $foldchange = ($line2[3]/$line2[1]) if $line2[1];#Needs to be changed as and when needed
						
						if ($line1[2] >= 0){
							
							print OUT "$line1[0]\t$line2[1]\t$line2[3]\t$foldchange\t$value\n";
								}								
						else{
							
							print OUT2 "$line1[0]\t$line2[1]\t$line2[3]\t$foldchange\t$value\n";
								}
				}
		}
		print "$line1[0] done\n";
}

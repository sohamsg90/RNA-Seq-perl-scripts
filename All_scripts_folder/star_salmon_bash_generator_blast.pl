#usr/bin/perl -w
use Data::Dumper;
#### Change: $i value, check folder links; check folder names; check rm command**** #####

$file = $ARGV[0];
open IN, $file or die;
@file1 = <IN>;

open OUT, ">RNA_seq_STAR_SALMON_soham.sh" or die;
# open OUT, ">RNA_seq_raw_files_blast.sh" or die;
$j = 13;
# for ($i = 1; $i<=48; $i++)
my %filename;
for (my $i = 0; $i < scalar(@file1);$i = $i+4)
	{
		chomp ($file1[$i], $file1[$i+1],$file1[$i+2] ,$file1[$i+3]);
		my @a = split ("\t", $file1[$i]);
		my @b = split ("\t", $file1[$i+1]);
		my @c = split ("\t", $file1[$i+2]);
		my @d = split ("\t", $file1[$i+3]);
		$filename{$j}{"a"} = $a[1];
		$filename{$j}{"b"} = $b[1];
		$filename{$j}{"c"} = $c[1];
		$filename{$j}{"d"} = $d[1];
		$j++;
	}
# print $j,"\n";
# print OUT Dumper \%filename;
# my $x = 1;
foreach my $sample (sort keys %filename)
	{
		print $sample,"\n";
		my $a = $filename{$sample}{'a'};
		my $b = $filename{$sample}{'b'};
		my $c = $filename{$sample}{'c'};
		my $d = $filename{$sample}{'d'};
		# print OUT "mkdir STAR_Alignment$sample\n";
		# print OUT "cd STAR_Alignment$sample\n";
		print OUT "cat $a $c > Read1.fastq.gz\n";
		print OUT "cat $b $d > Read2.fastq.gz\n";
		print OUT "STAR --runThreadN 54 --readFilesCommand zcat --quantMode GeneCounts --genomeDir /storage/scratch2/ss1293/15.Yosef_RNASeq_MYB30/Arabidopsis_genomeTAIR10/genome_index  --outFileNamePrefix STAR_Alignment$sample/ --readFilesIn STAR_Alignment$sample/Read1.fastq.gz STAR_Alignment$sample/Read2.fastq.gz\n";
		# print OUT "magicblast -query Read1.fastq.gz -query_mate Read2.fastq.gz -db bar -infmt fastq -out S$sample\_output_blasthits.txt -num_threads 27 -outfmt tabular -no_unaligned\n";
		print OUT "rm Read*.fastq.gz \n";
		print OUT "echo \"done STAR S$sample \"\n\n";

	}
=c
foreach my $i (@file1)
	{
		chomp $i;

		#print OUT "mkdir $i\n";
		#print OUT "cp /media/sohamsengupta/DATAPART1/RNAseq_Sara_Jun2018/FASTQ_files_2018-06-15/$i*/$i\_L00*/*  /media/sohamsengupta/DATAPART1/RNAseq_Sara_Jun2018/STAR_SALMON_DESEQ2/$i -R \n";
		#print OUT "cd /media/sohamsengupta/DATAPART1/RNAseq_Sara_Jun2018/STAR_SALMON_DESEQ2/$i\n";
		#print OUT "cat *.fastq.gz > $i.fastq.gz\n";
		#print OUT "rm 1Col*.fastq.gz\n";
		#print OUT "rm 2Col*.fastq.gz\n";
		#print OUT "rm 3Col*.fastq.gz\n";

		# print OUT "mkdir FASTqc\n";
		# print OUT "/home/sohamsengupta/Downloads/FastQC/fastqc /media/sohamsengupta/DATAPART1/RNAseq_Sara_Jun2018/STAR_SALMON_DESEQ2/$i/$i.fastq.gz\n";
		# print OUT "mv $i\_fastqc* FASTqc\n";
		# print OUT "cd FASTqc\n";
		# print OUT "unzip *.zip\n";
		# print OUT "rm *.zip\n";
		# print OUT "cd ..\n";
		# print OUT "echo \"Fastqc performed\"\n";

		print OUT "mkdir STAR_Alignment$j\n";
		print OUT "STAR --runThreadN 54 --readFilesCommand zcat --quantMode GeneCounts --genomeDir /storage/scratch2/ss1293/15.Yosef_RNASeq_MYB30/Arabidopsis_genomeTAIR10/genome_index  --outFileNamePrefix STAR_Alignment$j/ --outFilterMismatchNmax 5 --readFilesIn /storage/scratch2/ss1293/22.Yosef_RNAseq_PhyB//storage/scratch2/ss1293/22.Yosef_RNAseq_PhyB/RAW_fastq/$i\n";
		print OUT "echo \"done STAR S$j \"\n\n";
		$j++;
		# print OUT "mkdir SALMON_quants\n";
		# print OUT "salmon quant -i /media/sohamsengupta/DATAPART1/RNAseq_Sara_Oct2017/Arabidopsis_transcriptomeTAIR10/athal_index -l A -r $i.fastq.gz -p 4 -o SALMON_quants/ \n";
		# print OUT "echo \"done SALMON $i \"\n";
		# print OUT "rm *.fastq.gz\n";
		# print OUT "cd ..\n\n"

		}

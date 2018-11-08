#Author:Qianqian Zhang
#!usr/bin/perl -w
use strict;
use warnings;


my $FILE1=$ARGV[0];
#"rdc_old";

my $FILE2=$ARGV[1];
#"rdc_new";

my $FILE3=$ARGV[2];
#IBD_10kb_chr3

my $FILE4=$ARGV[3];
#IBD_10kb_chr3_true



my $FILE8=$ARGV[4];
#IBD_10kb_trueIBD_chr3_oldnew
#(count per 10kb: number of true IBD/total number of pairwise comparison for all pairwised old rdc and new rdc)


my $FILE9=$ARGV[5];
#IBD_10kb_trueIBD_chr3_oldold
#(count per 10kb: number of true IBD/total number of pairwise comparison for all pairwised old rdc and new rdc)


my $FILE10=$ARGV[6];
#IBD_10kb_trueIBD_chr3_newnew
#(count per 10kb: number of true IBD/total number of pairwise comparison for all pairwised old rdc and new rdc)




open FILE1, $FILE1 or die "Cannot open file\n";

my @oldrdc;
while(<FILE1>){
        chomp;
	push(@oldrdc,$_);        
        }

close FILE1;


open FILE2, $FILE2 or die "Cannot open file\n";

my @newrdc;
while(<FILE2>){
        chomp;
	push(@newrdc,$_);        
        }

close FILE2;



open FILE3, $FILE3 or die "Cannot open file\n";

my @totalIBD;
while(<FILE3>){
	#print $line,"\n";
	chomp;
	push(@totalIBD,$_);  
}
close FILE3;





open FILE4, $FILE3 or die "Cannot open file\n";

my @trueIBD;
while(<FILE4>){
	chomp;
	push(@trueIBD,$_);   
}
close FILE4;






my $number;
$number = scalar(@trueIBD);
my $endbinline;
$endbinline = $trueIBD[$number-1];
print $endbinline,"\n";
my @endbinn;
@endbinn = split("\t",$endbinline);



my $endbin="";
$endbin = $endbinn[3];
print $endbin,"\n";












open WRD,  ">", $FILE8;
open WRE,  ">", $FILE9;
open WRF,  ">", $FILE10;



my $oldn=0;
my $newn=0;
my $oldnewn=0;


for (my $i=0;$i<=$endbin;$i=$i+10000) {
	foreach my $line (@trueIBD){
		my @stringg = split("\t",$line);
		if ($stringg[3] == $i) {
			foreach my $oldrdcc (@oldrdc){
				foreach my $newrdcc (@newrdc) {
					if (($stringg[0] eq $oldrdcc) && ($stringg[1] eq $newrdcc)){
						$oldnewn++;
					} 
					elsif (($stringg[0] eq $newrdcc) && ($stringg[1] eq $oldrdcc)) {
						$oldnewn++;
					}
				}
				foreach my $oldrdccc (@oldrdc) {
					if (($stringg[0] eq $oldrdcc) && ($stringg[1] eq $oldrdccc)){
						$oldn++;
					}
					elsif (($stringg[0] eq $oldrdccc) && ($stringg[1] eq $oldrdcc)) {
						$oldn++;
					}
				}
			}
			foreach my $newrdccc (@newrdc){
				foreach my $newrdcccc (@newrdc) {
					if (($stringg[0] eq $newrdccc) && ($stringg[1] eq $newrdcccc)){
						$newn++;
					}
					elsif (($stringg[0] eq $newrdcccc) && ($stringg[1] eq $newrdccc)) {
						$newn++;
					}
				}
			}
		}
	}
	print WRD $i,"\t",$oldnewn,"\n";
	print WRE $i,"\t",$oldn,"\n";
	print WRF $i,"\t",$newn,"\n";
	$oldn=0;
	$newn=0;
	$oldnewn=0;
}
















close WRD;
close WRE;
close WRF;





































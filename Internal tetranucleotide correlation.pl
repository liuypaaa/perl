#!/usr/bin/perl


open bc, "<","xx/xx/xx/xx" or die;# import the sequence here, of which the internal tetrancleotide correlation need to be done
my @one=<bc>;
close bc;
shift(@one);
chomp(@one);
$one=join '',@one;
@sequence=split(//,$one);
my $seqstep=0;
my @zscore;
my $fragnumber=0;
my @seq;
while($seqstep<($#sequence-400)){
	$fragment=substr($one,$seqstep,300);
	@seq=split(//,$fragment);
	@{$sumxx[$fragnumber]}=&frequencyz(@seq);
	$seqstep+=300;
	$fragnumber+=1;
	}

my $abc=0;
my $xyz=0;
open ab, ">","xx/xx/xx/xx" or die;# export the correlation matrix, and this would be used for further plot
while($abc<$fragnumber){
	$xyz=0;
	while($xyz<$fragnumber){
		$corrr[$abc][$xyz]=&pearson(\@{$sumxx[$abc]},\@{$sumxx[$xyz]});
		print ab $corrr[$abc][$xyz];
		print ab ",";
		$xyz+=1;
		}
	print ab "\n";
	$abc+=1;
}

close ab;



sub frequencyz{# a sub for calculating the z score
my @x= @_;
open (FILE,"</users/yunpeng/documents/Myscripts/tetranucleotide.txt") or die;# please import the file "tetrancleotide.txt" as the resources of 256 tetranucleotide,this file was included in the folder
my $tetranucleotidex=<FILE>;
close FILE;
my @tetranucleotide=split(",",$tetranucleotidex);
foreach(@tetranucleotide){

	}
my $step=0;
my @count=();
while($step<($#x-2)){
my @window=($x[$step],$x[$step+1],$x[$step+2],$x[$step+3]);
my $window=join("",@window);
my $stepp=0;
	foreach my $single(@tetranucleotide){
	if(lc($window) eq lc($single)){
	$count[$stepp]+=1;
	}
	$stepp+=1;
	}
$step+=1;
	}
	
my @complementsequence;
foreach(@x){
if($_ eq "a"){
push (@complementsequence,"t");
}else{if ($_ eq "c"){
push (@complementsequence,"g");
}else{if($_ eq "g"){
push (@complementsequence,"c");
}else{if($_ eq "t"){
push (@complementsequence,"a");
}
}
}
}
}
my @reversesequence=reverse @complementsequence;
$step=0;
my @countreverse=();
while($step<($#reversesequence-2)){
@window=($reversesequence[$step],$reversesequence[$step+1],$reversesequence[$step+2],$reversesequence[$step+3]);
$window=join("",@window);
$stepp=0;
	foreach my $single(@tetranucleotide){
	if($window eq $single){
	$countreverse[$stepp]+=1;
	}
	$stepp+=1;
	}
$step+=1;
	}


my $n=0;
my @sum=();
while($n<256){
$sum[$n]=$count[$n]+$countreverse[$n];
$n+=1;

}
return @sum;

}

sub pearson($){
        my ($ref_a,$ref_b) = @_;
        my @x = @{$ref_a};
        my @y = @{$ref_b};
        my $N;
if($#x==$#y){
$N = $#x;
print "N = $N\n"; 
my $sum_sq_x = 0;
my $sum_sq_y = 0;
my $sum_coproduct = 0;
my $mean_x = $x[1];
my $mean_y = $y[1];
for($i=2;$i<=$N;$i++){
     $sweep = ($i - 1.0) / $i;
     $delta_x = $x[$i] - $mean_x;
     $delta_y = $y[$i] - $mean_y;
     $sum_sq_x += $delta_x * $delta_x * $sweep;
     $sum_sq_y += $delta_y * $delta_y * $sweep;
     $sum_coproduct += $delta_x * $delta_y * $sweep;
     $mean_x += $delta_x / $i;
     $mean_y += $delta_y / $i;
}
$pop_sd_x = sqrt( $sum_sq_x );
$pop_sd_y = sqrt( $sum_sq_y );
$cov_x_y = $sum_coproduct;
$correlation = $cov_x_y / ($pop_sd_x * $pop_sd_y);
print $correlation;
print "\n";
return $correlation;
exit(0);
}
print "PASS!\n";
exit(1);

}


	




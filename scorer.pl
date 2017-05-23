#!/usr/bin/perl

# This is an application to determine the accuracy of decision-list.pl,it runs
# as follows:   Perl scorer.pl my-line-answers.txt line-key.txt
#
# The program first opens both the answers file (my-line-answers.txt) and the key
# file (line-key.txt).  Then it builds arrays for each of those files to be 
# compared.  Each instance's sense is compared one at a time, and a total score 
# is compiled, as well as a confusion matrix of determined and correct senses.
# Those are then printed to STDOUT, and are displayed below for easy viewing
#
#
#
#
#=============================================================
#
#  score of decision list program is 88.2 percent
#  score from most likely tag baseline is 57.4 percent
#
#=============================================================
#          |product| phone | 
# —————————+———————+———————+  
#  product |  49   |   5   |
# —————————+———————+———————+  
#    phone |  10   |   63  |  
# —————————+———————+———————+  


use Data::Dumper;
#grab command line arguments for files
$file0 = @ARGV[0];
$file1 = @ARGV[1];


#open answers file
open(my $answers, '<:encoding(UTF-8)', $file0)
 or die "coult not open file '$file0' $!";

#open key file
open(my $keys, '<:encoding(UTF-8)', $file1)
 or die "coult not open file '$file1' $!";
# read key file
my @key;
while (my $line=<$keys>){
	chomp $line;
	@arr = split/\>\</, $line;
	push @key, @arr;}

#read answer file@answer;
while (my $row=<$answers>){
	chomp $row;
	@arr = split/\>\</,$row;
	push @answer, @arr;
}
# initialize confusion matrix%confusion;

# clean up key file, keeping only senses
for my $i(0 .. $#key+1){
	$phr = @key[$i];
	$phr=~m/senseid="(.*)"/;
	@key[$i] = $1;
}

# number correct$corr;
# compare key file to senses from answer file
for my $i(0 .. $#answer+1){
	$phr = @answer[$i];
	$phr=~m/senseid="(.*)"/;
	if ($1 eq @key[$i]){
		$corr++;
	}
	$confusion{@key[$i]}{$1}++;
}

#determine and print score
$score = $corr/($#key+1);
print "$score\n\n\n";

#print matrix headers
my @alltags;
print "       ";
while (my $key = each(%confusion)){
	if ($key=~m/.+/){
		push(@alltags, $key);
		print "$key | "; #print each tag as top row
	}
}
print "\n";
#print matrix
for $i (0 .. $#alltags){
	#print side labels for senses
	print "$alltags[$i]  |  ";
    for $j (0 .. $#alltags){
        if (exists $confusion{$alltags[$i]}{$alltags[$j]}){
	    #gets numbers of each assigned sense and key sense
            print  $confusion{$alltags[$i]}{$alltags[$j]};
        }
        else{
	    #fills in zeroes for when there isn't an intersection of senses on the matrix
            print "0";
        }
        print "  |  ";	#spacing lines for easy reading
    }
    print "\n";
}

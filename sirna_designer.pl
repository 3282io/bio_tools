#! /usr/bin/env perl
# Author: Andy Richardson, 2013-02-28
#
#
########################################
use warnings;
use strict;

print "\nSimple siRNA designer using Tushl's rules.\n";
print "\nPlease enter gene sequence now (control D to exit STDIN): \n";

chomp (my @sequence = <STDIN>);

my $sequence = join ('', @sequence);
#print "$sequence\n";

$sequence =~ s/[0-9]/ /g;
#print "*$sequence*\n";

$sequence =~ s/ //g;
#print "**$sequence**\n";

my @sequence2 = split(//, $sequence);

my $count = 0;

my %hash = ();

my (@working_sirna_sequence, @sirna_list);

my ($start_position, $end_position, $position_sirna, $gc, $sirna, $gc_percent, $gc_percent_rounded);

foreach my $nucleotide(@sequence2){
	$count++;
	if ($count > 49){
		push(@working_sirna_sequence, $nucleotide); 
	}
}

my $working_sirna_sequence = join ('', @working_sirna_sequence);

while ($working_sirna_sequence =~ m/(AA.{19}?)/ig){
	$start_position = $-[0] + 50;
	$end_position = $+[0] + 49;
	$position_sirna = $start_position." ".$1;
	$position_sirna =~ s/t/u/ig;
	push (@sirna_list, $position_sirna);
	#print "$start_position $1 $end_position \n";
	next;
}

print "\n\nMatching siRNA targets: \n\n";
foreach $sirna(@sirna_list){
	$gc = 0;
	while ($sirna =~ m/[gc]/ig){
		$gc++;
		next;
	}
	if ($gc > 10){
		$gc_percent = $gc/21*100;
		$gc_percent_rounded = sprintf("%.1f", $gc_percent);
		print "$sirna...GC = $gc_percent_rounded %\n";
	}	
}

my $end_point = $count - 100;
print "\n\n  LAST POSITION ==> $count\n\n**RECOMMENDED TO NOT USE ANY WITHIN 100 NTs FROM LAST POSITION**\n\n\n";
			
	

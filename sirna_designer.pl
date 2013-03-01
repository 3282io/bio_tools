#! /usr/bin/env perl

use strict;
use warnings;

my @sequence;
my ($key,$value);

&FILE_OPEN;

sub FILE_OPEN {
  my $file;
  unless (@ARGV){
	print "\nSimple siRNA designer using Tushl's rules: \nhttp://web.mit.edu/tlo/www/industry/RNAi_patents_tech.html\n";
    	print "\nPlease enter gene sequence now (control D to exit STDIN): \n";
    	chomp (@sequence = <STDIN>);
  }
  else
  {
	$file = $ARGV[0];
	open (FILE, "<$file") || print "$file not found!";
	@sequence = <FILE>;
	close FILE;
  }
    &DESIGNER;
}

sub DESIGNER {

  my $sequence = join ('', @sequence);
  $sequence =~ s/[0-9]/ /g;
  $sequence =~ s/\s//g;

  my @sequence2 = split(//, $sequence);
  my $count = 0;
  my %sirnas = ();
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
	  my $sirna_candidate = $1;
	  $sirna_candidate =~ s/t/u/ig;
	  $sirnas{$start_position} = $sirna_candidate;
	  next;
  }
  
my $star = '*';
my $stars = $star x 75;
  print "\n\n$stars\n\n";
  print "Matching siRNA targets: \n\n";
  
foreach $key(sort(keys(%sirnas))){
	  $gc = 0;
	  while ($sirnas{$key} =~ m/[gc]/ig){
		  $gc++;
		  next;
	  }
	  if ($gc > 10){
		  $gc_percent = $gc/21*100;
		  $gc_percent_rounded = sprintf("%.1f", $gc_percent);
		  printf "%7d", $key;
		  print "\t$sirnas{$key}\tGC = $gc_percent_rounded %\n";
	  }	
  }

  my $end_point = $count - 100;
  print "\n\n  LAST POSITION ==> $count\n\n**RECOMMENDED TO NOT USE ANY WITHIN 100 NTs FROM LAST POSITION**\n";
  print "$stars\n\n";
}
		
=encoding utf8

=head1 SYNOPSIS

This script will accept DNA sequence information and provide siRNA targets based upon algorithm referencing Tuschl's rules. 
Please see http://web.mit.edu/tlo/www/industry/RNAi_patents_tech.html for more information.

=head1 AUTHOR

datarookery, C<< <datarookery at gmail.com> >>

=head1 BUGS

None reported.

=head1 COPYRIGHT & LICENSE

2013

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl 5.14 itself.

=cut	  

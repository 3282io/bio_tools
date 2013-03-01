#! /usr/bin/env perl

use strict;
use warnings;

my ($A,$R,$N,$D,$C,$Q,$E,$G,$H,$I,$L,$K,$M,$F,$P,$S,$T,$W,$Y,$V,$O,$U) =
      	(0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0);
my $aa = "";
my $ast = "*";
my $mw = "";
my $lgth = "";
my $ph = "";
my $z = "";
my ($divN,$divK,$divR,$divH,$divO,$divD,$divE,$divC,$divY) = (0,0,0,0,0,0,0,0,0);
my ($sum1,$sum2) = (0,0,0);
my $pi = "";
my @z = "";
my $min = "";
my $mwround = "";
my $piround = "";
my @ph = qw(1 2 3 4 5 6 7 8 9 10 11 12 13 14);

print "\n\nPlease enter your petide (5-50aa) sequence:\n\n";
chomp(my $sequence = <STDIN>);
my $negwhitespace = $sequence;
$negwhitespace =~ s{\s+}{}gxms;

$A = ($sequence =~ s/(A)/$1/gsi);
$R = ($sequence =~ s/(R)/$1/gsi);
$N = ($sequence =~ s/(N)/$1/gsi);
$D = ($sequence =~ s/(D)/$1/gsi);
$C = ($sequence =~ s/(C)/$1/gsi);   
$Q = ($sequence =~ s/(Q)/$1/gsi);
$E = ($sequence =~ s/(E)/$1/gsi);
$G = ($sequence =~ s/(G)/$1/gsi);
$H = ($sequence =~ s/(H)/$1/gsi);
$I = ($sequence =~ s/(I)/$1/gsi);
$L = ($sequence =~ s/(L)/$1/gsi);
$K = ($sequence =~ s/(K)/$1/gsi);
$M = ($sequence =~ s/(M)/$1/gsi);
$F = ($sequence =~ s/(F)/$1/gsi);
$P = ($sequence =~ s/(P)/$1/gsi);
$S = ($sequence =~ s/(S)/$1/gsi);
$T = ($sequence =~ s/(T)/$1/gsi);
$W = ($sequence =~ s/(W)/$1/gsi);
$Y = ($sequence =~ s/(Y)/$1/gsi);
$V = ($sequence =~ s/(V)/$1/gsi);
                
$aa = $A+$R+$N+$D+$C+$Q+$E+$G+$H+$I+$L+$K+$M+$F+$P+$S+$T+$W+$Y+$V;
				
#########Calculation of mw###########	

$mw = 1.0079+($A*71.0788)+($R*156.1876)+($N*114.1039)+($D*115.0886)+($C*103.1448)
+($Q*128.1308)+($E*129.1155)+($G*57.052)+($H*137.1412)+($I*113.1595)+
($L*113.1595)+($K*128.1742)+($M*131.1986)+($F*147.1766)+($P*97.1167)+
($S*87.0782)+($T*101.1052)+($W*186.2133)+($Y*163.1760)+($V*99.1326)+17.0073;

$lgth = length($negwhitespace);

#########Calculation of pI###########
$ph = 0;
$min = 10;
				
for ($ph = 0.0; $ph <= 14; $ph=$ph+.01){					
	#first half of equation#
	$divN = (10**9.69)/(10**$ph + (10**9.69));
	$divK = $K*((10**10.5)/(10**$ph + (10**10.5)));
	$divR = $R*((10**12.4)/(10**$ph + (10**12.4)));
	$divH = $H*((10**6)/(10**$ph + (10**6)));
		#second half of equation#
	$divO = (10**$ph)/(10**$ph + (10**2.34));
	$divD = $D*((10**$ph)/(10**$ph+ (10**3.86)));
	$divE = $E*((10**$ph)/(10**$ph + (10**4.25)));
	$divC = $C*((10**$ph)/(10**$ph + (10**8.33)));
	$divY = $Y*((10**$ph)/(10**$ph + (10**10)));
		#the equation#
	$sum1 = $divN + $divK + $divR + $divH;
	$sum2 = $divO + $divD + $divE + $divC + $divY;
	$z = $sum1 - $sum2;

	if (abs $z < $min){
		$min = $z; $pi = $ph
	}
}
$mwround = sprintf ("%.0f", $mw);
$piround = sprintf ("%.01f", $pi);

print "\n\n",$ast x 15,"\n";			
print "length = $lgth\nMW = $mwround\npI = $piround\n";	
print $ast x 15,"\n\n\n";		

=encoding utf8

=head1 SYNOPSIS

This script will calculate the physical parameters of a Peptide limited to: length, molecular weight (g/mol), and pI (isoelectric point).

=head1 AUTHOR

datarookery, C<< <datarookery at gmail.com> >>

=head1 BUGS

None reported.

=head1 COPYRIGHT & LICENSE

2011

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl 5.14 itself.

=cut	  

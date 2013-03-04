#Calls &sequence_process to clean out white spaces,
#calculates the length of that sequence and returns this value.

sub sequence_length{
	my($sequence) = sequence_process(@_);

	my($lgth) = length($sequence);

	return $lgth;
}


#Pass a sequence (5-50aa) to sequence_process and this will
#strip white spaces and return a single peptide string.

sub sequence_process{
	my($negwhitespace) = @_;
	$negwhitespace =~ s/\s+//gxms;

	return $negwhitespace;
}


#Calls &sequence_process to clean out white spaces,
#calculates the mw (g/mol) of that sequence, isoelectric
#point (pI) and returns these values.

sub mw_pI_calc{
	my($sequence) = sequence_process(@_);

	my($A,$R,$N,$D,$C,$Q,$E,$G,$H,$I,$L,$K,$M,$F,$P,$S,$T,$W,$Y,$V,$O,$U) =
	      	(0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0);
	my($aa,$mw,$mwround);

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

	$mwround = sprintf ("%.0f", $mw);

	#########Calculation of pI###########

	my($sequence) = sequence_process(@_);

	my $min = "";
	my $ph = "";
	my $pi = "";
	my $piround = "";
	my $z = "";
	my @z = "";
	my($divN,$divK,$divR,$divH,$divO,$divD,$divE,$divC,$divY) = (0,0,0,0,0,0,0,0,0);
	#my @ph = qw(1 2 3 4 5 6 7 8 9 10 11 12 13 14);
	my($sum1,$sum2) = (0,0,0);
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

	$piround = sprintf ("%.02f", $pi);
	
	return ($mwround,$piround);
}

		

=encoding utf8

=head1 SYNOPSIS

This module will calculate the physical parameters of a Peptide limited to: 
length, molecular weight (g/mol), and pI (isoelectric point).

=head1 EXAMPLE

use peptide_calculator;
$var = "fqskfgid nla";
$seq = sequence_process($var);
$len = sequence_length($var);
($mw,$pi)=mw_pI_calc($var);

=head1 AUTHOR

datarookery, <datarookery at gmail.com>

=head1 BUGS

None reported.

=head1 COPYRIGHT & LICENSE

Copyright 2011 datarookery

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl 5.14 itself.

=cut	  

1;

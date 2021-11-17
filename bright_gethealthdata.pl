#!/usr/bin/perl 
#
# 2014/2015 Matthew Buchanan Astley
# Get nodehealth details from clustermanager 
 
use Net::SSH::Perl;
use Data::Dumper ;
use Tie::Autotie 'Tie::IxHash' ;
use Perl6::Form ;

my $time = time;

my $cmd1 = `cmsh -c \"device status\"`  ;

open(LATESTHEALTHDATA, ">", "./latesthealthdata_$time.out") ; 


@devicestatus = split(/\n/, $cmd1) ;


foreach $sline ( @devicestatus){
	print LATESTHEALTHDATA "$sline\n" ;
	if( $sline !~ /DOWN/ && $sline =~ /health check failed/){
		#print "$sline\n" ;
		($node,$dot,$status,$messg) = split(/\s+/,$sline) ;
		push(@fhnodes, $node) ;	
	}
}

$fnodes = join( ',', @fhnodes) ;

my $cmd2 = `cmsh -c 'device ;foreach -v -n $fnodes (latesthealthdata -v -d ";")'`  ;

my @lhd = split(/\n/,$cmd2) ;

foreach $healthline (@lhd){
	print LATESTHEALTHDATA "$healthline\n" ;
	if($healthline =~ /^=+\s(.*)\s=+$/){
		$fnode = $1 ;
	}
	if( $healthline =~ /(FAIL)|^(\s+);/){
		
		$healthline =~ s/\s+;/;/g ;
		($chname,$sever,$value,$age,$infom) = split(/;/, $healthline) ;	
		if($chname ne ""){
			$pchname = $chname ;
		}
		push( @{$hstatus{$fnode}{$pchname} }, $infom )  ; 
			
	}
}


foreach $nod ( sort keys %hstatus ) {
	foreach $chk ( keys %{ $hstatus{$nod} } ){ 
		$msgline = join(" ", @{ $hstatus{$nod}{$chk} } ) ;
		
		#print form
		#	'{[[[[[[[[[]]]]]]]]]]} {[[[[[[[[]]]]]]]]]}  *{[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[}',
		print "$nod, $chk, $msgline\n" ; 
	} 
}

#print Dumper \%hstatus ;
#@dlhdata = split(/\n/, $stdout2) ;



print $stderr ;
print $exit ;


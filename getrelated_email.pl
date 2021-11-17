#!/usr/bin/perl
#
#
# spagetti code and it works somewhat
# Matthijs 2012 ( Matthew Buchanan Astley )

$res = $ARGV[0] ;

if( scalar(@ARGV) < 1 ){

	print "Usage: ./getrelated_email.pl 'resource' eg x.x.x.x/24\n" ;
exit ;
}


if($res =~ /^AS/i){
@addies = `whois -B $res | egrep "e-mail|changed|notify|upd-to"| grep -v "ripe.net"` ; 
#print "1\n" ;
#print @addies ;
#exit ;
}else{
@addies = `whois -r -G -B -d -x $res | egrep "e-mail|changed|notify|upd-to"| grep -v "ripe.net"` ; 
#print "2\n" ;
#print "@addies" ;
#exit ;
}

#
#
# Get maintainers/admin-c/tech-c  related to resource
@mntby = `whois -B -T aut-num,inetnum $res | egrep "^mnt-by|admin-c|tech-c"| grep -v "RIPE-NCC-END-MNT"|cut -d: -f2` ; 

foreach(@mntby){
$_ =~ s/^\s+//;
$_ =~ s/\s+$//;
push(@mntby2, $_) ;
}

#print "@mntby2\n" ;
#exit ;

# Unique maintainer handles
    my %mnts   = map { $_, 1 } @mntby2;
    my @unique_mnts = keys %mnts;

#print @unique_mnts ;
#exit ;

foreach $mnt (@unique_mnts){

#if($mnt !~ /mnt-by/){
	@mnt_related = `whois $mnt` ; 
	getmnte(@mnt_related) ;
#print @mnt_related ;
#	}
}



@caddies = () ;

foreach $i (@addies){
	$i =~ s/\D+:\s+//g; 
	$i =~ s/\s\d{8}$//g ;
	chomp $i ;
	push(@caddies, $i) ;
}
    my %addies   = map { $_, 1 } @caddies;
    my @unique_addies = keys %addies;

#$final = ret_e() ;
#$final =~ s/,$//g ;
#print  "$final\n" ;
ret_e() ;


#
#
# Print unique addresses in To: line 

sub ret_e {

print "To: " ;

foreach $j ( @unique_addies ){ 
	push(@all,$j) ;
	}
}

#
#
# Pull email addresses from related maintainers
sub getmnte {
@caddies2 = () ;

foreach $m (@mnt_related){ 
#get email addresses from mnt
if($m =~ /(^e-mail|^changed|^notify|^upd-to)/ && $m !~ /ripe.net/){
	push(@addies2,$m) ;
	}
}

#strip addresses
foreach $i (@addies2){
	$i =~ s/\D+:\s+//g; 
	$i =~ s/\s\d{8}$//g ;
	chomp $i ;
	push(@caddies2, $i) ;
}

#make addresses unique
    my %addies2   = map { $_, 1 } @caddies2;
    my @unique_addies2 = keys %addies2;

#print @unique_addies2 ;
#	print "#\n#\n#\n# Addies from maintainers.\n" ;

#print "To: " ;

foreach $j ( @unique_addies2 ){
	push(@all, $j) ;

        }
}

    my %all   = map { $_, 1 } @all;
    my @all2 = keys %all;

foreach(@all2){
print "$_,\n" ;
}
print "\n" ;


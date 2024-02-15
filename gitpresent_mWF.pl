#!/usr/bin/perl
#
# FileCopyrightText: 2022-2014 Matthew Buchanan Astley (matthewbuchanan@astley.nl,mbastley@gmail.com) 
#
# This is a small adjustment to the gitpresent.pl script to have it list the commits since the specified date.
#
# Script to get a listing of commits made, in a repository, since the day you specify using the English abbreviated month and day of the month, including filename.
# 
# for instance: ./gitpresent_mWF.pl "Feb 14"

use Data::Dumper; 

$M=`/usr/bin/date '+%b'` ;
$D=`/usr/bin/date '+%d'` ;
$M =~ s/\n//;
$M1 = `date --date=\"$M $D -1day\" '+%b %d'` ; 
$M1 =~ s/\n//;
#$DATE="$M " . $M1 . " 23:59";
$DATE = $ARGV[0] ;
open $W1, "-|", "git log --since=\"$DATE\" --oneline " ;

@a1 = [] ;

while(<$W1>) {
     @a = split(/\s/,$_) ;
     push(@a1, $a[0]) ; 
}

shift(@a1) ;

@a2 = [] ;

foreach $a11 (@a1) {
     git_1($a11) ;
}

sub git_1 {
    @W2 = `git show $a11` ; 
    $W2 = `git show $a11` ; 
    @W3 = [] ;
    @W4 = [] ;

    @W5 = split(/index/,$W2) ;
    @W6 = split(/\n/,$W5[0]) ;
    
    push(@W3, $11) ;
    foreach $i (@W6) {
        $i =~ s/\n//;
        push(@W3, $1) if $i =~ /^Author:\s(.*?)$/ ;
        push(@W3, $1) if $i =~ /^Date:\s+(.*?)$/ ;
        push(@W3, $1) if $i =~ /^\s{4}(.*?)$/ ;
        
        if( $i =~ /^diff\s(.*?)\s(.*?)\s(.*?)$/ ) { 
            $ii = $2 ;
            $ii =~ s/a\/// ;
            push(@W3, $ii); 
        }
    }
    shift @W3 ;
    print $W3[0] . " " . $W3[2] . " " . $W3[3] . " " . $W3[4] . " " . $W3[1]  . "\n" ; 

}


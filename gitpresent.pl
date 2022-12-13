#!/usr/bin/perl
#
# 2022 Matthew Buchanan Astley
#
# Script to get a listing of commits made, in a repository, on the actual day, including filename.
# 

use Data::Dumper; 

$M=`/usr/bin/date '+%b'` ;
$D=`/usr/bin/date '+%d'` ;
$M =~ s/\n//;
#$DATE="$M " . ($D - 1) . " 23:59";
$M1 = `date --date=\"$M $D -1day\" '+%b %d'` ; 
$M1 =~ s/\n//;
$DATE="$M " . $M1 . " 23:59";

#print $DATE . " ";
#exit;

#$W = `git log --since="$DATE" --oneline`;
open $W1, "-|", "git log --since=\"$DATE\" --oneline " ;

@a1 = [] ;

while(<$W1>) {
     @a = split(/\s/,$_) ;
     push(@a1, $a[0]) ; 
}

shift(@a1) ;
#print Dumper \@a1 ; 

@a2 = [] ;

foreach $a11 (@a1) {
     git_1($a11) ;
}

sub git_1 {
    #print "Ja" ;
    #print $a1[0] ; 
    @W2 = `git show $a11` ; 
    $W2 = `git show $a11` ; 
    #print Dumper \@W2 ; 
    #exit ;
    @W3 = [] ;
    @W4 = [] ;

    @W5 = split(/index/,$W2) ;
    @W6 = split(/\n/,$W5[0]) ;
    #@foreach($W2){ 
    #    print $_ if /commit/ .. /index/;
    #}
    #while(<$W2>) {
        #print $ii ;
    #    push(@W4, $_) if /^commit/ .. /^index/ ; 
    #} 
    #print Dumper \@W4 ;
    #print $W5[0] ;
    #exit ;
    
    push(@W3, $11) ;
    foreach $i (@W6) {
        #chomp $i ;
        #print $i . "\n" ;
        $i =~ s/\n//;
        #if( $i =~ /^commit\s(.*?)\s(.*?)$/ ) { 
        #push(@W3, $1) if $i =~ /commit\s(.*?)\s(.*?)$/ ;
        #push(@W3, $a1[0]) ;
            #print $i . "Ja $1" ;
            #$commit = $1 ; 
        #}
        push(@W3, $1) if $i =~ /^Author:\s(.*?)$/ ;
        push(@W3, $1) if $i =~ /^Date:\s+(.*?)$/ ;
        push(@W3, $1) if $i =~ /^\s{4}(.*?)$/ ;
        
        if( $i =~ /^diff\s(.*?)\s(.*?)\s(.*?)$/ ) { 
            $ii = $2 ;
            $ii =~ s/a\/// ;
            # print $2 ;
            push(@W3, $ii); 
        }
    }
    shift @W3 ;
    #print Dumper \@W3 ;
    print $W3[0] . " " . $W3[2] . " " . $W3[3] . " " . $W3[4] . " " . $W3[1]  . "\n" ; 

}

#git_1($a1[0]) ;







#echo $W
#for i in $W
#    do
#        A=$(git show $i)
#        A1=$(echo $A | cut -d"index" -f1)
#        echo "Ja $A"
#        echo "Ja $A1"
#    done


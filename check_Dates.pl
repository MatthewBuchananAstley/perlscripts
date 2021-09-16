#!/usr/bin/perl

$in = $ARGV[0] ;

if(scalar(@ARGV) eq 0 ){
	print "\nUsage: ./checkdates 20112912\n\n" ;
	exit ;
}

$year = substr($in, 0,4) ;
$month = substr($in, 4,2) ;
$day = substr($in, 6,2) ;

#print "$year\n" ;
#print "$month\n"; 
#print "$day\n" ;
#exit ;
$date = "$year$month$day" ;
#print $date ;
$startdate = "$month/$day/$year" ;

#print $startdate;

$start_period = `date --date="$startdate" +%d/%m/%Y` ; 
$date_reminder1 = `date --date="$startdate +15days" +%d/%m/%Y` ; 
$date_reminder2 = `date --date="$startdate +30days" +%d/%m/%Y` ; 
$date_reminder3 = `date --date="$startdate +45days" +%d/%m/%Y` ; 
$date_reminder4 = `date --date="$startdate +60days" +%d/%m/%Y` ; 
$date_reminder5 = `date --date="$startdate +75days" +%d/%m/%Y` ; 
$date_90daysover = `date --date="$startdate +90days" +%d/%m/%Y` ; 
$date_last30days = `date --date="$startdate +120days" +%d/%m/%Y` ; 
$date_last60days = `date --date="$startdate +150days" +%d/%m/%Y` ; 
$date_last90days = `date --date="$startdate +180days" +%d/%m/%Y` ; 

print "#\n# These are the dates emails have to be sent\n" ;
print "# with first email sent on $in\n#\n" ;
print "\tFirst email 90days: \t$start_period" ; 
print "\tReminder 1 75 days: \t$date_reminder1" ;
print "\tReminder 2 60 days: \t$date_reminder2" ;
print "\tReminder 3 45 days: \t$date_reminder3" ;
print "\tReminder 4 30 days: \t$date_reminder4" ;
print "\tReminder 5 15 days: \t$date_reminder5" ;
print "\tLast email 90 days: \t$date_90daysover"  ;
print "\tlock object: \t\t$date_last30days"  ;
print "\t30days after lock:  \t$date_last60days"  ;
print "\tTIME UP:  \t    \t$date_last90days\n\n"  ;

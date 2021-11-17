#!/usr/bin/env perl 
#
# 2014/2015 Matthew Buchanan Astley
# Adding new nodes to cluster

$node = "202" ;
#$ip = "10.141.0.0" ;
$ip = "10.142.0." ;

@in = ( 001 .. 202 ) ;

foreach $i (@in){ 
print_bright($i) ;
}

sub print_bright {
$ii = sprintf( '%03d', $i) ;
$iip = $ip . $ii ;
$lines =<<"IPDOC" ;
[master-01->device]add physicalnode nodename-$ii
[master-01->device*[nodename-$ii*]]%interfaces 
[master-01->device*[nodename-$ii*]->interfaces]%add physical eth0
[master-01->device*[nodename-$ii*]->interfaces]%set ip $iip
[master-01->device*[nodename-$ii*]->interfaces]%set network internalnet 
[master-01->device*[nodename-$ii*]->interfaces]%commit
[master-01->device[nodename-$ii]->[nodename-$ii]->interfaces]%
IPDOC

print $lines ;

}

#[master-01->device*[nodename-$ii*]->interfaces]%set ip $ip

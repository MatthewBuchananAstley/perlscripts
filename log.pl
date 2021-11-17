#!/usr/bin/perl -w
#
# 2010/2011 Matthew Buchanan Astley
#
# (text from HD Ratio rfc) 
#Expending the size of the Internet addresses, from 32 bits to
#     something else. There are currently about 3 million hosts on the
#     net, for 32 bits. The log of 3.E6 is about 6.5; this gives a ratio
#     of 0.20. Indeed, we believe that 32 bits will still be enough for
#    some years, e.g. to multiply the number of hosts by 10, in which
#     case the ratio would climb to 0.23
#
# ( Confirming the statements from the rfc text on the commandline ) 
#echo "l(3000000)/l(10)/32"|bc -l
#
# echo "l(3000000)/l(10)/32"|bc -l
#.20241003920998945116
# echo "l(3000000)/l(10)"|bc -l
#6.47712125471966243731


#H ratio


use CGI::Simple;

$q = new CGI::Simple;

@params = $q->param;        # return all param names as a list
#$value = $q->param('foo');  # return the first value supplied for 'foo'
#    @values = $q->param('foo'); # return all values supplied for foo


$nohosts = $q->param('number_of_hosts') ;
$base = $q->param('base') ;
$bits = $q->param('bits') ;

#print $nohosts . $base . $netmask "\n";
#sub log_hd {

#        my ($nohosts, $bits) = @bla;
       # print log($nohosts)/log($base)/$bits;
#}
#log_hd() ;



print "Content-type: text/html\n\n" ;


#        print log($nohosts)/log($base)/$bits;
#exit ;
print "<html><head>
<style type=\"text/css\">
body
{
background-color:#$f;
}
h1
{

font-family:\"Times New Roman\";
font-size:60px;
text-align:center;

}
p
{
font-family:\"Times New Roman\";
font-size:100px;
}
p2
{
font-family:\"Times New Roman\";
font-size:13px;
}

.center
{
margin-top: 10em  ;
margin-left:20em;
}
</style></head><body>
<p2>
#  Directly using the HD-ratio makes it easy to evaluate the density of<br>
#  allocated objects.  Evaluating how well an addressing plan will scale<br>
#  requires the reverse calculation.  We have seen in section 3.1 that<br>
#  an HD-ratio lower than 80% is manageable, and that HD-ratios higher<br>
#  than 87% are hard to sustain.  This should enable us to compute the<br>
#  acceptable and \"practical maximum\" number of objects that can be<br>
#  allocated given a specific address size, using the formula:<br>
#  number allocatable of objects<br>
#              = exp( HD x log(maximum number allocatable of objects))<br>
#              = (maximum number allocatable of objects)^HD<br>
#  The following table provides example values for a 9-digit telephone<br>
#  plan, a 10-digit telephone plan, and the 32-bit IPv4 Internet:<br>
#                                            Very  Practical<br>
#                    Reasonable  Painful  Painful    Maximum<br>
#                        HD=80%   HD=85%   HD=86%     HD=87%<br>
#  ---------------------------------------------------------<br>
#  9-digits plan           16 M     45 M     55 M       68 M<br>
#  10-digits plan         100 M    316 M    400 M      500 M<br>
#  32-bits addresses       51 M    154 M    192 M      240 M<br>
<br>
<br>
<a href=\"ftp://ftp.ripe.net/rfc/rfc3194.txt\"> rfc3194.txt</a><br>
<a href=\"http://www.ripe.net/ripe/docs/ripe-512#references\">IPv6 Address Allocation and Assignment Policy  </a><br>


<p2> 
<br>
Put the number of objects in first box (enter the millions from the example above to get the exact ratios)<br>
Put the base in the second box (binary is base2, decimal base10) <br>
Put the addressing plan size in the third box (9 or 10 digit or 32/48/56/64 bits).


<div class=\"center\">
<form class='form' action='log.pl' method='post' >
<table><tr><td>Number of objects</td></td>
<td>The base, binary plans = 2 </td>
<td>CIDR /64 </td>
</tr><tr>
<td><input name='number_of_hosts' value='$in' ></td>
<td><input name='base' value='$in' ></td>
<td><input name='bits' value='$in' ></td>
<td><input type='submit' name='log' value='calculate HD ratio'></td>
</tr>
</table>
</form>
<p>";
print log($nohosts)/log($base)/$bits;
print "</p>


</div>
</body>
</html>
" ;


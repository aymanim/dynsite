
#/usr/bin/perl - w

# open file

open(FILE, "template.htm");
@file = <FILE>;
close(FILE);

# save title of template to $titlehead
foreach $x (@file){
if ($x =~ m/title/){

$titletemp = $x}


}



($ti1, $ti2) = split(">", $titletemp);

($titlehead, $ti3) = split("<", $ti2);


# find the line on which title occurs

$tempels = 0;

foreach $el (@file){
if ($el !~ m/title/){
$tempels++; 
$nil = "not found";}

else {$linetitle = $tempels;
$nil = "found";
last; }
}


# find where the content is supposed to be

$tempels = 0;
         
foreach $el (@file){
if ($el !~ m/cricket97/){     # please change the text between "m/" and "/" to what you have made your break point

$tempels++; 
$nil = "not found";}

else {$line = $tempels;
$nil = "found";
last; }
}


# making the variables 

$headend = $linetitle - 1;
$topbeg = $linetitle + 1;
$topend = $line - 1;
$botbeg = $line + 1;
$botend = $#file;


@head = @file[0 ... $headend];
@top = @file[$topbeg ... $topend];
@bot = @file[$botbeg ... $botend];




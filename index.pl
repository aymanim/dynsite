#!/usr/bin/perl




#########################################################################
#
# Some variables to be configured
#
#########################################################################

# please put a relative path to your template file w.r.t the script

$template = "template.html";

# break point in the template file which will be replaced by the content

$breakpoint = "cricket97";

# this is the valid pages file

$valpages = "valid_pages.txt";

# 1 line error message 

$error = "Sorry, the page you have requested is not available";

# Title of error page

$titleerror = "Not Found";




#########################################################################
#########################################################################

# Do not change anything below.

#########################################################################
#
# Making the top and bottom files on the fly, Also extracting the title
#
#########################################################################


open(FILE, "$template");
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

if ($el !~ m/$breakpoint/){  

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



#########################################################################
#
# saving  valid pages to variables
#
#########################################################################

open(VAL, "$valpages") or die "cannot open file valid pages";

        $val = <VAL>;

                close(VAL);



#########################################################################
#
# splitting the valid pages file into variables
#
#########################################################################


@page = split(/ /, $val);


#############################################s############################
#
# saving query string
#
#########################################################################


$req = "$ENV{QUERY_STRING}";


#########################################################################
#
# checking if the requested page is a valid page
#
#########################################################################



foreach $p (@page){

if ((index $p, $req) >= 0){
        $found = 1;}
        }

if ($found == 1){



#########################################################################
#
# taking data and title from corresponding file and saving to variable
#
#########################################################################



$file ="$req.html";

        open(DATA, "$file") or die "cannot open file $file";

        @reqfile = <DATA>;

		close(DATA);

# getting title of the page and saving to $title

foreach $x (@reqfile){
if ($x =~ m/title/){

$titletemp = $x}


}



($ti1, $ti2) = split(">", $titletemp);

($title, $ti3) = split("<", $ti2);


#extracting content from the page ans saving to @data variable

$count = 0;

foreach $bb (@reqfile){

if ($bb !~ m/body/){
$count++}

else {$linebodybegin = $count;
last;}

}

$count = 0;

foreach $be (@reqfile){

if ($be !~ m/\/body/){
$count++}

else {$linebodyend = $count;
last;}

}

$content_begin = $linebodybegin + 1;
$content_end = $linebodyend - 1;

@data = @reqfile[$content_begin ... $content_end]  ;



#########################################################################
#
# Saving the Error file to @error --- UNDER CONSTRUCTION
#
#########################################################################
#
#
#open(DATA, "$errorfile") or die "cannot open file $errorfile";
#
#        @errorfile = <DATA>;
#
#                close(DATA);
#
## getting title of the page and saving to $title
#
#foreach $x (@errorfile){
#if ($x =~ m/title/){
#
#$titletemp = $x}
#
#
#}
#
#
#
#($ti1, $ti2) = split(">", $titletemp);
#
#($titleerror, $ti3) = split("<", $ti2);
#
#
##extracting content from the page ans saving to @error variable
#
#$count = 0;
#
#foreach $bb (@errorfile){
#
#if ($bb !~ m/body/){
#$count++}
#
#else {$linebodybeginerror = $count;
#last;}
#
#}
#
#$count = 0;
#
#foreach $be (@errorfile){
#
#if ($be !~ m/\/body/){
#$count++}
#
#else {$linebodyenderror = $count;
#last;}
#
#}
#
#$content_begin = $linebodybeginerror + 1;
#$content_end = $linebodyenderror - 1;
#
#@error = @errorfile[$content_begin ... $content_end]  ;
#
#
#
#########################################################################
#
# done! Now, printing the file on the STDERR or moniter
#
#########################################################################



print "Content-type: text/html \n\n";


print "@head\n";
print "<title>$titlehead - $title</title>\n";
print "@top \n";
print "@data\n";
print "@bot \n";


}



#########################################################################
#
# The error page which will be displayed
#
#########################################################################



else {

print "Content-type: text/html \n\n";

print "@head\n";
print "<title>$titlehead - $titleerror</title>\n";
print "@top \n";
print "$error\n";
print "@bot \n";

}








#!/usr/bin/perl -w
# etteantud kataloogis muuda conllu+ failid conlluks

use Getopt::Std;
# -i Arg -o Arg
use utf8;

getopt("i:o:",\%option);

if ($option{i}){
    print "loeb kataloogist $option{i}\n";
} else {
    die "-i sisendkataloog on vajalik\n";
}    

if ($option{o}){
    print "kirjutab kataloogi $option{o}\n";
} else {
    die "-o väljundkataloog on vajalik\n";
}

my $inpath=$option{i};
my @files = ();
my $file;
my $newfile;
my $line;
my @elements = ();
my @misc=();
my @newmisc=();
my $i=0;

opendir(DIR,$inpath) or die "Can't open $inpath: $!";
@files = grep {/.*/ } readdir(DIR);
closedir(DIR);

opendir(DIR,$option{o}) or die "Can't open $option{o}: $!";
closedir(DIR);

foreach $file (@files) {
	if ($file =~ /^\./) { next; }
  my $newname = $option{o} . "/" .$file . ".arg.conllu";
  $file= $inpath . "/" . $file;
  
  #ava failid
  open(IN, "< $file") or die "sisend ei avanenud: $file $!\n";
  open(OUT, "> $newname") or die "väljund ei avanenud: $file $!\n"; 
  
  select(OUT);
  
  #töötle ja trüki
  $i=0;
  
  while ($line= <IN>) {
	chomp $line; 
	if ($i==0) {print STDERR "$line\n"; $i++}
	if ($line =~ /^# sent_id/) {
		  print "$line\n";
	} elsif($line =~ /^\s*$/) {
		print "\n";
	} elsif ($line =~ /^# text/) {
		if ($line =~ /^(.*)\s+_\s+_$/){ #mingi jama textväljadega
			print "$1\n";
		} else {
			print "$line\n";
		}
	} elsif ($line =~ /^# newdoc/) {
		print "$line\n";
		#print STDERR "$line\n";
	} else {
		@elements= split(/\t/,$line);
		if ($#elements<11) {print STDERR "Jama: $line\n"; next;}
		if ($elements[11] =~ /Verb_(.*)$/) {
			if ($1) {$newtag = "Verb=".$1;} else {print STDERR "Jama: $line\n";}
			if ($elements[9] =~ /^_/){
				$elements[9] = $newtag;
			} else {
				@misc= split(/\|/,$elements[9]);
				push(@misc,($newtag));
				@newmisc=sort @misc;
				$elements[9]=join('|',@newmisc);
			}
		}
		if ($elements[10] !~ /^_$/) { #Arg on ka
			if ($elements[10] =~ /^(\S+)$/){
				$newtag = "Arg=".$1;
				if ($elements[9] =~ /^_/){
					$elements[9] = $newtag;
				} else {
					@misc= split(/\|/,$elements[9]);
					push(@misc,($newtag));
					@newmisc=sort @misc;
					$elements[9]=join('|',@newmisc);
				}
			}
		}
		pop(@elements);
		pop(@elements);
		$line=join("\t",@elements) . "\n";
		print $line;
	} 
  } #/while
  close(IN) or die "$!\n";
  close(OUT) or die "$!\n";
}

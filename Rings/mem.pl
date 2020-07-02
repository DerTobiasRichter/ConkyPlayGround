#!/usr/bin/perl
## Author: Tobias.Richter@de.ibm.com
## Parse CPU Fan Speed
use strict;


my $minMEM = 0;
my $maxMEM = 15716; 

sub mem{
	my $freeMEM = `free -m`;
	#printf("freeMEM:\n".$freeMEM."\n");

        ($maxMEM) = $freeMEM =~ m/Mem:[ ]+([0-9]+)[ ]/g;
        #printf("maxMEM: ".$maxMEM."\n");
	
	my ($mem) = $freeMEM =~ m/Mem:[ ]+[0-9]+[ ]+([0-9]+)/g; 
	#printf("mem: ".$mem."\n");
	
	my $freeMemAsPercent = 0;
	if( $mem > $minMEM){
		$freeMemAsPercent= ($mem*100)/$maxMEM;
	}

	#printf("MEM / 100: ".$freeMemAsPercent."\n");

	#return(sprintf("%.2f", $freeMemAsPercent));
	return(int($freeMemAsPercent + 0.5));
}

printf(mem());

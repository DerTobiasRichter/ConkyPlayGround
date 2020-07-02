#!/usr/bin/perl
## Author: Tobias.Richter@de.ibm.com
## Parse CPU Fan Speed
use strict;


my $minFanSpeed = 2000;
my $maxFanSpeed = 4055; 

sub fan{
	my $sensors = `sensors`;
	#printf("sensors:\n".$sensors."\n");
	
	my ($fanspeed) = $sensors =~ m/fan1:[ ]+([0-9]+)[ ]+RPM/g; 
	#printf("fanspeed: ".$fanspeed."\n");
	
	my $fanspeedAsPercent = 0;
	if( $fanspeed > $minFanSpeed){
		$fanspeed = $fanspeed - $minFanSpeed;
		
		$fanspeedAsPercent= ($fanspeed*100)/($maxFanSpeed - $minFanSpeed);
	}
	#printf("Fan Speed / 100: ".$fanspeedAsPercent."\n");

	return(int($fanspeedAsPercent + 0.5));
}

printf(fan());

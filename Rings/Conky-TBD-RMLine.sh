#! /bin/sh

# =============================================================================
#                               notes RemarkLine Script
# Date    : 24/08/2019
# Author  : Tobias.Richter@de.ibm.com
# Version : v1.0
# License : Distributed under the terms of GNU GPL version 2 or later
#
# Delete a TBD note at the given possition of the Conky-TBD.txt. Don't forget 
# to make the reference to ~./bash_profile or ~./bashrc: 
# alias tbdadd="~/.conky/Rings/Conky-TBD-Append.sh"
# alias tbdrml="~/.conky/Rings/Conky-TBD-RMLine.sh"
#
# =============================================================================

CONKY_TBD_DIR=~/Documents/01_Temp
CONKY_TBD_TXT=Conky-TBD.txt
if [ -f $CONKY_TBD_DIR/$CONKY_TBD_TXT ]
then
    sed -i $1d $CONKY_TBD_DIR/$CONKY_TBD_TXT
    echo "removed line $1"
fi


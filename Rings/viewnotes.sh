#!/bin/bash

# =============================================================================
#                               notes formater
# Date    : 24/08/2019
# Author  : Tobias.Richter@de.ibm.com
# Version : v1.0
# License : Distributed under the terms of GNU GPL version 2 or later
#
# By conky 'notes' file deamonized Conky-TBD.txt file formater 
#
# Don't forget to make the reference to ~./bash_profile or ~./bashrc: 
# alias tbdadd="~/.conky/Rings/Conky-TBD-Append.sh"
# alias tbdrml="~/.conky/Rings/Conky-TBD-RMLine.sh"
#
# =============================================================================

cat $1 | sed 's/^/ \${color #ddddff}x  \$color /g'

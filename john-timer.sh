# Filename: john-timer.sh
# Authors: Joshua Waggoner and Fred Montoya
# Copyright: (c) 2014 rabbitfighter.net
#
# Usage:
# 
# This script is written for CS3750-Computer/Network Security 
# Its purpose is to be able to time John the Ripper password
# cracking to be able to analyze the data scientifically. 
# The units of time are in seconds, and this script accomplishes
# that using *nix's built in time functions. It will also ouput 
# the results to a .txt file containing the times of each Jack the Ripper run.
#

##############################################################################
echo "========================================================================"
echo "== John the Ripper Timer by Joshua Michael Waggoner and Fred Montoya  =="
echo "========================================================================"
echo ""
echo "Please enter a file to run John the Ripper on and press [Enter]"

# Read in the filename
read filename

#Prompt user for output file
echo "Please enter a filename to print results to and press [ENTER]"

# Read in the filename for output
read fileout

# Prompt for a mode
echo "Please enter --incremental, --wordlist=<wordlist>, --single"
echo "Or... Enter nothing for regular mode"
read mode

if [[ -z "$mode" ]]; then
        echo "John the Ripper run on ${filename}">> "${fileout}"
         echo "--------------------------------------------------" >> "${fileout}"
        T1="$(date +%s)"
        john "${filename}"
else
        echo "John the Ripper ${mode} run on ${filename}" >> "${fileout}"
        echo "--------------------------------------------------" >> "${fileout}"

        # # Get time as a UNIX timestamp (seconds elapsed since Jan 1, 1970 0:00 UTC)
        T1="$(date +%s)"

        # Run joh on the DES password hashes
        john "${mode}"  "${filename}"
fi
# Get the next timestamp
T2="$(date +%s)"

# Get the time it took to crack the passwords
TOTALTIME=$(( T2-T1 ))

# Print how long it took.
echo "It took $TOTALTIME seconds to crack the passwords " >> "${fileout}"
echo "--------------------------------------------------" >> "${fileout}"
echo "========================================================================"
#EOF


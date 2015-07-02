#!/bin/bash

###############################################
# Author: Nicolas Carusso                     #
# Author's email: ncarusso at gmail dot com   #
# Date: /05/2015                            #
###############################################

source external_functions_for_solitaire_bash.sh

<<COMMENT1
	   Bash implementation of Bruce Schneier's Solitaire Encryption Algorithm (http://www.counterpane.com/solitaire.html). I only used bash commands
	   to write this script in order to maximize its compatibility with linux distros

           TESTED IN: debian/Ubuntu/ Mac OSX /Windows + CygWin...

COMMENT1

##################################################################
## DECK OF CARDS
##################################################################
# The deck had been constructed according to the following directives:
#Suit_card
#For Example:  A Clubs is C_A and Queen of Spades is S_Q

#  1, 2,...,13 are A,2,...,K of clubs
# 14,15,...,26 are A,2,...,K of diamonds
# 27,28,...,39 are A,2,...,K of hearts
# 40,41,...,52 are A,2,...,K of spades
#C = Clubs
#D = Diamonds
#H = Hearts
#S = Spades
#J = Jack
#Q = Queen
#K = king

#echo "The complete deck of cards is: " ${deck[*]}
#echo "The Wildcards are: " $jokerA "and" $jokerB

echo "#########################################################################################"
echo "### Welcome to Bash implementation of Bruce Schneier's Solitaire Encryption Algorithm ###"
echo "#########################################################################################"
echo "#"
echo "Please select one of the following options"
echo "1) Encrypt"
echo "2) Decrypt"
echo "3) Run test vectors"
echo "4) Cipher consistency check"
echo -n "Option: "

read option



case $option in

1)
	enter_message
	encrypt;;
2)
	enter_message
	decrypt;;
3)
	test_vectors;;
4)
	cipher_consistency_check;;
*)
	echo "You entered an invalid option";;

esac

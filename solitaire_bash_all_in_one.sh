#!/bin/bash 

###############################################
# Author: Nicolas Carusso                     #
# Author's email: ncarusso at gmail dot com   #
# Date: /May and June/2015                    #
###############################################

<<COMMENT1
     Bash implementation of Bruce Schneier's Solitaire Encryption Algorithm (https://www.schneier.com/solitaire.html). I only used bash commands
     to write this script in order to maximize its compatibility with linux distros

           TESTED IN: debian/Ubuntu/ Mac OSX 10.6.8 /Windows + CygWin...

COMMENT1

##################################################################
## DECK OF CARDS
##################################################################
# The deck had been constructed according to the following directives:
# Suit_card
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

deck_original=(C_A C_2 C_3 C_4 C_5 C_6 C_7 C_8 C_9 C_10 C_J C_Q C_K D_A D_2 D_3 D_4 D_5 D_6 D_7 D_8 D_9 D_10 D_J D_Q D_K H_A H_2 H_3 H_4 H_5 H_6 H_7 H_8 H_9 H_10 H_J H_Q H_K S_A S_2 S_3 S_4 S_5 S_6 S_7 S_8 S_9 S_10 S_J S_Q S_K A_Joker B_Joker)
deck=(C_A C_2 C_3 C_4 C_5 C_6 C_7 C_8 C_9 C_10 C_J C_Q C_K D_A D_2 D_3 D_4 D_5 D_6 D_7 D_8 D_9 D_10 D_J D_Q D_K H_A H_2 H_3 H_4 H_5 H_6 H_7 H_8 H_9 H_10 H_J H_Q H_K S_A S_2 S_3 S_4 S_5 S_6 S_7 S_8 S_9 S_10 S_J S_Q S_K A_Joker B_Joker)
jokerA=A_Joker
jokerB=B_Joker


#Create two arrays with brace expansion
letters=({A..Z})
numbers=({1..26})

##########################################################
##########################################################
#####		FUNCTIONS
##########################################################
##########################################################
#
#
#

function move_1_card_down_aux () {


       #This extra conditional checks the particular case in which the jokerA is in the last position
       #of the deck. If so, it swaps the jokerA with the first card, in order to treat the deck as a loop.
           if [  $(( i + 1 )) == ${#deck_after_step_1[@]} ]
                then
                        #echo "The card is jokerA and it is located in the last position of the deck"
                        posicion_0=${deck_after_step_1[0]}
                        unset deck_after_step_1[0]
                        unset deck_after_step_1[i]
                        deck_after_step_1=($posicion_0 $jokerA ${deck_after_step_1[@]})

                else    #Simple SWAP the cards
                        aux=${deck_after_step_1[i]}
                        deck_after_step_1[$i]=${deck_after_step_1[i+1]}
                        deck_after_step_1[$i+1]=$aux
           fi

}
##############################################
######## STEP 1 - Move 1 card down
##############################################

function move_1_card_down () {

#Auxiliary Array to store the deck after step 1
deck_after_step_1=(${deck[@]})

#The break condition of the for loop is the length of the deck (original deck, but it is the same length in all of them)
for ((i=0;i < ${#deck[@]}; i++))
do
        if [  ${deck_after_step_1[i]} == $jokerA ]
         then
                #echo "Card is jokerA"
                move_1_card_down_aux $i
                break
         else
             	#echo "Card is not jokerA"
             	deck_after_step_1[$i]=${deck_after_step_1[i]}
        fi
done
}

##############################################
######## STEP 2 - Move 2 cards down
##############################################
function move_2_cards_down_aux () {

                 #Extra Conditional 1. Checks if joker B is located in the last place of the deck.
                 #If so, It uses position 0 and 1 of the deck to perform the movement
                   if [  $(( i + 1 )) == ${#deck_after_step_2[@]} ]
                        then
                                   #echo "The card is joker B and it is located in the last position of the deck"
                                   position_0=${deck_after_step_2[0]}
                                   position_1=${deck_after_step_2[1]}
                                   unset deck_after_step_2[0]
                                   unset deck_after_step_2[1]
                                   unset deck_after_step_2[i]
                                   deck_after_step_2=($position_0 $position_1 $jokerB ${deck_after_step_2[@]})
                        else

                  #Extra Conditional 2. Checks if joker B is located before the last place of the deck.
                  #If so, It uses the last position and 0 (first position in array) of the deck to perform the movement

                                   if [  $(( i + 2)) == ${#deck_after_step_2[@]} ]
                                        then
                                            #echo "The card is joker B and it is located one up from the last card"
                                            position_0=${deck_after_step_2[0]}
                                            unset deck_after_step_2[0]
                                            unset deck_after_step_2[i]
                                            deck_after_step_2=($position_0 $position_1 $jokerB ${deck_after_step_2[@]})
                                        else
                                            #echo "The card is joker B"
                                            aux=${deck_after_step_2[i]}
                                            deck_after_step_2[$i]=${deck_after_step_2[i+1]}
                                            deck_after_step_2[i+1]=${deck_after_step_2[i+2]}
                                            deck_after_step_2[i+2]=$aux
                                   fi
                fi

}

function move_2_cards_down () {
#Auxiliary Array to store the deck after step 2.
#Note that the initial condition of the deck in step 2 is the deck generated after step 1
deck_after_step_2=(${deck_after_step_1[@]})

for ((i=0;i < ${#deck[@]}; i++))
do
        if [  ${deck_after_step_2[i]} == $jokerB ]
         then
 #          echo "The card is joker B"
                move_2_cards_down_aux $i
                break

         else
           deck_after_step_2[$i]=${deck_after_step_2[i]}
  #              echo "The card is not joker B"
        fi
done

#echo "deck after 2 step of keystream: " ${deck_after_step_2[*]}
}
##############################################
######## STEP 3 - Triple Cut
##############################################

#Deck is divided into 5 parts as follows:
#  ( left_deck  joker1  middle_deck     joker2  right_deck)
#Basically these functions identify both jokers and then exchange left_deck with right_deck)
#  ( right_deck   joker1  middle_deck     joker2  left_deck)

function first_cut () {
                left_deck=(${deck_after_step_3[@]:0:i})
                joker1=(${deck_after_step_3[i]})
                position_joker_1=$i
                rest_of_deck=(${deck_after_step_3[@]:(i+1)})
                cant=${#rest_of_deck[@]}
                cant_deck=${#deck_after_step_3[@]}
}


function second_and_third_cut () {
                joker2=(${rest_of_deck[j]})
                j_in_deck=$(( $cant_deck - $cant ))
                j_aux=$(( $j_in_deck + $j -1 ))
                joker1_not_included=$(( $position_joker_1 + 1 ))
                array_2_delimiter=$(( $j_aux - $position_joker_1 ))
                middle_deck=(${deck_after_step_3[@]:$joker1_not_included:$array_2_delimiter})
                right_deck=(${rest_of_deck[@]:(j+1)})
}

function triple_cut () {
#Auxiliary Array to store the deck after step 3.
#Note that the initial condition of the deck in step 3 is the deck generated after step 2
deck_after_step_3=(${deck_after_step_2[@]})


for ((i=0;i < ${#deck_after_step_3[@]}; i++))
do
        if [ ${deck_after_step_3[i]} == $jokerA ] || [ ${deck_after_step_3[i]} == $jokerB ]
         then
                #echo "Card i is a Joker.. any of them"
                first_cut
                break
         else
                deck_after_step_3[$i]=${deck_after_step_3[i]}
        fi
done


        for ((j=0;j < ${#rest_of_deck[@]}; j++))
              do
                 if [ ${rest_of_deck[j]} == $jokerA ] || [ ${rest_of_deck[j]} == $jokerB ]
                    then
                                #echo "Card i is a Joker.. any of them"
                                second_and_third_cut
                                break
                    else
                                rest_of_deck[$j]=${rest_of_deck[j]}
                 fi
                        done

deck_after_step_3_aux=(${right_deck[*]} $joker1 ${middle_deck[*]} $joker2 ${left_deck[*]})
#echo "deck after step 3 of keystream is:" ${deck_after_step_3_aux[*]}
}

##############################################
######## STEP 4 - Count Cut
##############################################
convert_card_into_integer () {
card=$1
for (( x=0; x < ${#deck_original[@]}; x++ ))
do
         if [ "${deck_original[x]}" == "$card" ]
                then
                   last_c=$(( $x + 1 ))
                   echo $last_c
                   break
                else
                   deck_original[$x]=${deck_original[x]}

         fi
done

}

function count_cut () {

#Auxiliary Array to store the deck after step 4.
#Note that the initial condition of the deck in step 4 is the deck generated after step 3
deck_after_step_4=(${deck_after_step_3_aux[@]})

last_card=${deck_after_step_4[${#deck_after_step_4[@]}-1]}
last_card_converted_into_number=$(convert_card_into_integer $last_card)

 if [ $last_card == $jokerA ] || [ $last_card == $jokerB ]
         then
                echo "deck after step 4 of keystream is:" ${deck_after_step_4[*]}
         else
                take_last_card_number_of_card_from_top=(${deck_after_step_4[@]:0:$last_card_converted_into_number})
                quantity_of_card_to_remove_from_d_af_step_4=$(( ${#deck_after_step_4[@]} - $last_card_converted_into_number -1 ))
                cut_deck=(${deck_after_step_4[@]:$(( $last_card_converted_into_number  )):( $quantity_of_card_to_remove_from_d_af_step_4 )})
                deck_after_step_4_aux=(${cut_deck[@]} ${take_last_card_number_of_card_from_top[@]} $last_card)

                #echo "deck after step 4 of keystream is:"  ${deck_after_step_4_aux[@]}
 fi

#NOTE: If you use a generic deck, for instance (2 B 9 1 4 A 7 8), notice that the last card here matches the cardinal of
#elements in the deck (quantity) in this case the output deck after step 4 would be (2 B 9 1 4 A 7 8 8) which is clearly wrong.
#Solitaire uses two jokers (53 and 54) and only jokerB=54 would produce this result. But jokers are dimissed in this step.
}

##########################################
###### STEP 4 B - Passphrase Count Cut
###########################################
###########################################
#Auxiliary Array to store the deck after step 4 B.
#Note that the initial condition of the deck in step 4 B is the deck generated after step 4

function passphrase_count_cut () {
deck_after_step_4B=(${deck_after_step_4_aux[@]})

last_cardB=${k[x]}

                take_last_card_number_of_card_from_topB=(${deck_after_step_4B[@]:0:$last_cardB})
                quantity_of_card_to_remove_from_d_af_step_4B=$(( ${#deck_after_step_4B[@]} - $last_cardB -1 ))
                cut_deckB=(${deck_after_step_4B[@]:$(( $last_cardB  )):( $quantity_of_card_to_remove_from_d_af_step_4B )})
                deck_after_step_4B_aux=(${cut_deckB[@]} ${take_last_card_number_of_card_from_topB[@]} $last_card)
   		#echo "deck after step 4B of keystream is:"  ${deck_after_step_4B_aux[@]}
############################################################################
unset -v deck[@]
deck=(${deck_after_step_4B_aux[@]})
}

########################################################################
##################################
##################################
###### STEP 5 - Find Output Card
##################################
##################################
#Auxiliary Array to store the deck after step 5.
#Note that the initial condition of the deck in step 4 is the deck generated after step 4
function find_output_card () {

aux_deck=(${deck_after_step_4_aux[@]/B_Joker/A_Joker})
deck_after_step_5=(${aux_deck[@]})


top_card=(${deck_after_step_5[0]})
top_card_converted_into_number=$(convert_card_into_integer $top_card)  
output_card=${deck_after_step_5[$top_card_converted_into_number]}
output_card_converted_into_number=$(convert_card_into_integer $output_card)

if [ "$output_card" == "$jokerA" ]
 then
        unset -v deck[@]
        deck=(${deck_after_step_4_aux[@]})
        generating_keystream
 else
        output_array+=($output_card_converted_into_number)
        unset -v deck[@]
        deck=(${deck_after_step_4_aux[@]})
fi
}

#################################################################################
#################################################################################
#Auxiliary Encryption functions
#################################################################################
#################################################################################
#
#Convert string message from stdin to an array (but first convert it to lowercase)
################################################################################
################################################################################
# With $1 it is possible to access to the first argument passed to the function
convert_string_into_array () {

lowercase=$(echo $1 | tr [:lower:] [:upper:])

unset result[@]
for (( x=0; x<${#1}; x++))
do
        result[$x]=${lowercase:x:1}
done
}


#################################################################################
#################################################################################
convert_letter_into_integer () {
#The array obtained in the previous step is passed as an argument to this function
unset translate[@]
aux=("${@}")
for (( x=0; x < ${#aux[@]}; x++ ))
do
                        for (( y=0; y <${#letters[@]}; y++ ))
                        do
                                if [ "${aux[x]}" == "${letters[y]}" ]
                                        then
                                                translate+=(${numbers[y]})
                                                break
                                        else
                                                aux[$x]=${aux[x]}

                                fi
                        done

done

}
  
#################################################################################
#################################################################################
convert_integer_into_letter () {
#The array obtained in the previous step is passed as an argument to this function
unset translate[@]
aux=("${@}")
for (( x=0; x < ${#aux[@]}; x++ ))
do
                        for (( y=0; y <${#numbers[@]}; y++ ))
                        do
                                if [ "${aux[x]}" == "${numbers[y]}" ]
                                        then
                                                translate+=(${letters[y]})
                                                break
                                        else
                                                aux[$x]=${aux[x]}

                                fi
                        done

done

}
###################################################################################

modulus_check (){


mod=()
mod=("${@}")

for (( i=0; i < ${#mod[@]}; i++ ))
       do
                if [ $(( ${mod[i]} % 26 )) -eq 0 ]
                        then
                           mod=(${mod[@]/${mod[i]}/26})
                        else
                           modulus=$(( ${mod[i]} % 26))
                           mod=(${mod[@]/${mod[i]}/$modulus})
                fi

done

}



sum_message_and_key () {


for ((i=0; i < ${#m[@]}; i++))
do
        cipher_text_array[$i]=$(( ${m[i]} + ${output_array[i]} ))

done
}

subtract_keystream_from_ciphertext () {

for ((i=0; i < ${#m[@]}; i++))
do
      if [ ${m[i]} -le ${mod[i]} ] 
        then
          subtract=$(( ${m[i]} + 26 ))
          recovered_array[$i]=$(( $subtract - ${mod[i]} ))   
        else
          recovered_array[$i]=$(( ${m[i]} - ${mod[i]} ))
      fi
done


}


fill_message_with_X () {

aux=$(( ${#message_array[@]} % 5 ))
x_to_fill=$(( 5 - $aux ))

if [ $aux -ne 0 ] 
  then
    for (( i = 0; i < $x_to_fill; i++ ))
     do
      message_array+=(X)
    done
  else
      message_array=(${message_array[@]})
    
fi

}

function keying_deck () {

#STEP 1. Move 1 Card down (calls function move_1_card_down and auxiliary)
move_1_card_down

#STEP 2. Move 2 Cards down (calls function move_2_cards_down and auxiliaries)
move_2_cards_down

#STEP 3. Perform a triple cut (calls function triple_cut and auxiliaries)
triple_cut

#STEP 4. Perform a Count cut (calls function count_cut)
count_cut

#STEP 4 B. Perform a Count cut for each character of passphrase (calls function passphrase_count_cut)
passphrase_count_cut

}


function generating_keystream () {

#STEP 1. Move 1 Card down (calls function move_1_card_down and auxiliary)
move_1_card_down

#STEP 2. Move 2 Cards down (calls function move_2_cards_down and auxiliaries)
move_2_cards_down

#STEP 3. Perform a triple cut (calls function triple_cut and auxiliaries)
triple_cut

#STEP 4. Perform a Count cut (calls function count_cut)
count_cut

#STEP 5. Find the output card (calls function find_output_card)
find_output_card

}

########################################################################
########################################################################
########################################################################
#### 1 and 2: Encryption and Decryption                             ####
########################################################################
########################################################################
########################################################################

function enter_message () {

echo "Enter the message (plain text) or the ciphertext: "
read message_string

echo "enter key: "
read keystream_string

}

function convert_message_into_integer () {

convert_string_into_array "$message_string"
message_array=(${result[@]})

convert_string_into_array "$keystream_string"
keystream_array=(${result[@]})

}

function convert_into_integer () {
convert_letter_into_integer ${message_array[@]}
m=(${translate[@]})

convert_letter_into_integer ${keystream_array[@]}
k=(${translate[@]})

}

########################################################################
########################################################################
########################################################################
#### Solitaire Algorithm                                            ####
########################################################################
########################################################################
########################################################################

function solitaire_heart () {

for ((x=0;x < ${#k[@]}; x++))
do

keying_deck

done

for ((x=0;x < ${#m[@]}; x++))
do

generating_keystream

done
}

function format_output () {

output=("${@}")
convert_integer_into_letter ${output[@]}
ciphertext_array=(${translate[@]})

ciphertext_string=$(printf "%s" "${ciphertext_array[@]}")
ciphertext_string_separated_in_groups=$(echo $ciphertext_string | sed 's/.\{5\}/& /g')
}


function encrypt () 
{

convert_message_into_integer
fill_message_with_X
convert_into_integer 
solitaire_heart
sum_message_and_key
modulus_check ${cipher_text_array[@]}
format_output ${mod[@]}
echo "Ciphertext: " $ciphertext_string_separated_in_groups
}

function decrypt () 
{

convert_message_into_integer
convert_into_integer 
solitaire_heart
modulus_check ${output_array[@]}
subtract_keystream_from_ciphertext
format_output ${recovered_array[@]}
echo "Decrypted message is: " $ciphertext_string_separated_in_groups
}

########################################################################
########################################################################
########################################################################
#### 3. Test vectors                                                ####
########################################################################
########################################################################
########################################################################



function test_vectors () {

plaintexts_vector=("AAAAAAAAAAAAAAA" "AAAAAAAAAAAAAAA" "AAAAAAAAAAAAAAA" "AAAAAAAAAAAAAAA" "AAAAAAAAAAAAAAA" "AAAAAAAAAAAAAAA" "AAAAAAAAAAAAAAA" "AAAAAAAAAAAAAAA" "AAAAAAAAAAAAAAA" "AAAAAAAAAAAAAAA" "AAAAAAAAAAAAAAAAAAAAAAAAA" "SOLITAIRE")
keys_vector=(" " "f" "fo" "foo" "a" "aa" "aaa" "b" "bc" "bcd" "cryptonomicon" "cryptonomicon")
ciphertexts_vector=("EXKYI ZSGEH UNTIQ" "XYIUQ BMHKK JBEGY" "TUJYM BERLG XNDIW" "ITHZU JIWGR FARMW" "XODAL GSCUL IQNSC" "OHGWM XXCAI MCIQP" "DCSQY HBQZN GDRUT" "XQEEM OITLZ VDSQS" "QNGRK QIHCL GWSCE" "FMUBY BMAXH NQXCJ" "SUGSR SXSWQ RMXOH IPBFP XARYQ" "KIRAK SFJAN")   

for (( h = 0; h < 12; h++ )) 

do
   deck=(${deck_original[@]})
   unset output_array[@]
   unset ciphertext_array[@]
   unset recovered_array[@]
   unset cmod[@]
   unset cipher_text_array[@]
   message_string=${plaintexts_vector[h]}
   keystream_string=${keys_vector[h]}
   encrypt 

echo "ciphertext in position" $h "of the test vector is: " ${ciphertexts_vector[h]}
echo "ciphertext generated by the encryption function is: " $ciphertext_string_separated_in_groups
r=$ciphertext_string_separated_in_groups
x=${r%?}

if  [ "$x" == "${ciphertexts_vector[h]}" ]
  then
   echo "Test vector matches encryption text"
  else
  echo "Test vector incorrect"

fi

done

}
########################################################################
########################################################################
########################################################################
#### 4. Cipher Consistency Check                                    ####
########################################################################
########################################################################
########################################################################


function generate_random_string_for_consistency_check () {

unset random_array[@]
unset position_in_letters_array

for (( i = 0; i < 10; i++ )) 
do

position_in_letters_array=$((1 + RANDOM%(25-1+1)))
random_array+=(${letters[position_in_letters_array]})

done
random_string=$(printf "%s" "${random_array[@]}")
}


cipher_consistency_check () {

#Using the definition of Symmetric Cipher, the consistency equation D(k, E(k,m)) = m is verified.
#Replace Message_string and keystream_string by a 10 character random message and key. Then It Encrypts and then Decrypts to see if the original message is obtained.
#Be ware that if you manually complete the message and it is not multiple of 5, you have to properly fill it with X


generate_random_string_for_consistency_check
message_string=$random_string
echo "Random message generated: " $message_string
message_string_aux=$message_string

generate_random_string_for_consistency_check
keystream_random_string=$random_string
echo "Random keystream generated: " $keystream_random_string
encrypt

message_string=$ciphertext_string
decrypt

   if [ "$ciphertext_string" == "$message_string_aux" ]
    then
     echo "Consistency equation has been succesfully verified"
    else
      echo "ERROR. Consistency equation has not been verified" 
   fi

}
########################################################################
########################################################################
########################################################################
#### Solitaire's body                                               ####
########################################################################
########################################################################
########################################################################


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

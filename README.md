<h1> The Solitaire Encryption Algorithm in Bash </h1>

This is Bruce Schneier's Solitaire Encryption Algorithm coded in bash. For portability and efficiency purposes, I only use bash internal commands to write this script. 
I have tested it in several operating systems such as Linux debian/Ubuntu, Mac OSX 10.6.8, and even in Windows with Cygwin (in order to port bash).

<HR>

<h4>About Solitaire Algorithm (From schneier.com)</h4>

In Neal Stephenson's novel Cryptonomicon, the character Enoch Root describes a cryptosystem code-named "Pontifex" to another character named Randy Waterhouse, and later reveals that the steps of the algorithm are intended to be carried out using a deck of playing cards. These two characters go on to exchange several encrypted messages using this system. The system is called "Solitaire" (in the novel, "Pontifex" is a code name intended to temporarily conceal the fact that it employs a deck of cards) and It was designed to allow field agents to communicate securely without having to rely on electronics or having to carry incriminating tools. An agent might be in a situation where he just does not have access to a computer, or may be prosecuted if he has tools for secret communication. 

<h4>About the Bash implementation</h4>

Basically, this script is divided in four main functions:
<OL>
<li> <b> Encrypt </b>
<li> <b> Decrypt </b>
<li> <b> Test vectors </b>
I have uploaded the test vectors provided in Schneier's web site (see references). The bash script takes both the plaintext and the key of each test vector and performs first and encrypt operation. The resulting ciphertext is then decrypted using the same key. Finally, if the obtained plaintext is equal to the vector's plaintext the test is successful. 
<li> <b> Cipher consistency check </b>
Solitaire is an output-feedback mode stream cipher. Solitaire is a Symmetric cipher, which means that the key used to encrypt is the same key that is needed to obtain the original plaintext. In the Symmetric ciphers definition,
a cipher defined over (k, m, c) is a pair of “efficient” algorithms (E, D) where <br><br>

E: m,k -> c <br>
D: c,k -> m <br>
<br>
k - key space <br>
m - message <br>
c - cipher text <br>
E - encryption algorithm <br>
D - decryption algorithm <br><br>
The requirement is that the algorithms are <b>consistent </b> (satisfy correctness property). the consistency equation, which all ciphers must satisfy is the following:<br>
<br>
D(k, E(k,m))=m<br>
<br>
The scripts simply verifies this equation in every execution by creating two RANDOM arrays, the key and the message.
</OL>

<h3>Script Execution instructions</h3>
You have two different options to run solitaire implementation in bash: <br>
<ul>
<li> solitaire_bash.sh and external_functions_for_solitaire_bash.sh <br>
<li> solitaire_bash_all_in_one.sh
</ul>
Although both versions behave almost equally, the first version is easier to read because it presents the functions separated from the main body of the script. The external functions are invoked with the bash <k>source </k> command. It is important to notice that both files must be in the same directory for solitaire to be executed.


To run the script you must grant execution permissions to the user by doing<br>

<code>chmod +x solitaire_bash.sh</code><br> 

or <br>

<code>chmod +x solitaire_bash_all_in_one.sh</code><br> 

and then

<code> ./solitaire_bash.sh </code>

or <br>

<code> ./solitaire_bash_all_in_one.sh</code><br>

NOTE. It is not neccessary to grant execution permissions to the external functions file. <br>

<i>References</i>
<ul>
<li><a href=https://www.schneier.com/solitaire.html>Schneier on Security - The Solitaire Encryption Algorithm</a> 
<li><a href=https://www.schneier.com/code/sol-test.txt>Test Vectors</a> 
<li><a href=https://www.coursera.org/course/crypto>Stanford Cryptography I</a> 
</ul>

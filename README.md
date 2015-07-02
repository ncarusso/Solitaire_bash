<h1> The Solitaire Encryption Algorithm in Bash </h1>

This is Bruce Schneier Solitaire's Encryption Algorithm coded in bash. For portability and efficiency purposes, I only use bash internal commands to write this script. 
I have tested it in several operating systems such as Linux debian/Ubuntu, Mac OSX 10.6.8, and even in Windows with Cygwin (in order to port bash).

<HR>

<h4>About Solitaire Algorithm (From schneier.com)</h4>

In Neal Stephenson's novel Cryptonomicon, the character Enoch Root describes a cryptosystem code-named "Pontifex" to another character named Randy Waterhouse, and later reveals that the steps of the algorithm are intended to be carried out using a deck of playing cards. These two characters go on to exchange several encrypted messages using this system. The system is called "Solitaire" (in the novel, "Pontifex" is a code name intended to temporarily conceal the fact that it employs a deck of cards) and It was designed to allow field agents to communicate securely without having to rely on electronics or having to carry incriminating tools. An agent might be in a situation where he just does not have access to a computer, or may be prosecuted if he has tools for secret communication. 

<h4>About This Bash implementation</h4>

Basically, this script is divided in four main functions:
<OL>
<li> <b> Encrypt </b>
<<li> <b> Decrypt </b>
<li> <b> Test vectors </b>
I have uploaded the test vectors provided in Schneier's web site (see references). The bash script takes both the plaintext and the key of each test vector and performs first and encrypt operation. The resulting ciphertext is then decrypted using the same key. Finally, if the obtained plaintext is equal to the vector's plaintext the test is successful. 
<li> <b> Cipher consistency check </b>
Solitaire is an output-feedback mode stream cipher. Solitaire is a Symmetric cipher, which means that the key used to encrypt is the same key that is needed to obtain the original plaintext. The Symmetric ciphers definition
A cipher defined over (K, M, C) is a pair of “efficient” algorithms (E, D) where

E: M,K -> C 
D: C,K -> M

K - key space
M - message space
C - cipher text
E - encryption algorithm
D - decryption algorithm
The requirement is that the algorithms are <b>consistent </b> (satisfy correctness property). the consistency equation, which all ciphers must satisfy is the following:

D(k, E(k,m))=m

The scripts simply verifies this equation in every execution by creating two RANDOM arrays, the key and the message.
</OL>

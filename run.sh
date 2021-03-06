# The challenge is to take a csv file produced by Midicsv and to compress it as much as possible and to also have the smallest decoder possible, so to minimize csv compressed size + decoder size
# The midi is  Beethoven's Sonata No. 1 (1st Movement), the first midi link at:
# https://www.mutopiaproject.org/cgibin/make-table.cgi?collection=beetson&amp;preview=1
# Midicsv can be found at https://www.fourmilab.ch/webtools/midicsv/
# The source csv file is 115,850 bytes
# What I did was make an encoder awk script which takes the deltas of the 2nd column, which is the time, making a lot of the rows identical and can be represented by a number, the number is an index into an array of unique rows
# now the encoded file looks like a list of unique rows followed by numbers and the decoder script has to match up the numbers with the unique row list to get the original file back

# The result is a file that is 27884 bytes long which can then be zipped with 7z to produce a file that is 6652 bytes, if we just zip the original csv with 7z the result is 9696 bytes

# first get the midi from the above url then run: ./midicsv LVB_Sonate_02no1_1.mid LVB.csv

cat LVB.csv | gawk -f enc.awk  > vz

cat vz | gawk -f dec.awk  > v

cmp v LVB.csv


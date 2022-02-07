BEGIN{
# n will be the number associated with each unique string in the compressed file
n=0

# m counts the total number of lines
m=0

# v stores the int for each unique line
delete v

# l stores every string

delete l
}

{
# first we do deltas for second column 
# last is the last second column value
# cur_a2 is the current value

last = cur_a2
o = split($0, a, ",")
cur_a2 = a[2]
r=""
a[2] = a[2]-last

# note that we convert string to int which removes spaces so we have to put a space back
a[2] = " "a[2]

# now we rebuilt the string after doing deltas and store it in r
for (i=1;i<=o;i++)
{
 if (i<o)
  r = r""a[i]","
 else {
 r = r""a[i]""
 }
}

# now we decide if the result string r is to be printed into the compressed file, so that the decompressor knows what the full string is or if the string has already appeared to ignore it
if (v[r] == "")
  {
  n = n+1
  v[r] = n
  print r
  }
else
  {}
  
m = m+1
l[m] = r
}

END{
# here we are printing ints which are indicies into the list of unique strings we printed out above

for (i=1;i<=m;i++)
  {
  # l stored every lines indexed by ints
  t=l[i]
  
  # v is indexed by r strings, the string after undoing deltas
  u=v[t]
  print u
  }
}

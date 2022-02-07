BEGIN{
# the cumulative total for column 2 which undoes the delta encoding
rec=0

n=0
m=0
delete v
delete l
# to store or not to store
st = 1
}

{
# when you have strings with 1 field you have reached the ints section, which need to be replaced by strings, you can stop storing the ints now int

if (NF == 1) {st=0 }

if (st) {
 n = n+1
 # v stores whole line
 # t stores second column
 v[n] = $0
 t[n] = $2
 }
else {
# if we're not storing we're decompressing, i.e matching ints to unique strings

 # $0 here is an int so v returns the unique line and stores it in u
 u = v[$0]

# now we need to undo the deltas so we take the current value of 2nd col and store it in cur for now
 cur = t[$0]

# u, the current line needs to be split so the delta can be undone
 n = split(u, a, "")

# rec is the correct value for 2nd col, it's the cumulative value
 rec = rec + cur

# this is a tricky one, we split u on every character, so we will traverse every character of u but we need to replace col 2 once and then ignore the rest of col 2 value, that's what c and d are for
# c counts the characters of col 2 and d checks whether we've printed the correct value or not

 c = 1
 d = 0
 for (i=1; i<=n; i++)
 {
 if (a[i] == ",")
 {
  c = c + 1
  printf a[i]
 }
 else if (c==2) {
 if (d==0)
  printf " "rec
 d = 1
 }
 else {
  printf a[i]
  }
 }
 
 # we're using printf so no newline will be printed, needs to be done manually
 print ""
 }

}

END{
}


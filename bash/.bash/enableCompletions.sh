# Execute all completion files in ./completions/
curdirName=`dirname $0`
for file in "$curdirName/completions/*.bash"
do
  printf "Adding completion: $file\n"
  source $file
done


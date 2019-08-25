# find command 

find . -type f -name "*.java" -exec grep -l StringBuffer {} \;

alias ff="find . -type f -name"

# prezto 
find-exec "*.java" ls -ltr

find . -mmin 10 

find . -size +1G

# awk & sed 

sed -i.bak 's/hell/hello/' test.txt

sed -i '$ a hello linux' test # append at end of file



# tcpdump 

# netstat 

# jq

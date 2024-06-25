output_file="2_answer"
ps -aux > tmp
awk -F " " {'if (NR>1 && ($11 ~ /^\/sbin\//)) {print $2}'} tmp > $output_file
rm -f tmp

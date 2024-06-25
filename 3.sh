output_file="3_answer"
ps -aux | sort -nk2 | tail -1 | awk -F " " {'{print $0}'} > $output_file

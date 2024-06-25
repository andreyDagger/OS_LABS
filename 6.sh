file_answer=""
max_memory=$((-1))
for FILE in /proc/*/statm;
do
	cur_memory=$(awk -F " " {'{print $2}'} $FILE)
	if [[ $max_memory -lt $cur_memory ]]
	then
		max_memory=$((cur_memory))
		file_answer=$FILE
	fi
done

echo $file_answer
echo $max_memory

#Table 1-3: Contents of the statm files (as of 2.6.8-rc3)
#..............................................................................
# Field    Content
# size     total program size (pages)        (same as VmSize in status)
# resident size of memory portions (pages)   (same as VmRSS in status)
# shared   number of pages that are shared   (i.e. backed by a file, same
#                                             as RssFile+RssShmem in status)
# trs      number of pages that are 'code'   (not including libs; broken,
#                                             includes data segment)
# lrs      number of pages of library        (always 0 on 2.6)
# drs      number of pages of data/stack     (including libs; broken,
#                                             includes library text)
# dt       number of dirty pages             (always 0 on 2.6)

pid_first=$(cat .pid)
pid_second=$(cat .pid2)

truncate -s 0 Mem_total
truncate -s 0 Mem_free
truncate -s 0 Mem_used
truncate -s 0 Mem_buff_cache
truncate -s 0 Swap_total
truncate -s 0 Swap_free
truncate -s 0 Swap_used
truncate -s 0 Swap_avail_mem
truncate -s 0 pid1_cpu
truncate -s 0 pid1_mem
truncate -s 0 pid2_cpu
truncate -s 0 pid2_mem
truncate -s 0 pos1
truncate -s 0 pos2
truncate -s 0 pos3
truncate -s 0 pos4
truncate -s 0 pos5

touch Mem_total
touch Mem_free
touch Mem_used
touch Mem_buff_cache

touch Swap_total
touch Swap_free
touch Swap_used
touch Swap_avail_mem

touch pid1_cpu
touch pid1_mem
touch pid2_cpu
touch pid2_mem

touch pos1
touch pos2
touch pos3
touch pos4
touch pos5

while true
do
	#Mem=$(top -n 1 | head -4 | tail -1)
	#echo $(echo $Mem | awk -F " " '{print $4}') >> Mem_total
	#echo $(echo $Mem | awk -F " " '{print $6}') >> Mem_free
	#echo $(echo $Mem | awk -F " " '{print $8}') >> Mem_used
	#echo $(echo $Mem | awk -F " " '{print $10}') >> Mem_buff_cache
	
	#Swap=$(top -n 1 | head -5 | tail -1)
	#echo $(echo $Swap | awk -F " " '{print $3}') >> Swap_total
	#echo $(echo $Swap | awk -F " " '{print $5}') >> Swap_free
	#echo $(echo $Swap | awk -F " " '{print $7}') >> Swap_used
	#echo $(echo $Swap | awk -F " " '{print $9}') >> Swap_avail_mem
	
	#echo ""
	
	pid1_inf=$(top -n 1 | grep $pid_first)
	echo $(echo $pid1_inf | awk -F " " '{print $10}') >> pid_cpu
	echo $(echo $pid1_inf | awk -F " " '{print $11}') >> pid_mem
	#pid2_inf=$(top -n 1 | grep $pid_second)
	#echo $(echo $pid2_inf | awk -F " " '{print $10}') >> pid2_cpu
	#echo $(echo $pid2_inf | awk -F " " '{print $11}') >> pid2_mem
	
	#echo ""
	
	#top -n 1 | head -8 | tail -1
	#top -n 1 | head -9 | tail -1
	#top -n 1 | head -10 | tail -1
	#top -n 1 | head -11 | tail -1
	#top -n 1 | head -12 | tail -1
	
	#echo ""
	
	#pos1_var=$(top -n 1 | awk '{if ($2 == $pid1) {print NR}}')
	#pos1_var=$((pos1_var-6))
	#pos2_var=$(top -n 1 | awk '{if ($2 == $pid2) {print NR}}')
	#pos2_var=$((pos2_var-6))
	#pos3_var=$(top -n 1 | awk '{if ($2 == $pid3) {print NR}}')
	#pos3_var=$((pos3_var-6))
	#pos4_var=$(top -n 1 | awk '{if ($2 == $pid4) {print NR}}')
	#pos4_var=$((pos4_var-6))
	#pos5_var=$(top -n 1 | awk '{if ($2 == $pid5) {print NR}}')
	#pos5_var=$((pos5_var-6))
	
	#echo $pos1_var >> pos1
	#echo $pos2_var >> pos2
	#echo $pos3_var >> pos3
	#echo $pos4_var >> pos4
	#echo $pos5_var >> pos5
	
	#pid1=$(top -n 1 | head -8 | tail -1 | awk -F " " '{print $2}')
	#pid2=$(top -n 1 | head -9 | tail -1 | awk -F " " '{print $2}')
	#pid3=$(top -n 1 | head -10 | tail -1 | awk -F " " '{print $2}')
	#pid4=$(top -n 1 | head -11 | tail -1 | awk -F " " '{print $2}')
	#pid5=$(top -n 1 | head -12 | tail -1 | awk -F " " '{print $2}')

	#echo $pid1 >> pos1
	#echo $pid2 >> pos2
	#echo $pid3 >> pos3
	#echo $pid4 >> pos4
	#echo $pid5 >> pos5
	
	#echo ""
	sleep 1
done

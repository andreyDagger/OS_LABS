file="kek"

while IFS= read -r line; do
  dmesg | grep $line
done < "$file"

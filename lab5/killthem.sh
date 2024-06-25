file="killlist"

while IFS= read -r line; do
  kill $line
done < "$file"

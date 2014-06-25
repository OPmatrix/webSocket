for i in $(seq 400) 
do
  node client.js 7 $i & 
done

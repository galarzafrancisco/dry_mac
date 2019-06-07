#!/bin/bash

sleep_time=300

cpus=$(sysctl hw.logicalcpu | awk '{ print $2 }')
echo "CPUs detected: $cpus"
processes=$(( cpus - 1 ))
echo "Creating $processes processes..."

for ((i=0; i<$processes; i++)); do
 echo "Creating process number $i..."
 yes > /dev/null &
 pids[$i]=$(echo "$!") 
 echo "PID: ${pids[$i]}"
done

echo "PIDs: ${pids[*]}"

echo "Sleeping for $sleep_time seconds."
sleep $sleep_time

for pid in "${pids[@]}"; do
 echo "Killing process $pid..."
 kill $pid
done

echo "All done :)"

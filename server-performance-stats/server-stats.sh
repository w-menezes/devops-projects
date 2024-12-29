#!/usr/bin/bash

get_cpu_usage() {
    echo -e "\n### CPU Usage ###"
    top -bn1 \
    | grep "%Cpu(s):" | cut -d ',' -f 4 \
    | awk '{printf "CPU Usage: %.2f%%\n", $1}'
}

get_memory_usage() {
    echo -e "\n### Memory Usage ###"
    free | grep "Mem:" -w \
    | awk '{printf "Total: %.1fGi\nUsed: %.1fGi (%.2f%%)\nFree: %.1fGi (%.2f%%)\n\n",$2/1024^2, $3/1024^2, $3/$2 * 100, $4/1024^2, $4/$2 * 100}'
}

get_disk_usage() {
    echo -e "\n### Disk Usage ###"
    df -h | grep "/" -w \
    | awk '{printf "Total: %sG\nUsed: %s (%.2f%%)\nFree: %s (%.2f%%)\n\n",$3 + $4, $3, $3/($3+$4) * 100, $4, $4/($3+$4) * 100}'
}

get_proc_by_cpu() {
    echo -e "\n### Top 5 Processes by CPU Usage (%) ###"
    ps -eo pid,comm,%cpu --sort=-%cpu \
    | head -n 6
    echo -e "\n"
}

get_proc_by_mem() {
    echo -e "\n### Top 5 Processes by Memory Usage (%) ###"
    ps -eo pid,comm,%mem --sort=-%mem \
    | head -n 6
    echo -e "\n"
}

# TODO: format and display stats

echo -e "\n#####################"
echo -e "### Server  Stats ###"
echo -e "#####################"

get_cpu_usage
get_memory_usage
get_disk_usage
get_proc_by_cpu
get_proc_by_mem
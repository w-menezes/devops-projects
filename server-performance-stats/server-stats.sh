#!/usr/bin/bash

get_os_and_user_info() {
    echo -e "\n### Operating System ###"
    lsb_release -a | grep "Description" \
        | awk '{printf "OS Version: %s  %s  %s \n",$2, $4, $5}'
    uptime -p | awk '{printf "System Uptime: "; for(i=2; i<=NF; i++) printf "%s ", $i; print""}'
    who | wc -l | awk '{printf "Number of logged-in users: %s\n", $1}'
    who | awk '{printf "Logged-in users: %s\n", $1}'
    echo -e "\n-----------------------------"
}

get_disk_usage() {
    echo -e "\n### Disk Usage ###"
    df -h | grep "/" -w \
        | awk '{printf "Total: %si\nUsed: %si (%.2f%%)\nFree: %si (%.2f%%)\n",$2, $3, $3/($2) * 100, $4, $4/($2) * 100}'
    echo -e "\n-----------------------------"
}

get_cpu_usage() {
    echo -e "\n### CPU Usage ###"
    top -bn1 | grep "%Cpu(s):" | cut -d ',' -f 4 \
        | awk '{printf "CPU Usage: %.2f%%\n", $1}'
}

get_proc_by_cpu() {
    echo -e "\n### Top 5 Processes by CPU Usage (%) ###"
    ps -eo pid,comm,%cpu --sort=-%cpu \
        | head -n 6
    echo -e "\n-----------------------------"
}

get_memory_usage() {
    echo -e "\n### Memory Usage ###"
    free | grep "Mem:" -w \
        | awk '{printf "Total: %.1fGi\nUsed: %.1fGi (%.2f%%)\nFree: %.1fGi (%.2f%%)\n",$2/1024^2, $3/1024^2, $3/$2 * 100, $4/1024^2, $4/$2 * 100}'
}

get_proc_by_mem() {
    echo -e "\n### Top 5 Processes by Memory Usage (%) ###"
    ps -eo pid,comm,%mem --sort=-%mem \
        | head -n 6
    echo -e "\n-----------------------------"
}


# display server stats
echo -e "\n#####################"
echo -e "### Server  Stats ###"
echo -e "#####################"

get_os_and_user_info
get_disk_usage
get_cpu_usage
get_proc_by_cpu
get_memory_usage
get_proc_by_mem
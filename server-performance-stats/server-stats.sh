#!/usr/bin/bash

get_cpu_usage() {
    echo -e "\n### CPU Usage ###"
    top -bn1 | grep "%Cpu(s):" | cut -d ',' -f 4 | awk '{print "CPU Usage: " 100-$1 "%"}'
}

get_memory_usage() {
    echo -e "\n### Memory Usage ###"
    free | grep "Mem:" -w \
    | awk '{printf "Total: %.1fGi    |    Used: %.1fGi (%.2f%%)    |    Free: %.1fGi (%.2f%%)\n",$2/1024^2, $3/1024^2, $3/$2 * 100, $4/1024^2, $4/$2 * 100}'
}

get_disk_usage() {
    echo -e "\n### Disk Usage ###"
    df -h --total \
    | awk '/^total/ {printf "Total: %.1fG    |    Used: %.1f(%.1f%)    |    Free: %.1f(%.1f%)\n", $2,$3,$5,$4, $4/$2 * 100}'
}

get_proc_by_cpu() {
    echo -e "\n### Top 5 Processes by CPU Usage (%) ###"
    ps -eo pid,comm,%cpu --sort=-%cpu \
    | head -n 6
}

get_proc_by_mem() {
    echo -e "\n### Top 5 Processes by Memory Usage (%) ###"
    ps -eo pid,comm, %mem --sort=-%mem \
    | head -n 6
}

# TODO: format and display stats
#!/usr/bin/bash

get_cpu_usage() {
    top -bn1 | grep "%Cpu(s):" | cut -d ',' -f 4 | awk '{print "CPU Usage: " 100-$1 "%"}'
}

get_memory_usage() {
    free | grep "Mem:" -w \
    | awk '{printf "Total: %.1fGi    |    Used: %.1fGi (%.2f%%)    |    Free: %.1fGi (%.2f%%)\n",$2/1024^2, $3/1024^2, $3/$2 * 100, $4/1024^2, $4/$2 * 100}'
}

get_disk_usage() {
    df -h --total \
    | awk '/^total/ {printf "Total: %.1fG    |    Used: %.1f(%.1f%)    |    Free: %.1f(%.1f%)\n", $2,$3,$5,$4, $4/$2 * 100}'
}

# TODO: list top 5 proc by CPU usage
# TODO: list top 5 proc by mem usage
# TODO: format and display stats
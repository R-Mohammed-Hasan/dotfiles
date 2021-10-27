# Alias commands supported by grc
if (( ${+commands[grc]} )); then
    () {
        local grc_commands=(blkid df dig dnf du env free gcc getfacl getsebool
                            ifconfig ip iptables last lsattr lsblk lsmod lspci
                            mount mtr netstat nmap ping ps pv semanage ss stat
                            sysctl systemctl tcpdump traceroute tune2fs ulimit
                            uptime vmstat wdiff)
        local grc_command

        for grc_command in ${grc_commands[@]}; do
            if (( ${+commands[$grc_command]} )) && [[ -f "/usr/local/share/grc/conf.${grc_command}" || -f "/usr/share/grc/conf.${grc_command}" ]]; then
                if (( ${+aliases[$grc_command]} )); then
                    alias ${grc_command}="grc --colour=auto $(whence -f ${grc_command})"
                else
                    alias ${grc_command}="grc --colour=auto ${grc_command}"
                fi
            fi
        done

        for grc_command in w who; do
            if (( ${+commands[$grc_command]} )); then
                if (( ${+aliases[$grc_command]} )); then
                    alias ${grc_command}="grc --colour=auto $(whence -f ${grc_command})"
                else
                    alias ${grc_command}="grc --colour=auto ${grc_command}"
                fi
            fi
        done
    }
fi

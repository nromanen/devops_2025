**[google drive > task_9](https://drive.google.com/drive/folders/1RQ19otMdNyh7XkNfdDf_5wk1-EpC5UHT?usp=sharing)**

- [x] ** Check the status of the network interface.**  Use `atop`,` htop`, and `btop` utilities to display running processes on your OS.
 > `sudo dnf update && sudo dnf install htop -y`
 > `sudo dnf install atop -y`
 > `sudo dnf install btop -y`

- [x] **Ping the localhost** with a set of 10 packets, each with a size of 1500 bytes.
 > ` ping -c 10 -s 1500 127.0.0.1`

- [x] **Ping an external host** by its name and obtain its IP address. Trace the route to the external host (e.g., softerveinc.com).
 > `nslookup softerveinc.com`
 > `ping -c 10 google.com`
 > `traceroute google.com`

- [x] **Check your DNS configuration.**
 > `nslookup localhost`
 > `dig localhost`
 > `host -t A localhost`

- [x] **Review the firewall rules** (iptables or ufw). List the open ports on your system using `netstat` and `ss`.
 > `sudo ss -tulnp`

- [x] If you are using DHCP, ** verify that your system is obtaining an IP address correctly.** Change the IP address using the `dhclient` command. Show the results.
 > `ifconfig`
- [] **Check the network configuration files.** Add a static IP address to an existing interface. Apply the changes and verify correct operation.
- [] **Restart network services** to apply any changes made during troubleshooting. Check the firewall status on your system.
- [] **Use the `tcpdump` utility** to display traffic through the Ethernet port, including IP addresses and port numbers.
- [] Check system logs for network-related errors. Common logs include `syslog`, `messages`, `access`, and `network.log`.

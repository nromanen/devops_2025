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
 > `sudo dnf install dhclient`
 > `sudo dhclient`
 > `ip a` check IP, then to setting [link](https://drive.google.com/file/d/1Thvm3ty9QgSIZvuMg1PrDk1Y0ULH2Si7/view?usp=sharing)
 > `sudo dhclient -r eth1` Killed old client process [link](https://drive.google.com/file/d/1jEowfeOgoZUR6TbA7S9JiqEuWapDK2lT/view?usp=sharing)
 > `ip a` check IP, then to setting [link](https://drive.google.com/file/d/1BeMNZu9JLD6WONMOCh0K3HgploeCqZMu/view?usp=sharing)
 > `sudo dhclient -v eth1` [link](https://drive.google.com/file/d/1xR3ZSPLIUkBkZcf7fk6H_p4QDqSG8URX/view?usp=sharing)
 > `sudo systemctl restart NetworkManager` restart network services
 >`ip a` [link](https://drive.google.com/file/d/1wjjDgNMDoAMOhFqIJbWB6ifNhIrl_6o2/view?usp=sharing)
 >> Here, not everyone understands what is happened! You may give me coment?

- [x] **Check the network configuration files.** Add a static IP address to
an existing interface. Apply the changes and verify correct operation.
 > `ifconfig -a`
 > `vi /etc/netplan/01-netcfg.yaml`
 > `sudo netplan apply` or `sudo netplan --debug apply` [link](https://drive.google.com/file/d/1Omv8CjzK2gXgeV2v82M1CfV5kGncvZGm/view?usp=sharing)
 > `ping -c 5 192.168.56.1` [link](https://drive.google.com/file/d/1zyHZdiSkeMraLeDCEpj8g3Rj_4iQ6twF/view?usp=sharing)

- [x] **Restart network services** to apply any changes made during troubleshooting. Check the firewall status on your system.
 > `sudo systemctl restart NetworkManager`
 > `sudo systemctl status firewalld`Check the firewall status on your system [link](https://drive.google.com/file/d/1wqmkE_PdCMFrmA9Eb6OKHl8f7KssoTdQ/view?usp=sharing)

- [x] **Use the `tcpdump` utility** to display traffic through the Ethernet port, including IP addresses and port numbers.
 > `sudo tcpdump -i eth0` [link](https://drive.google.com/file/d/114Y1LlvcUodQesExXpvZ4EWcyWARzOy_/view?usp=sharing)
 > `sudo tcpdump -i any -c 5` [link](https://drive.google.com/file/d/1-acktdhKURJvchmVeY0gbjmEqwrxB9NO/view?usp=sharing)
 > `sudo tcpdump -i any -c5 -nn port 22` [link](https://drive.google.com/file/d/1h3hSV4tkhPNoqez8ynVXLZg8RxWAALMU/view?usp=sharing) 

- [x] Check system logs for network-related errors. Common logs include `syslog`, `messages`, `access`, and `network.log`.
 > `journalctl -u NetworkManager -f` [link](https://drive.google.com/file/d/1umNkrfHLGY5-6DKqhUtSkpJ859dQuIP8/view?usp=sharing)
 > `grep -i 'network' /var/log/messages` [link](https://drive.google.com/file/d/12nVL8VawubJf_itYqmUyoiA70bdqrdgo/view?usp=sharing)

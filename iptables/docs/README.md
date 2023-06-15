# iptables

## Introduction

iptables is a management tool for netfilter, the firewall software in the Linux kernel. netfilter is located in the user space and is part of netfilter. netfilter is located in the kernel space and has not only network address conversion, but also packet content modification and packet filtering firewall functions.

<figure > 
<p align="center">
  <img src="./assets/iptables.jpg" alt="iptables" style="background-color:white" />
  <p align="center">iptables</p> 
</p>
</figure>

The iptables version used in the Init container is v1.6.0 and contains 5 tables.

- RAW is used to configure packets. Packets in RAW are not tracked by the system.
- The filter is the default table used to house all firewall-related operations.
- NAT is used for network address translation (e.g., port forwarding).
- Mangle is used for modifications to specific packets (refer to corrupted packets).
- Security is used to force access to control network rules.

The chain types in the different tables are as follows.

|Rule name|raw|filter|nat|mangle|security|
|---|---|---|---|---|---|
|PREROUTING|✓||✓|✓||
|INPUT||✓||✓|✓|
|OUTPUT|✓|✓|✓|✓|✓|
|POSTROUTING|||✓|✓||
|FORWARD||✓||✓|✓|

## Understand iptables rules
View the default iptables rules in the istio-proxy container, the default view is the rules in the filter table.
```sh
iptables -L -v
```
We see three default chains, INPUT, FORWARD, and OUTPUT, with the first line of output in each chain indicating the chain name (INPUT/FORWARD/OUTPUT in this case), followed by the default policy (ACCEPT).

The following is a proposed structure diagram of iptables, where traffic passes through the INPUT chain and then enters the upper protocol stack, such as:
<figure > 
<p align="center">
  <img src="./assets/iptables-chains.jpg" alt="iptables-chains" style="background-color:white" />
  <p align="center">iptables</p> 
</p>
</figure>

Multiple rules can be added to each chain and the rules are executed in order from front to back. Let’s look at the table header definition of the rule.

`PKTS`: Number of matched messages processed
`bytes`: cumulative packet size processed (bytes)
`Target`: If the message matches the rule, the specified target is executed.
`PROT`: Protocols such as TDP, UDP, ICMP, and ALL.
`opt`: Rarely used, this column is used to display IP options.
`IN`: Inbound network interface.
`OUT`: Outbound network interface.
`source`: the source IP address or subnet of the traffic, the latter being anywhere.
`destination`: the destination IP address or subnet of the traffic, or anywhere.

There is also a column without a header, shown at the end, which represents the options of the rule, and is used as an extended match condition for the rule to complement the configuration in the previous columns. prot, opt, in, out, source and destination and the column without a header shown after destination together form the match rule. TARGET is executed when traffic matches these rules.

## Types supported by TARGET

Target types include ACCEPT, REJECT, DROP, LOG, SNAT, MASQUERADE, DNAT, REDIRECT, RETURN or jump to other rules, etc. You can determine where the telegram is going by executing only one rule in a chain that matches in order, except for the RETURN type, which is similar to the return statement in programming languages, which returns to its call point and continues to execute the next rule.

From the output, you can see that the Init container does not create any rules in the default link of iptables, but instead creates a new link.


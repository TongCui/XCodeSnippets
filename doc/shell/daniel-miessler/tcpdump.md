
## tcpdump is the premier network analysis tool for information security professionals.


# Just see what’s going on, by looking at all interfaces.

```
$ tcpdump -i any

```


# Basic view of what’s happening on a particular interface.

```
$ tcpdump -i eth0
```

# One of the most common queries, this will show you traffic from 1.2.3.4, whether it’s the source or the destination.

```
$ tcpdump host 1.2.3.4
$ tcpdump src 2.3.4.5 
$ tcpdump dst 3.4.5.6

```

```
$ tcpdump ip6
$ tcpdump less 32
$ tcpdump greater 64
$ tcpdump <= 128
```

# Let’s find all traffic from 10.5.2.3 going to any host on port 3389.

```
$ tcpdump -nnvvS src 10.5.2.3 and dst port 3389
```


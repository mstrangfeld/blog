+++
draft = false
date = 2020-04-27
title = "IPv6 UDP Sockets with Python 3"
description = ""
slug = "ipv6-udp-sockets-python"
tags = ["python", "networking"]
categories = ["quick-tip"]
series = []
+++

Today I wanted to trace the syscalls that are made when using an IPv6 UDP socket.
This is one of the reasons I love Python because it enables me to quickly write and test code.

I thought this might be useful for some of you:

`udp_ipv6_client.py`
```python
#!/usr/bin/env python3

import socket

UDP_IP = "::1"  # localhost
UDP_PORT = 5005
MESSAGE = "Hello, World!"

print("UDP target IP:", UDP_IP)
print("UDP target port:", UDP_PORT)
print("message:", MESSAGE)

sock = socket.socket(socket.AF_INET6, # Internet
                        socket.SOCK_DGRAM) # UDP
sock.sendto(MESSAGE.encode("UTF-8"), (UDP_IP, UDP_PORT))
```

`udp_ipv6_server.py`
```python
#!/usr/bin/env python3

import socket

UDP_IP = "::" # = 0.0.0.0 u IPv4
UDP_PORT = 5005

sock = socket.socket(socket.AF_INET6, # Internet
                        socket.SOCK_DGRAM) # UDP
sock.bind((UDP_IP, UDP_PORT))

while True:
    data, addr = sock.recvfrom(1024) # buffer size is 1024 bytes
	print("received message:", data.decode("UTF-8"))
```

The code is based on [this GitHub gist by tuxmartin](https://gist.github.com/tuxmartin/e64d2132061ffef7e031).
I just made some changes to run it with Python 3.

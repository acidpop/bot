#!/usr/bin/env python
#
# A simple command line magic packet sender for WOL enabled devices
# Copyright (c) 2013, Petros Kyladitis <http://www.multipetros.gr/>
#
# This is free software distributed under the terms of FreeBSD license
      
      
        

import socket
import re
import argparse


def wol(macAddress, broadcastAddress="192.168.1.255", port=9):
    soc = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
    soc.setsockopt(socket.SOL_SOCKET, socket.SO_BROADCAST, 1)
    sendBytes = soc.sendto("\xff"*6 + GetMacHex(macAddress)*16, (broadcastAddress, port))
    return sendBytes


def GetMacHex(macAddress, separator=":"):
    if(macAddress.find(separator) == -1):
        separator = "-"
    macHex = macAddress.lower().replace(separator, "")
    if(re.match("[0-9a-f]{12}$", macHex)):
        return macHex.decode("hex")
    else:
        raise Exception("MAC address is not valid")


def main():
    parser = argparse.ArgumentParser(description="Send WOL magic packet to the selected MAC destination", epilog="(c) 2013, Petros Kyladitis. This is free software distributed under the terms of FreeBSD license. For updates and more info see at <http://www.multipetros.gr/>")
    parser.add_argument("mac", help="The MAC address of the machine you want to send the magic packet. Digits could be separated by \':\' or \'-\'", metavar="MAC_ADDRESS")
    parser.add_argument("-b", "--broadcast", default="192.168.1.255", dest='broadcast', help="The network broadcast address, in dotted format: www.xxx.yyy.zzz", metavar="BROADCAST_ADDRESS")
    parser.add_argument("-p", "--port", default="9", dest="port", help="The listening port usually 7 or 9. (By default, the program use port 9)", metavar="PORT_NUM")
    args = parser.parse_args()
    try:
        port = int(args.port)
        if((port < 1) or(port>65535)):
            raise Exception
    except Exception:
        print("Port must be a valid integer between 1-65535")
        return
    try:
        sendBytes = wol(args.mac, args.broadcast, port)
        print("Done! " + str(sendBytes) + " bytes send")
    except socket.gaierror:
        print(args.broadcast + " is not a valid broadcast address")
    except Exception as err:
        print(err)


if __name__ == "__main__":
    main()

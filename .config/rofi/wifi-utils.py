#! /usr/bin/env python3
from subprocess import Popen, PIPE 

def cmd_pipe(cmd_str: str):
    command = cmd_str.split(' ')
    process = Popen(command, stdout=PIPE, stderr=PIPE)
    stdout, stderr = process.communicate()

    if stderr != b'':
        raise Exception(stderr.decode("utf-8"))

    return stdout.decode("utf-8")

def icon(signal: str):
    s = int(signal)
    if   s > 90:
        return "\0icon\x1fsignal-100"
    elif s > 60:
        return "\0icon\x1fsignal-75"
    elif s > 30:
        return "\0icon\x1fsignal-50"
    else:
        return "\0icon\x1fsignal-25"

wifi_list = cmd_pipe("nmcli -g IN-USE,SIGNAL,SSID d wifi").split('\n')[:-1]

options = ""
for i in wifi_list:
    wifi = i.split(":")
    option = wifi[2]
    if wifi[0] == "*":
        option += " (Connected)"
    option += icon(wifi[1])

    options += f"{option}\n"

print(repr(options))

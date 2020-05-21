#!/bin/bash
#homework commands
sudo journalctl -p alert -b -0
journalctl --disk-usage
sudo journalctl --vacuum-files=2

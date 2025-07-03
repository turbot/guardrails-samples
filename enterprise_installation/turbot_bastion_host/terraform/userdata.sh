#!/bin/bash
echo "Bastion host will shut down after ${lifetime_hours} hour(s)"
shutdown -h +$((lifetime_hours * 60))

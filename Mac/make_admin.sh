#!/bin/bash


sudo dscl . -append /groups/admin GroupMembership $1


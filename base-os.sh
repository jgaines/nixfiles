#!/bin/sh

# This is very much a WIP

# For nix on ubuntu systems, this script will install some
# tools and set up some config.

# Stuff I want to have installed in a base linux environment,
# mostly so I can run them as root.

sudo apt install -y \
    aide \
    build-essential \
    curl \
    htop \
    jq \
    nano \
    ripgrep \
    silversearcher-ag \
    tree \
    unzip \
    wget

# vulnix

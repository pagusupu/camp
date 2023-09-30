#!/usr/bin/env bash

if [ "$(makoctl mode)" = "default" ]; then
    exec "$(makoctl mode -a do-not-disturb)";
else 
    exec "$(makoctl mode -r do-not-disturb)";
fi
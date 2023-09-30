#!/usr/bin/env bash

if [ "$(makoctl mode)" = "default" ]; then
    printf '{"text":"","class":"enabled"}';
else
    printf '{"text":"","class":"disabled"}';
fi
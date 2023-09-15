#!/usr/bin/env bash

if pgrep -x wl-screenrec; then
    printf '{"text":"","class":"recording"}';
else
    printf '{"text":""}';
fi
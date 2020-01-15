#!/bin/bash

if [ "$XDG_SESSION_DESKTOP" = "xfce" ]
then
  dirNum=$(synclient | grep VertScrollDelta | egrep -o '[0-9]+')

  cmd1="synclient VertScrollDelta=-$dirNum"
  $cmd1
fi


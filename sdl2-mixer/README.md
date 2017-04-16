
# SDL2_mixer (Debian/Ubuntu)

Patched package to allow building, not for distribution!

Reason why it is needed: 

 - OBS does not support universe repository for Ubuntu
 - OBS does not support backports for Debian

## Patches:

 - removed all external library dependencies (fluidsynth, mad, ogg, flac, modplug)

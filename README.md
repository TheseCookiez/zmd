# ZMD
A simple reverse shell for Windows written in Zig
### Build
This has no dependencies, so you can just clone, set IP/port and build.
```
zig build-exe src\main.zig -target x86_64-native -O ReleaseSmall -fstrip -fsingle-threaded
```

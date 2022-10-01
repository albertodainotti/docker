# Docker Images

Original description from Alistair:
This image is designed to be used with a little bash alias that I
cooked up to drop me into an ubuntized version of my current
directory. I use this to quickly switch from a macOS environment to
Ubuntu in order to build and test software (especially some C software
that I was working on that didn't support macOS at all).

To build the image:

```
cd ubuntu-dev
./buildme.sh {distro} {release} {devel|slim}
```
By default it builds "ubuntu latest devel" and will call the docker image `ubuntu-mydevel-jammy` (assuming "jammy" is the latest ubuntu)


The build script has some extra features:
- It will add a user/group that will be used as default user for the container and add to such user's home the .bashrc .bash_profile and .gitconfig that are in the ubuntu-dev folder
Edit buildme.sh to change the name of the user/group
- It will create a /work folder owned by such user/group
If you run the container with the following docker run options, it will also bind the current folder to a subfolder of /work with the same name and start the container with such folder as working directory: `-v $(pwd):/work/$(basename $(pwd)) -w /work/$(basename $(pwd))`


The bash alias from Alistair:
```
alias dh='docker run -it --rm -v $(pwd):/work/$(basename $(pwd)) -w /work/$(basename $(pwd)) ubuntu-dev /bin/bash'
```
The one above uses `--rm` to automatically remove the container when it exits. If you're aiming at a more persistent use of the container:  
```
alias dh='docker run -it -v $(pwd):/work/$(basename $(pwd)) -w /work/$(basename $(pwd)) ubuntu-dev /bin/bash'
```

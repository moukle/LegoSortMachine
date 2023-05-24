# README
## Requirements
### Files
- [STLs.zip](https://projects.ifw.maschinenbau.tu-darmstadt.de/index.php/f/281902) and unzip to `./stl/`
- `./data` `./images` dirs
- [BrickScanner](https://github.com/flowmeadow/BrickScanner) repository

```bash
# src
git clone https://github.com/flowmeadow/BrickScanner

# download STLs zip
unzip STLs.zip

# setup dirs
mkdir data images
cp BrickScanner/resources/base_obb_data.pkl ./data
```

### Docker
A docker image is provided. Necessary dependencies (LDView+Parts, Python+requirements) are installed and setup.
Because of many graphical outputs we use `x11docker`.

See below for instructions:
```shell
# building the image
docker buildx build --tag lego .

# running with GUI
# https://github.com/mviereck/x11docker
x11docker --interactive --webcam \
    -- \
    "-v $(pwd)/BrickScanner:/lego/src \
    -v $(pwd)/stl:/lego/stl \
    -v $(pwd)/data:/lego/data \
    -v $(pwd)/images:/lego/images" \
    lego bash

# without GUI (cams not tested...)
docker-compose run --rm --build scanner 
```
# README

This README provides instructions for setting up and using the BrickScanner project for the LEGO sorting machine.

## Requirements
### Files
Before starting, make sure you have the following files and directories:
- `./data` and `./images` directories
- [STLs.zip](https://projects.ifw.maschinenbau.tu-darmstadt.de/index.php/f/281902) (download and unzip to `./stl/`)
- [BrickScanner](https://github.com/flowmeadow/BrickScanner) repository

To set up the necessary files and directories, follow these steps:
```bash
# Clone the BrickScanner repository
git clone https://github.com/flowmeadow/BrickScanner

# Download STLs.zip and unzip it
unzip STLs.zip

# Copy the base_obb_data.pkl file
cp BrickScanner/resources/base_obb_data.pkl ./data
```

### Docker
A Docker image is provided with the necessary dependencies already installed and set up.
We use [x11docker](https://github.com/mviereck/x11docker) to handle graphical outputs.

- Docker: [Installation Guide](https://docs.docker.com/desktop/install/linux-install/)
- x11docker: [Installation](https://github.com/mviereck/x11docker#tldr)

## Usage
Follow the steps below to build and run the BrickScanner project.

1. **Build**: to build the image, run the following command:
    ```shell
    docker buildx build --tag lego .
    ```

2. **Run**:
    - with GUI (recommended)
        ```shell
        x11docker --interactive --webcam \
            -- \
            "-v $(pwd)/BrickScanner:/lego/src \
            -v $(pwd)/stl:/lego/stl \
            -v $(pwd)/data:/lego/data \
            -v $(pwd)/images:/lego/images" \
            lego bash
        ```
    - without GUI (cams not tested...)
        ```shell
        docker-compose run --rm --build scanner 
        ```
    
    After running the above command, you will have an interactive shell inside the Docker container. From there, you can run the provided scripts, such as real_recon.py, as follows:
    ```sh
    ./real_recon.py
    ```
    This should produce an output similar to this: 
    ![](https://0x0.st/HbS0.png)

**NOTE**: all directories are mounted as `VOLUME` which means all changes on the host will be directly reflected inside the container and vice versa.

### Cameras
If you have cameras, make sure they are mounted under `/dev/video#`. By default, the `StereoCam` class assumes camera indices `0` and `2`. Adjust these indices based on your camera setup. You can use the command `mpv /dev/video#` to determine the correct indices for your cameras.
# MouseSuite Docker

## Purpose

MouseSuite Docker is a GPU-enabled container that contains several of the MouseSuite programs and their dependencies. It facilitates rapid deployment of the MouseSuite tools.

## Authors
MouseSuite Docker is maintained by David Shattuck at UCLA. The software inside the container is developed primarily by the MouseSuite team. Please see the individual program sites for further details.

## Contents
MouseSuite Docker currently includes the following tools and their dependencies:

* [rodbfc](https://github.com/MouseSuite/rodbfc)
* [rodreg](https://github.com/MouseSuite/rodreg)
* [mousebse](https://github.com/MouseSuite/MouseBSE)
* [rstr](https://github.com/MouseSuite/rstr)
* [maskbackgroundnoise](https://github.com/MouseSuite/maskbackgroundnoise)

## Requirements
Install the Docker engine as described here: https://docs.docker.com/engine/install/

## Building
Retrieve this repo using:
```
git clone https://github.com/MouseSuite/MouseSuiteDocker.git
```

This repository include a `makefile` for building the Docker image. 
To build, simply cd into the MouseSuiteDocker and type:
```
make
```
This will download all of the software packages and dependences. Please note that building the Dockerfile from scratch can take several minutes.

## License
This project is licensed under the GPL (V2) License - see the [LICENSE.txt](LICENSE.txt) file for details.

## Usage
You can invoke MouseSuite Docker the command line as follows:
```
docker run -it --rm mousesuite 
```

This will show you the available programs:
```
usage:
mousesuite [rodbfc|rodreg|mousebse|maskbackgroundnoise|rstr]
```

To run one of them, add it to the command line call, e.g., this will run `rodreg` and show you the help for it:
```
docker run -it --rm mousesuite rodreg
```
You can add arguments for `rodreg` (inputs, outputs, etc.) on the above command line call immediately after `rodreg`.

You will need to bind some local directory to be able to process data with the Docker; you can do this using the `-v` flag when `docker` is invoked. If you have a GPU, you will wnat to enable it using `--runtime=nvidia --gpus`:
```
docker run -it --rm -v${path}:/data --runtime=nvidia --gpus all mousesuite [rodbfc|rodreg] [args]
```
For example, to run rodreg on an image in a folder named `/data` in the current directory:
```
docker run -it --rm -v${PWD}/data:/data --runtime=nvidia --gpus all mousesuite rodreg /data/moving_file.nii.gz /data/fixed_file.nii.gz /data/output_file.nii.gz
```
This will register moving_file.nii.gz to fixed_file.nii.gz and store the result in output_file.nii.gz.

# Acknowledgments
This project is supported by NIH Grant R01-NS121761 (PIs: David Shattuck and Allan MacKenzie-Graham).

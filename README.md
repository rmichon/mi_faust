# Faust Mass Interaction

This repository contains a series of tools to design Mass-Interaction physical models in the [Faust programming language](https://faust.grame.fr). [MIMS](TODO:URL) (Mass Interaction Model Scripter) is at the heart of this system. This command-line tool written in Python can be used to generate structured Faust code from a textual description of a physical model. Models are described in a format similar to ACROE’s PNSL: each physical element has a specific label, specific physical parameters or initial conditions, etc.  Parameters can be added to this description and shared by any number of physical modules, allowing global variation of the physical attributes (stiffness, damping, mass, etc.) of a subset of modules in real-time.

## General Organization

```
/documentation  : Documentation files
/examples       : MIMS example files and their corresponding Faust programs
/examples/faust : Faust programs generated from the MIMS examples files
/faust          : Faust libraries (i.e., mi.lib)
/python         : Contains physics2Faust.py
```

## Documentation

The `/documentation` folder contains a LAC paper which is currently the best documentation of this project.

## Credits

This project is the fruit of a collaboration between [GIPSA-Lab](TODO:URL) (Grenoble INP, France) and [GRAME-CNCM](https://grame.fr) (Lyon, France). 

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

This project is the fruit of a collaboration between [GIPSA-Lab](http://www.gipsa-lab.fr/) (Grenoble INP, France) and [GRAME-CNCM](https://grame.fr) (Lyon, France). 

## Sources

All the algorithms implemented in `mi_faust` and presented in this repository are in the public domain and are disclosed in the following scientific publications:

* Claude Cadoz, Annie Luciani, Jean-Loup Florens, Curtis Roads and Françoise Chabade. Responsive Input Devices and Sound Synthesis by Stimulation of Instrumental Mechanisms: The Cordis System. Computer Music Journal, Vol 8., No. 3, 1984.
* Claude Cadoz, Annie Luciani and Jean Loup Florens. CORDIS-ANIMA: A Modeling and Simulation System for Sound and Image Synthesis: The General Formalism. Computer Music Journal. Vol. 17, No. 1, 1993.
* Alexandros Kontogeorgakopoulos and Claude Cadoz. Cordis Anima Physical Modeling and Simulation System Analysis. In Proceedings of the Sound and Music Computing Conference (SMC-07), Lefkada, Greece, 2007.
* Nicolas Castagne, Claude Cadoz, Ali Allaoui and Olivier Tache. G3: Genesis Software Environment Update. In Proceedings of the International Computer Music Conference (ICMC-09), Montreal, Canada, 2009.
* Nicolas Castagné and Claude Cadoz. Genesis 3: Plate-forme pour la création musicale à l'aide des modèles physiques Cordis-Anima. In Proceedings of the Journée de l'Informatique Musicale, Grenoble, France, 2009. 
* Edgar Berdahl and Julius O. Smith. An Introduction to the Synth-A-Modeler Compiler: Modular and Open-Source Sound Synthesis using Physical Models. In Proceedings of the Linux Audio Conference (LAC-12), Stanford, USA, 2012.
* James Leonard and Claude Cadoz. Physical Modelling Concepts for a Collection of Multisensory Virtual Musical Instruments. In Proceedings of the New Interfaces for Musical Expression (NIME-15) Conference, Baton Rouge, USA, 2015.

## License

The MIT License (MIT)

Copyright (c) <2019> <GRAME-CNCM (Lyon, France) and Gipsa-Lab (Grenoble, France)>

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software. THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

<p align="center">
<img src="https://github.com/turboseb/html5-3dmodel-viewer/blob/master/Assets/Illustrations/large_logo.png" width="600"> <br/> 

### <p align="center"> Allows you to create a web viewer for your 3D scene.

# Concept
The 3D Scene Viewer Maker generates a web visualisation program from imported 3D files.\
Import your scene to generate a web program which can be hosted on sites like itch.io.
## Currently supported formats
- .glb / .gltf

## Features
- Orbital navigation
- Custom Color Setter
- Light parameters
- Environment parameters
- Generated file is itch.io compatible

  ### Planned Features
  - Alternate navigation methods
  - Custom loading screen

  ### [Documentation](https://html5-3dmodel-viewer-documentation.readthedocs.io/en/latest/)

# How to use
- Download the latest build.
- Launch 3D_Scene_Packer.exe / 3D_Scene_Packer.x86_64.
- Press "<img src="https://github.com/turboseb/html5-3dmodel-viewer/blob/master/Assets/Icons/download_black.svg#gh-light-mode-only" width="15"><img src="https://github.com/turboseb/html5-3dmodel-viewer/blob/master/Assets/Icons/download_white.svg#gh-dark-mode-only" width="15"> Import 3D scene (.glb/.gltf)" and import your file or drag-and-drop on the window.
- Choose your scene parameters.
- Press "<img src="https://github.com/turboseb/html5-3dmodel-viewer/blob/master/Assets/Icons/package_black.svg#gh-light-mode-only" width="15"><img src="https://github.com/turboseb/html5-3dmodel-viewer/blob/master/Assets/Icons/package_white.svg#gh-dark-mode-only" width="15"> Export Project" to save the .zip file on your device.

# How does it work?
The programs packs your imported 3D scene as as .pck file and adds it to a [blank viewer](https://github.com/turboseb/html5-3dmodel-viewer-blank-project/releases/tag/v1.0.0) compressed file.\
The Viewer preloads the package on startup and loads the scene.

# Built in
<p align="center">
<img src="https://github.com/turboseb/html5-3dmodel-viewer/blob/master/icon.svg" width="128"> <br/> 


  
## <p align="center"> Godot Engine 4.5.stable
</p>

Godot has full support for **glTF 2.0** with both text (.gltf) and binary (.glb) formats.
This standard allows to import complex 3D scenes.<br/>
**glTF** is continuously being developed, new updates will allow more flexibility with this tool.

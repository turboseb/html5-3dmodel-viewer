<p align="center">
<img src="https://github.com/turboseb/html5-3dmodel-viewer/blob/master/large_logo.png" width="600"> <br/> 

### <p align="center"> Allows you to create a web viewer for your 3D scene.

# Concept
The 3D Scene Viewer Maker generates a web visualisation program from imported 3D files.\
Import your scene to generate a web program which can be hosted on sites like itch.io.

<p align="center">
<img src="https://github.com/turboseb/html5-3dmodel-viewer/blob/master/Illustrations/3d_scene_viewer.gif" width="300">

## Currently supported formats
- .glb / .gltf

## Features
- Orbital navigation
- Custom Color Setter
- Generated file is itch.io compatible
<p align="center">
<img src="https://github.com/turboseb/html5-3dmodel-viewer/blob/master/Illustrations/3d_scene_packer.gif" width="300">

  ### Planned Features
  - Alternate navigation methods
  - Light parameters
  - Environment parameters
  - Custom loading screen

# How to use
- Download the latest build.
- Launch 3D Scene Packer.exe.
- Press "Import 3D scene (.glb/.gltf)" and import your file or drag-and-drop on the window.
- Choose your scene parameters.
- Press "Export Project" to save the .zip file on your device.

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

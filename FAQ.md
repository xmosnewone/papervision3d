# Initialisation #
## Why is my render window empty? ##
Way too many possibilities... start first with:

### Have you created the necessary scene, camera, objects and materials? ###
For objects to be seen, they need to have a visible material, be placed in the scene and rendered from a camera that looks at them.

### Are you using a valid container for the scene? ###
Make sure your scene container visible, centred in the screen and included in the Display List.

### Have you added the objects to the scene? ###
Use scene.addChild( object ) to place the objects into the scene.

### Is the camera looking at the objects? ###
Try placing your objects at (0,0,0) and use a Camera3D camera that by default targets the coordinate origin.

### Is your camera INSIDE a model you've placed in your scene? ###
Try moving your camera backwards on the z plane. You can also try to make the object smaller.

### Is your object too SMALL for your camera configuration? ###
Move the camera closer to the object and adjust the zoom property. You can also try to make the model bigger, supply a higher scaling factor when loading or just scaling them up with the object scale properties.

### Are you trying to render a black cat on a black background? ###
Try to change the background color.

### Are you looking through the back sides of an object? ###
Generally materials are rendered on one side of the object. Try making the material.doubleSided = true.

### In your main loop, are you calling the renderCamera method to process the 3D scene and generate a 2D view? ###
Use scene.renderCamera( camera ) every time you want to update the rendered view. Setting up an onEnterFrame event is recommended for this.

# Materials #

## Textures ##

### Why do my textures distort with perspective? ###
This rendering artifact is a collateral effect of the linear texture mapping technique. While the performance is very good, textures tend to distort as they face away from the camera.

In PV3D v1.9 and above, you can use a 'Precise' material to solve this issue. Note that precise materials cost more in CPU usage, so use them sparingly.

# Objects #

### How can I rotate an object from the corner rather than the center? ###
Create a 'dummy' DisplayObject3D and addChild() your object to it at the position you want to pivot... then rotate the dummy.
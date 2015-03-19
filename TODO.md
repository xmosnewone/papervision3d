GreatWhite 2.0 Beta
### Bugs ###
  * **Scale.** Fix private scale values. constrainedScale read only property, to maintain aspect ratio. Keep scaling on lookAt.

### Review ###
  * **Javadocs.** Review also comments.

### Scenes ###
  * **Layers.** Numbered layers that are rendered in separate containers. Scene.container should contain layers, and inside of those the individual object containers.
  * **Containers on children.**
  * **Post processing loop.** Executed after the render loop. Used for effects such as depth shading, depth of field blur and near plane alpha.
  * **Face culling.** Based on its normal.

### Cameras ###
  * **Field of view.** Property to adjust zoom and focus at once.
  * **Optical conversion.** To translate common camera settings.

### Objects ###
  * **Polygon support** For non bitmap rendering.
  * **Texture interaction.** Covert screen to texture coordinates. Translate object events.
  * **Extrude, revolution.** Check Joa and Sole's work.

### Tween animation ###
  * **Jim's 3D splines.** Check out his work.

### Skeleton animation ###
  * **Check out Tim and Jim's work.**
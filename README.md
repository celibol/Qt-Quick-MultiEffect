**About**

QuickMultiEffect is a Qt Quick component for fast, animated effects. It combines a subset of Qt Graphical Effects (with some extras) into a single item and shader effect. This shader is dynamically created based on which features/effects user enables, to make it always as optimal as possible. QuickMultiEffect is notably more performant than using multiple Qt Graphical Effects when the amount of effects increases.

**QuickMultiEffect features**

Supported effects that can be freely mixed and matched:
* blur
* shadow
* brightness
* contrast
* saturation
* colorize
* mask

Shaders are generated for both Compatibility profile (e.g. OpenGL ES 2.0) and Core profile (OpenGL 3.3+).

QuickMultiEffect component is pure Qt Quick / QML (no C++) which makes it easy to integrate into Qt Quick applications.

The package contains QuickMultiEffect component with API documentation and 4 example applications (Testbed, ItemSwitcher, EffectsBench, QDSTester).

**Example applications:**
* **Testbed:** Allows testing all features separately or together, while confirming that generated shaders are optimal. Also assists in customizing / extending the shader for specific needs.
* **EffectsBench:** Compares performance of QuickMultiEffect vs. Qt Graphical Effects when the amount of effects is increased.
* **ItemSwitcher:** Presents one example usage for QuickMultiEffect. Allows switching between QtQuick items using a set of fancy animations (Blinds, Thunder, 3DFlip etc.). Based on the examples it is easy to implement own custom switching animations.
* **QDSTester:** Can be used to tweak QuickMultiEffect properties of a simple source item with Qt Design Studio and animate the properties using Qt Design Studio timeline.

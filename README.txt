# AdvancedGameTest

A 3D game demo using JMonkey Engine (JME3) that showcases basic 3D graphics, texturing, lighting, and water effects.

## Features

- Textured rotating cube with lighting
- Semi-transparent water surface
- Sky background
- Dynamic lighting with ambient and directional lights
- First-person camera controls

## Requirements

- Java 21 JDK or later
- Gradle (automatically downloaded by the wrapper)

## How to Run

### Using Gradle (Recommended)
1. Open a terminal in the project root directory
2. Run:
   ```bash
   ./gradlew run
   ```

### Using an IDE
1. Open the project in your IDE (IntelliJ IDEA recommended)
2. Let it sync with Gradle
3. Run the `AdvancedGameTest.java` file

## Controls

- WASD - Move around
- Mouse - Look around
- Space - Move up
- Z - Move down
- Esc - Exit game

## Project Structure

```
src/
├── main/
│   ├── java/
│   │   └── advancedgametest/
│   │       └── AdvancedGameTest.java  # Main game class
│   └── resources/
│       └── Textures/
│           └── brick.jpg              # Cube texture
```

## Technical Details

- Uses JMonkey Engine 3.7.0-stable
- Implements basic 3D rendering with:
  - Phong lighting model
  - Texture mapping
  - Transparency
  - Scene graph management
  - Camera controls

## Building for Distribution

The project includes tasks for creating distributable packages for different platforms:

```bash
# Create Windows distribution
./gradlew zipWindowsDistribution

# Create Linux distribution
./gradlew zipLinuxDistribution

# Create Mac distribution
./gradlew zipMacDistribution

# Create all distributions
./gradlew buildAllDistributions
```

Distributions will be created in the `build/distributions` folder.

## Development Notes

- The game uses a simple water implementation with a semi-transparent quad
- Lighting includes both directional (sun) and ambient light
- The cube uses the Lighting.j3md material definition with diffuse texture
- Camera is set up for smooth first-person navigation

## Contributing

Feel free to fork this project and enhance it. Some possible improvements:
1. Add wave animation to the water
2. Implement advanced water effects with reflections
3. Add more 3D objects and interactions
4. Enhance the lighting system
5. Add game mechanics

## License

This project uses JMonkey Engine which is licensed under BSD 3-Clause License.

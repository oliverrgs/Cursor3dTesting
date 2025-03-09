package advancedgametest;

import com.jme3.app.SimpleApplication;
import com.jme3.material.Material;
import com.jme3.math.ColorRGBA;
import com.jme3.renderer.RenderManager;
import com.jme3.scene.Geometry;
import com.jme3.scene.shape.Box;
import com.jme3.scene.shape.Quad;
import com.jme3.texture.Texture;
import com.jme3.math.Vector3f;
import com.jme3.scene.Node;
import com.jme3.light.DirectionalLight;
import com.jme3.light.AmbientLight;
import com.jme3.post.FilterPostProcessor;
import com.jme3.renderer.queue.RenderQueue.ShadowMode;
import com.jme3.renderer.queue.RenderQueue.Bucket;
import com.jme3.material.RenderState.BlendMode;
import com.jme3.math.FastMath;

/**
 * This is the Main Class of your Game. It should boot up your game and do initial initialisation
 * Move your Logic into AppStates or Controls or other java classes
 */
public class AdvancedGameTest extends SimpleApplication {

    private float time = 0.0f;
    private float waterHeight = -6f;
    private Vector3f lightDir = new Vector3f(-4.9236743f, -1.27054665f, 5.896916f);
    private Geometry waterGeom;

    public static void main(String[] args) {
        AdvancedGameTest app = new AdvancedGameTest();
        app.setShowSettings(false);
        app.start();
    }

    @Override
    public void simpleInitApp() {
        // Setup camera
        cam.setLocation(new Vector3f(0, 10, 10));
        cam.lookAt(new Vector3f(0, 0, 0), Vector3f.UNIT_Y);
        flyCam.setMoveSpeed(15f);

        // Set sky color
        viewPort.setBackgroundColor(new ColorRGBA(0.5f, 0.7f, 0.9f, 1.0f));

        // Create a textured box
        Box b = new Box(1, 1, 1);
        Geometry geom = new Geometry("Box", b);
        
        // Create material with lighting
        Material mat = new Material(assetManager, "Common/MatDefs/Light/Lighting.j3md");
        
        // Load and set the diffuse texture
        Texture texture = assetManager.loadTexture("Textures/brick.jpg");
        mat.setTexture("DiffuseMap", texture);
        
        // Set some material properties
        mat.setBoolean("UseMaterialColors", true);
        mat.setColor("Diffuse", ColorRGBA.White);
        mat.setColor("Ambient", ColorRGBA.White);
        mat.setColor("Specular", ColorRGBA.White);
        mat.setFloat("Shininess", 64f);
        
        geom.setMaterial(mat);
        geom.setShadowMode(ShadowMode.CastAndReceive);
        
        // Add some basic lighting
        DirectionalLight sun = new DirectionalLight();
        sun.setDirection(lightDir);
        sun.setColor(ColorRGBA.White.mult(1.5f));
        rootNode.addLight(sun);
        
        AmbientLight ambient = new AmbientLight();
        ambient.setColor(ColorRGBA.White.mult(0.3f));
        rootNode.addLight(ambient);
        
        // Position the box above water
        geom.move(0, 2, -3);
        
        rootNode.attachChild(geom);
        
        // Make the box rotate slowly
        geom.rotate(0.5f, 0.5f, 0);

        // Create water plane
        Quad quad = new Quad(400, 400);
        waterGeom = new Geometry("water", quad);
        Material waterMat = new Material(assetManager, "Common/MatDefs/Misc/Unshaded.j3md");
        waterMat.setColor("Color", new ColorRGBA(0.0f, 0.5f, 0.5f, 0.8f));
        waterMat.getAdditionalRenderState().setBlendMode(BlendMode.Alpha);
        waterGeom.setMaterial(waterMat);
        waterGeom.setQueueBucket(Bucket.Transparent);
        waterGeom.rotate(-FastMath.HALF_PI, 0, 0);
        waterGeom.center().move(0, waterHeight, 0);
        rootNode.attachChild(waterGeom);
    }

    private float rotationSpeed = 1f;
    
    @Override
    public void simpleUpdate(float tpf) {
        // Rotate the box
        Geometry box = (Geometry) rootNode.getChild("Box");
        box.rotate(0, tpf * rotationSpeed, 0);
        
        // Update time
        time += tpf;
    }

    @Override
    public void simpleRender(RenderManager rm) {
        //add render code here (if any)
    }
}

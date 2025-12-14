package SSH;
import java.lang.reflect.*;
public abstract class MessageDigest {
    
    public static MessageDigest getInstance(String algorithm)
	throws InstantiationException, IllegalAccessException, ClassNotFoundException
    {
	Class c;
        c = Class.forName("SSH." + algorithm + "State");
	return (MessageDigest)c.newInstance();
    }
    
    // INSTANCE METHODS

    /** Return the name of the algorithm used by this HashState object. */
    public abstract String getName();
    
    /** Reset the state. */
    public abstract void reset();
    
    /**
     * Update the fingerprint state with the bytes from
     * <code>buf[offset, offset+length-1]</code>. */
    public abstract void update(byte[] buf, int offset, int length);
    
    /** Update the fingerprint state with the bytes from <code>buf</code>. */
    public void update(byte[] buf){
        update(buf, 0, buf.length);
    }
    
    /** Update the fingerprint state with the characters from <code>s</code>. */
    public void update(String s){
        update(s.getBytes());
    }
    
    /**
     * Return a digest for the curret state, without
     * destroying the state. */
    public abstract byte[] digest();
    
    /**
     * Return the number of bytes needed to make a valid hash. If a multiple
     * of this number of bytes is hashed, no padding is needed. If no such
     * value exists, returns 0. */
    public abstract int blockSize();
    
    /**
     * Returns the size of a fingerprint in bytes. */
    public abstract int hashSize();

}

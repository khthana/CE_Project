//@ role: generate integer number 
//parameter: none
//comment: คลาสนี้ถูกใช้สำหรับสร้างค่าที่เป็นเลข integer สำหรับใช้ในการทำ padding หรือสำหรับข้อมูลที่ต้องการสุ่ม

package SSH;
import java.util.Random;

public class SecureRandom extends Random {

    MD5State.SubState ss = new MD5State.SubState();
    private int t;

    public static int secureLevel = 0;

    public SecureRandom() {
        t=Spinner.guessTime(1024);

	int paranoia = ((secureLevel > 0) ? 2 : 1);

	for(int i=0; i<paranoia; i++) {
            // Estimate about 4 bits of entropy per call to spinner
            for(int j=ss.buffer.length-1; j>=0; j--) {
                // Fill the buffer with spin-counts from the Spinner class.
                ss.buffer[j] = (byte)Spinner.spin(t);
		if(secureLevel < 2)
		    ss.buffer[--j] = (byte)System.currentTimeMillis();
	    }
            ss.transform(ss.buffer,0);
	}
        unused=new byte[16];
        unusedPos=16;
    }

    public SecureRandom(byte[] seed) {
	try {
	    MD5State md5 = new MD5State();
	    md5.update(seed);
	    ss = md5.state;
	} catch (Exception e) {
	    // !!!
	    System.out.println("Can't operate, MD5 not available...");
	}
        t = Spinner.guessTime(1024);
        unused=new byte[16];
        unusedPos=16;
    }

    /** unused[unusedPos..15] is unused pseudo-random numbers. */
    byte[] unused;
    int unusedPos;

    int poolSweep=0;

    /** Get new unused bytes. */
    private void update() {
        // Inject entropy into the pool
	//
	if(secureLevel > 1) {
	    ss.buffer[poolSweep++] += Spinner.spin(t) + 1;
	    ss.buffer[poolSweep++] += Spinner.spin(t) + 1;
	} else {
	    ss.buffer[poolSweep++] += Spinner.bogusSpin();
	    ss.buffer[poolSweep]   += ss.buffer[poolSweep - 1];
	}
	poolSweep++;

        poolSweep %= 64;

        ss.transform(ss.buffer,0);
        writeBytes(ss.hash[0], unused, 0,4);
        writeBytes(ss.hash[1], unused, 4,4);
        writeBytes(ss.hash[2], unused, 8,4);
        writeBytes(ss.hash[3], unused,12,4);
        unusedPos=0;
    }
    
    /** Generates the next random number. */
    protected synchronized int next(int bits){
        //System.out.println(bits);
        if(unusedPos==16)
            update();
        int r=0;
        for(int b=0; b<bits; b+=8)
            r = (r<<8) + unused[unusedPos++];
        return r;
    }

    public static final void writeBytes(long a, byte[] dest, int i, int length){
        for (int j=i+length-1; j>=i; j--){
            dest[j]=(byte)a;
            a = a >>> 8;
        }
    }

}

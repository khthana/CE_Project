package JavaIDEX;

import com.sun.jdi.ThreadReference;
import com.sun.jdi.ThreadGroupReference;
import com.sun.jdi.IncompatibleThreadStateException;
import com.sun.jdi.StackFrame;
import java.util.List;
import java.util.ArrayList;
import java.io.*;

class ThreadInfo {
    static ThreadInfo current = null;
    private static ThreadInfo[] threads;
    private static ThreadGroupReference group = null;

    final ThreadReference thread;
    int currentFrameIndex = 0;

    private ThreadInfo(ThreadReference thread) {
        this.thread = thread;
        if (thread == null) {
            Env.fatalError("Internal error: null ThreadInfo created");
        }
    }

    List stack() throws IncompatibleThreadStateException {
        return thread.frames();
    }

    StackFrame getCurrentFrame() throws IncompatibleThreadStateException {
        if (thread.frameCount() == 0) {
            //Env.out.println("No stack");
            return null;
        }
        return thread.frame(currentFrameIndex);
    }

    static synchronized ThreadInfo[] threads() {
        if (threads == null) {
            ThreadIterator ti = threadIterator();
            List tlist = new ArrayList();
            while (ti.hasNext()) {
                ThreadInfo tinfo = new ThreadInfo(ti.nextThread());
                tlist.add(tinfo);
            }
            threads = (ThreadInfo[])tlist.toArray(new ThreadInfo[tlist.size()]);
        }
        return threads;
    }
            

    void invalidate() {
        currentFrameIndex = 0;
    }

    static synchronized void invalidateAll() {
        current = null;
        threads = null;
        group = null;
    }

    /* Throw IncompatibleThreadStateException if not suspended */
    private void assureSuspended() throws IncompatibleThreadStateException {
        if (!thread.isSuspended()) {
            throw new IncompatibleThreadStateException();
        }
    }

    /**
     * Change the current stackframe to be one or more frames higher
     * (as in, away from the current program counter).
     *
     * @param nFrames	the number of stackframes
     * @exception IllegalAccessError when the thread isn't 
     * suspended or waiting at a breakpoint
     * @exception ArrayIndexOutOfBoundsException when the 
     * requested frame is beyond the stack boundary
     */
    void up(int nFrames) throws IncompatibleThreadStateException {
        assureSuspended();
        if ((currentFrameIndex + nFrames) >= thread.frameCount()) {
            throw new ArrayIndexOutOfBoundsException();
        }
        currentFrameIndex += nFrames;
    }

    /**
     * Change the current stackframe to be one or more frames lower
     * (as in, toward the current program counter).     *
     * @param nFrames	the number of stackframes
     * @exception IllegalAccessError when the thread isn't 
     * suspended or waiting at a breakpoint
     * @exception ArrayIndexOutOfBoundsException when the 
     * requested frame is beyond the stack boundary
     */
    void down(int nFrames) throws IncompatibleThreadStateException {
        assureSuspended();
        if ((currentFrameIndex - nFrames) < 0) {
            throw new ArrayIndexOutOfBoundsException();
        }
        currentFrameIndex -= nFrames;
    }

    static void setThreadGroup(ThreadGroupReference tg) {	
        ThreadInfo.invalidateAll();
        group = tg;
    }
    
    static void setCurrentThread(ThreadReference tr) { 
        if (tr == null) {
            current = null;
        } else {
            ThreadInfo tinfo = getThread(tr);
            current = tinfo;
            current.invalidate();
        }
    }
    
    static ThreadGroupReference group() {
	if (group == null) {
            // set system threadgroup
            // TO DO: handle multiple btter
	    setThreadGroup((ThreadGroupReference)
                           Env.vm().topLevelThreadGroups().get(0));
	}
        return group;
    }
    
    static synchronized ThreadInfo getThread(int index) {
        if (index <= 0 || index > threads().length) {
            return null;
        }
        return threads()[index-1];
    }

    static synchronized ThreadInfo getThread(ThreadReference tr) {
        ThreadInfo[] thrs = threads();
        int cnt = thrs.length;
        for (int i = 0; i < cnt; ++i) {
            ThreadInfo tinfo = thrs[i];
            if (tinfo.thread.equals(tr)) {
                return tinfo;
            }
        }
        Env.out.println("Thread not found: " + tr.name());
        return null;
    }

    static ThreadInfo getThread(String idToken) {
        ThreadInfo tinfo = null;
        if (idToken.startsWith("t@")) {
            idToken = idToken.substring(2);
        }
        try {
            int threadId = Integer.valueOf(idToken).intValue();
            tinfo = getThread(threadId);
        } catch (NumberFormatException e) {
            tinfo = null;
        }
        return tinfo;
    }

    static ThreadIterator threadIterator() {
        return new ThreadIterator(group());
    }
}
                            

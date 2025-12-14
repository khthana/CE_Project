package JavaIDEX;

import com.sun.jdi.Location;
import com.sun.jdi.AbsentInformationException;
import java.util.Map;
import java.util.HashMap;
import java.util.List;
import java.util.ArrayList;
import java.util.StringTokenizer;
import java.io.*;

class SourceMapper {

    private final String[] dirs;

    SourceMapper(String sourcepath) {
        StringTokenizer st = new StringTokenizer(sourcepath, File.pathSeparator);
        List dlist = new ArrayList();
        while (st.hasMoreTokens()) {
            dlist.add(st.nextToken());
        }
        dirs = (String[])dlist.toArray(new String[0]);
    }

    /**
     * Return a File cooresponding to the source of this location.
     * Return null if not available.
     */
    File sourceFile(Location loc) {
        try {
            String filename = loc.sourceName();
            String refName = loc.declaringType().name();
            int iDot = refName.lastIndexOf('.');
            String pkgName = (iDot >= 0)? refName.substring(0, iDot+1) : "";
            String full = pkgName.replace('.', File.separatorChar) + filename;
            for (int i= 0; i < dirs.length; ++i) {
                File path = new File(dirs[i], full);
                if (path.exists()) {
                    return path;
                }
            }
            return null;
        } catch (AbsentInformationException e) {
            return null;
        }
    }

    /**
     * Return a BufferedReader cooresponding to the source 
     * of this location.
     * Return null if not available.
     * Note: returned reader must be closed.
     */
    BufferedReader sourceReader(Location loc) {
        File sourceFile = sourceFile(loc);
        if (sourceFile == null) {
            return null;
        }
        try {
            return new BufferedReader(new FileReader(sourceFile));
        } catch(IOException exc) {
        }
        return null;
    }
}
        

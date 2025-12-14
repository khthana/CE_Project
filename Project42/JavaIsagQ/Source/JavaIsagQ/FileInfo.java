package IsecQ;

import java.io.*;
class FileInfo {
	public static void main(String args[]) throws IOException {
		File f = new File("FileInfo.java");
		System.out.println("File name: "+ f.getName());
		System.out.println("Path: "+ f.getPath());
		System.out.println("Parent: "+ f.getParent());
		System.out.println("AbsolutePath: "+ f.getAbsolutePath());
		System.out.println("isAbsolute: "+ f.isAbsolute());
		System.out.println("exists: "+ f.exists());
		System.out.println("isFile: "+ f.isFile());
		System.out.println("isDirectory: "+ f.isDirectory());
		System.out.println("Writable: "+ f.canWrite());
		System.out.println("Readable: "+ f.canRead());
		System.out.println("Length: "+ f.length());
	}
}
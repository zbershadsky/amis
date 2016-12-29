package belcer.remoteserverconnector.model;

import org.apache.commons.net.ftp.FTP;
import org.apache.commons.net.ftp.FTPClient;

import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.Properties;

public class FtpConnection {
  private static final String DEFAULT_HOST = "localhost";
  private static final int DEFAULT_PORT = 8090;
  private static final String DEFAULT_USER = "test1";
  private static final String DEFAULT_PASS = "test1";

  private String host;
  private int port;
  private String user;
  private String pass;

  private FTPClient ftpClient = new FTPClient();
  private String rootDir = System.getProperty("user.dir") + "\\src\\main\\resources\\default_dirs\\client\\";

  public static void main(String[] args) {
    Properties properties = System.getProperties();
    FtpConnection client = new FtpConnection();
    client.init();
    client.uploadFile("client.txt", "server.txt");

    client.downloadFile("sss.txt", "AAA.txt");
  }

  public FtpConnection() {
    this(DEFAULT_HOST, DEFAULT_PORT, DEFAULT_USER, DEFAULT_PASS);
  }

  public FtpConnection(String host, int port, String user, String pass) {
    this.host = host;
    this.port = port;
    this.user = user;
    this.pass = pass;
  }

  public void init() {
    ftpClient = new FTPClient();
    try {
      ftpClient.connect(host, port);
      ftpClient.login(user, pass);
      ftpClient.enterLocalPassiveMode();
      ftpClient.setFileType(FTP.BINARY_FILE_TYPE);
    } catch (IOException e) {
      e.printStackTrace();
    }
  }

  //  public boolean deleteFile(String name) {
//    boolean done = false;
//    try {
//      done = ftpClient.chan(rootDir + name);
//    } catch (IOException e) {
//      e.printStackTrace();
//    }
//    return done;
//  }
  public boolean changeWorkingDir(String path) {
    boolean done = false;
    try {
      done = ftpClient.changeWorkingDirectory(path);
    } catch (IOException e) {
      e.printStackTrace();
    }
    return done;
  }

  public boolean deleteFile(String name) {
    boolean done = false;
    try {
      done = ftpClient.deleteFile(rootDir + name);
    } catch (IOException e) {
      e.printStackTrace();
    }
    return done;
  }

  public boolean makeDir(String name) {
    boolean done = false;
    try {
      done = ftpClient.makeDirectory(rootDir + name);
    } catch (IOException e) {
      e.printStackTrace();
    }
    return done;
  }

  public boolean renameFile(String from, String to) {
    boolean done = false;
    try {
      done = ftpClient.rename(rootDir + from, rootDir + to);
    } catch (IOException e) {
      e.printStackTrace();
    }
    return done;
  }

  public boolean downloadFile(String remote, String local) {
    File downloadFile = new File(rootDir + local);
    OutputStream outputStream1 = null;
    boolean done = false;
    try {
      if (!downloadFile.exists()) {
        downloadFile.createNewFile();
      }
      outputStream1 = new BufferedOutputStream(new FileOutputStream(downloadFile));
      try {
        done = ftpClient.retrieveFile(remote, outputStream1);
      } catch (IOException e) {
        e.printStackTrace();
      } finally {
        try {
          outputStream1.close();
        } catch (IOException e) {
          e.printStackTrace();
        }
      }
    } catch (IOException e) {
      e.printStackTrace();
    }
    return done;
  }

  public boolean uploadFile(String local, String remote) {
    File firstLocalFile = new File(rootDir + local);
    InputStream inputStream = null;
    boolean done = false;
    try {
      inputStream = new FileInputStream(firstLocalFile);
      System.out.println("Start uploading first file");
      done = ftpClient.storeFile(remote, inputStream);
      inputStream.close();
    } catch (IOException e) {
      e.printStackTrace();
    }
    return done;
  }

  public void shutdown() {
    try {
      if (this.ftpClient.isConnected()) {
        this.ftpClient.logout();
        this.ftpClient.disconnect();
      }
    } catch (IOException ex) {
      ex.printStackTrace();
    }
  }

  public void setRootDir(String rootDir) {
    this.rootDir = rootDir;
  }
}

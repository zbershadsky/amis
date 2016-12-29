package belcer.remoteserverconnector.model;

import org.apache.ftpserver.FtpServer;
import org.apache.ftpserver.FtpServerFactory;
import org.apache.ftpserver.ftplet.Authority;
import org.apache.ftpserver.ftplet.FtpException;
import org.apache.ftpserver.ftplet.FtpReply;
import org.apache.ftpserver.ftplet.FtpRequest;
import org.apache.ftpserver.ftplet.FtpSession;
import org.apache.ftpserver.ftplet.Ftplet;
import org.apache.ftpserver.ftplet.FtpletContext;
import org.apache.ftpserver.ftplet.FtpletResult;
import org.apache.ftpserver.ftplet.UserManager;
import org.apache.ftpserver.listener.ListenerFactory;
import org.apache.ftpserver.usermanager.PasswordEncryptor;
import org.apache.ftpserver.usermanager.PropertiesUserManagerFactory;
import org.apache.ftpserver.usermanager.impl.BaseUser;
import org.apache.ftpserver.usermanager.impl.WritePermission;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class TestedFtpServer {

  private static final String HOST = "localhost";
  private static final int PORT = 8090;
  private static final String USER = "test1";
  private static final String PASS = "test1";
  private FtpServer ftpServer;
  private static final String serverRootDirectory = System.getProperty("user.dir") + "\\src\\main\\resources\\default_dirs\\server";

  public static void main(String[] args) {
    TestedFtpServer server = new TestedFtpServer();
    server.init();
  }

  public void init() {
    FtpServerFactory serverFactory = new FtpServerFactory();
    ListenerFactory factory = new ListenerFactory();
    factory.setPort(PORT);// set the port of the listener (choose your desired port, not 1234)
    serverFactory.addListener("default", factory.createListener());
    UserManager um = createDefaultUsers();
    serverFactory.setUserManager(um);
    Map<String, Ftplet> m = new HashMap<String, Ftplet>();
    m.put("miaFtplet", new FtpletImpl());
    serverFactory.setFtplets(m);
    Map<String, Ftplet> mappa = serverFactory.getFtplets();
    System.out.println(mappa.size());
    System.out.println("Thread #" + Thread.currentThread().getId());
    System.out.println(mappa.toString());
    ftpServer = serverFactory.createServer();
    try {
      ftpServer.start();//Your FTP server starts listening for incoming FTP-connections, using the configuration options previously set
    } catch (FtpException ex) {
      //Deal with exception as you need
    }
  }

  public UserManager createDefaultUsers() {
    PropertiesUserManagerFactory userManagerFactory = new PropertiesUserManagerFactory();
    userManagerFactory.setFile(new File("/users.properties"));
    userManagerFactory.setPasswordEncryptor(new PasswordEncryptor() {//We store clear-text passwords in this example

      @Override
      public String encrypt(String password) {
        return password;
      }

      @Override
      public boolean matches(String passwordToCheck, String storedPassword) {
        return passwordToCheck.equals(storedPassword);
      }
    });
    BaseUser user = new BaseUser();
    user.setName(USER);
    user.setPassword(PASS);
    user.setHomeDirectory(serverRootDirectory);
    List<Authority> authorities = new ArrayList<Authority>();
    authorities.add(new WritePermission());
    user.setAuthorities(authorities);
    UserManager um = userManagerFactory.createUserManager();
    try {
      um.save(user);//Save the user to the user list on the filesystem
    } catch (FtpException e1) {
      //Deal with exception as you need
    }
    return um;
  }

  public void addUser() {

  }

  class FtpletImpl implements Ftplet {

    @Override
    public void init(FtpletContext ftpletContext) throws FtpException {
      System.out.println("init");
      //System.out.println("Thread #" + Thread.currentThread().getId());
    }

    @Override
    public void destroy() {
      System.out.println("destroy");
      //System.out.println("Thread #" + Thread.currentThread().getId());
    }

    @Override
    public FtpletResult beforeCommand(FtpSession session, FtpRequest request) throws FtpException, IOException {
      System.out.println("beforeCommand " + session.getUserArgument() + " : " + session.toString() + " | " + request.getArgument() + " : " + request.getCommand() + " : " + request.getRequestLine());
      //System.out.println("Thread #" + Thread.currentThread().getId());

      //do something
      return FtpletResult.DEFAULT;//...or return accordingly
    }

    @Override
    public FtpletResult afterCommand(FtpSession session, FtpRequest request, FtpReply reply) throws FtpException, IOException {
//        System.out.println(session.getFileSystemView().getWorkingDirectory().listFiles().size());
      System.out.println("afterCommand " + session.getUserArgument() + " : " + session.toString() + " | "
          + request.getArgument() + " : " + request.getCommand() + " : " + request.getRequestLine() + " | "
          + reply.getMessage() + " : " + reply.toString());
      //System.out.println("Thread #" + Thread.currentThread().getId());
      if ("STOR".equals(request.getCommand())) {

      }
      //do something
      return FtpletResult.DEFAULT;//...or return accordingly
    }

    @Override
    public FtpletResult onConnect(FtpSession session) throws FtpException, IOException {
      System.out.println("onConnect " + session.getUserArgument() + " : " + session.toString());
      //System.out.println("Thread #" + Thread.currentThread().getId());

      //do something
      return FtpletResult.DEFAULT;//...or return accordingly
    }

    @Override
    public FtpletResult onDisconnect(FtpSession session) throws FtpException, IOException {
      System.out.println("onDisconnect " + session.getUserArgument() + " : " + session.toString());
      //System.out.println("Thread #" + Thread.currentThread().getId());

      //do something
      return FtpletResult.DEFAULT;//...or return accordingly
    }
  }
}

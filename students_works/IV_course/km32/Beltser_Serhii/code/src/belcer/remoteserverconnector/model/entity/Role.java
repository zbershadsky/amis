package belcer.remoteserverconnector.model.entity;

public enum Role {
  IS_ADMIN,
  DB_ADMIN,
  USER,
  UNDEFIEND,;

  public static Role parseString(String roleName) {
    switch (roleName.toUpperCase()) {
      case "IS_ADMIN":
        return IS_ADMIN;
      case "DB_ADMIN":
        return DB_ADMIN;
      case "USER":
        return USER;
      default:
        System.err.println("Wrong role name");
        return UNDEFIEND;
    }
//    throw new IllegalArgumentException("Wrong role name");
  }

  @Override
  public String toString() {
    switch (this) {
      case IS_ADMIN:
        return "IS_ADMIN";
      case DB_ADMIN:
        return "DB_ADMIN";
      case USER:
        return "USER";
      default:
        System.err.println("Wrong role name");
        return "UNDEFIEND";
    }
  }
}

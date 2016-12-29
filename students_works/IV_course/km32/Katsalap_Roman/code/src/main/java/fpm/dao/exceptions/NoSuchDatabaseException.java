package fpm.dao.exceptions;

public class NoSuchDatabaseException extends Exception {
    public NoSuchDatabaseException(Throwable e){
        initCause(e);
    }
}

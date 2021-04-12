package domen;

import domen.Admin;
import domen.Korisnik;
import javax.annotation.Generated;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;

@Generated(value="EclipseLink-2.5.2.v20140319-rNA", date="2020-06-02T12:38:28")
@StaticMetamodel(User.class)
public class User_ { 

    public static volatile SingularAttribute<User, String> password;
    public static volatile SingularAttribute<User, Korisnik> regularankorisnik;
    public static volatile SingularAttribute<User, String> imeIPrezime;
    public static volatile SingularAttribute<User, Admin> admin;
    public static volatile SingularAttribute<User, Integer> userID;
    public static volatile SingularAttribute<User, String> email;
    public static volatile SingularAttribute<User, String> username;

}
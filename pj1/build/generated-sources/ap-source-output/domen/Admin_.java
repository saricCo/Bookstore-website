package domen;

import domen.User;
import javax.annotation.Generated;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;

@Generated(value="EclipseLink-2.5.2.v20140319-rNA", date="2020-06-02T12:38:28")
@StaticMetamodel(Admin.class)
public class Admin_ { 

    public static volatile SingularAttribute<Admin, String> privilegija;
    public static volatile SingularAttribute<Admin, Integer> adminID;
    public static volatile SingularAttribute<Admin, String> brojTelefona;
    public static volatile SingularAttribute<Admin, User> user;

}
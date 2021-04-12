package domen;

import domen.User;
import java.util.Date;
import javax.annotation.Generated;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;

@Generated(value="EclipseLink-2.5.2.v20140319-rNA", date="2020-06-02T12:38:28")
@StaticMetamodel(Korisnik.class)
public class Korisnik_ { 

    public static volatile SingularAttribute<Korisnik, String> eRacun;
    public static volatile SingularAttribute<Korisnik, Date> datumRodjenja;
    public static volatile SingularAttribute<Korisnik, Integer> korisnikID;
    public static volatile SingularAttribute<Korisnik, User> user;
    public static volatile SingularAttribute<Korisnik, Date> datumRegistracije;

}
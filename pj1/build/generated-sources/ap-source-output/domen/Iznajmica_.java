package domen;

import domen.Knjiga;
import domen.Korisnik;
import java.util.Date;
import javax.annotation.Generated;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;

@Generated(value="EclipseLink-2.5.2.v20140319-rNA", date="2020-06-02T12:38:28")
@StaticMetamodel(Iznajmica.class)
public class Iznajmica_ { 

    public static volatile SingularAttribute<Iznajmica, Knjiga> knjigaID;
    public static volatile SingularAttribute<Iznajmica, Date> datumPovracaja;
    public static volatile SingularAttribute<Iznajmica, Integer> iznajmicaID;
    public static volatile SingularAttribute<Iznajmica, Date> datumIzdavanja;
    public static volatile SingularAttribute<Iznajmica, Korisnik> korisnikID;

}
package domen;

import domen.Korisnik;
import domen.Stavkaracuna;
import java.util.Date;
import javax.annotation.Generated;
import javax.persistence.metamodel.ListAttribute;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;

@Generated(value="EclipseLink-2.5.2.v20140319-rNA", date="2020-06-02T12:38:28")
@StaticMetamodel(Racun.class)
public class Racun_ { 

    public static volatile SingularAttribute<Racun, Double> iznos;
    public static volatile SingularAttribute<Racun, Date> vreme;
    public static volatile ListAttribute<Racun, Stavkaracuna> stavkaracunaList;
    public static volatile SingularAttribute<Racun, Double> popust;
    public static volatile SingularAttribute<Racun, Korisnik> kupacID;
    public static volatile SingularAttribute<Racun, Integer> racunID;

}
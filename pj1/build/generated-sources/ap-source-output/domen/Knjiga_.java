package domen;

import domen.Iznajmica;
import domen.Zanr;
import javax.annotation.Generated;
import javax.persistence.metamodel.ListAttribute;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;

@Generated(value="EclipseLink-2.5.2.v20140319-rNA", date="2020-06-02T12:38:28")
@StaticMetamodel(Knjiga.class)
public class Knjiga_ { 

    public static volatile ListAttribute<Knjiga, Iznajmica> iznajmicaList;
    public static volatile ListAttribute<Knjiga, Zanr> zanrList;
    public static volatile SingularAttribute<Knjiga, Integer> knjigaID;
    public static volatile SingularAttribute<Knjiga, String> izdavac;
    public static volatile SingularAttribute<Knjiga, String> pisac;
    public static volatile SingularAttribute<Knjiga, Integer> godinaIzdavanja;
    public static volatile SingularAttribute<Knjiga, String> naziv;
    public static volatile SingularAttribute<Knjiga, Double> cena;
    public static volatile SingularAttribute<Knjiga, String> opis;
    public static volatile SingularAttribute<Knjiga, Integer> stanjeNaLageru;
    public static volatile SingularAttribute<Knjiga, String> status;

}
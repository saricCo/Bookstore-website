package domen;

import domen.Knjiga;
import javax.annotation.Generated;
import javax.persistence.metamodel.ListAttribute;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;

@Generated(value="EclipseLink-2.5.2.v20140319-rNA", date="2020-06-02T12:38:28")
@StaticMetamodel(Zanr.class)
public class Zanr_ { 

    public static volatile SingularAttribute<Zanr, String> naziv;
    public static volatile ListAttribute<Zanr, Knjiga> knjigaList;
    public static volatile SingularAttribute<Zanr, Integer> zanrID;

}
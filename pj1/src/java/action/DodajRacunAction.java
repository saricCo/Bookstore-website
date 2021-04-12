/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package action;

import controller.pl.ControllerPL;
import domen.Iznajmica;
import domen.Knjiga;
import domen.Racun;
import domen.Korisnik;
import domen.Stavkaracuna;
import java.text.DecimalFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.LinkedList;
import java.util.List;

import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Pumpkin
 */
public class DodajRacunAction extends AbstractAction {

    @Override
    public String izvrsi(HttpServletRequest request) {

        String iznajmice = request.getParameter("iznajmice");
        String korisnik = request.getParameter("korisnik");
        Korisnik rk = new Korisnik(Integer.parseInt(korisnik));

        String[] iznajmiceLista = iznajmice.split(",");
        Iznajmica iznajmica = new Iznajmica();

        for (int i = 0; i + 2 < iznajmiceLista.length; i++) {
            try {
                String knjigaIdString = iznajmiceLista[i];
                String datumOd = iznajmiceLista[i + 1];
                String datumDo = iznajmiceLista[i + 2];

                SimpleDateFormat sdf = new SimpleDateFormat("dd-MM-yyyy");
                Date OdDatuma = sdf.parse(datumOd);
                Date DoDatuma = sdf.parse(datumDo);

                iznajmica = new Iznajmica();
                iznajmica.setDatumIzdavanja(OdDatuma);
                iznajmica.setDatumPovracaja(DoDatuma);
                iznajmica.setKnjigaID(new Knjiga(Integer.parseInt(knjigaIdString)));
                iznajmica.setKorisnikID(rk);
                //  Knjiga k=new Knjiga(iznajmiceLista[i]);
                //  iznajmica.setKnjigaID();
                ControllerPL.getInstanca().unesiIznajmicu(iznajmica);
            } catch (ParseException ex) {
                Logger.getLogger(DodajRacunAction.class.getName()).log(Level.SEVERE, null, ex);
            }

        }

        String knjige = request.getParameter("idKnjiga");
        knjige = knjige.substring(1, knjige.length() - 1);
        String[] knjigeLista = knjige.split(",");
        Racun r = new Racun();
        double iznos = 0;
        List<Stavkaracuna> listaStaviki = new LinkedList<>();
        List<Knjiga> listaKnjiga = ControllerPL.getInstanca().vratiKnjige();
        List<Knjiga> kupljeneKnjige = new LinkedList<>();

        r.setRacunID(ControllerPL.getInstanca().vratiRacunMaxID());
        r.setVreme(new Date());

        r.setPopust(Double.parseDouble(knjigeLista.length + "") * 0.05);
        r.setStavkaracunaList(listaStaviki);
        int srMax = ControllerPL.getInstanca().vratiStavkaRacunMaxID();
        for (int i = 0; i < knjigeLista.length; i++) {
            for (Knjiga k : listaKnjiga) {
                if (Integer.parseInt(knjigeLista[i]) == k.getKnjigaID()) {
                    kupljeneKnjige.add(k);
                    Stavkaracuna sr = new Stavkaracuna(srMax++, k.getNaziv(), k.getCena(), r);
                    iznos += k.getCena();
                    listaStaviki.add(sr);
                }

            }

        }
        double iznosZaUnos = iznos * (1 - r.getPopust());
        DecimalFormat df = new DecimalFormat("####0.00");
        r.setIznos(Double.parseDouble(df.format(iznosZaUnos)));
        r.setStavkaracunaList(listaStaviki);
        r.setKupacID(rk);

        ControllerPL.getInstanca().sacuvajRacun(r);

        HttpSession sesija = request.getSession(true);
        sesija.setAttribute("poruka", "Uspešno ste izvršili kupovinu!!");

        sesija.setAttribute("sub-poruka", "Vaša kupovina je uspešno izvršena u iznosu od " + r.getIznos() + " dinara, ukoliko postoji bilo koji problem sa porudzbinom "
                + "možete nas kontaktirati na: 064-425 5352");
        return "index";
    }

}

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package action;

import controller.pl.ControllerPL;
import domen.Iznajmica;
import domen.Knjiga;
import domen.Korisnik;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Pumkin-duke
 */
public class DodajIznajmicuAction extends AbstractAction {

    @Override
    public String izvrsi(HttpServletRequest request) {

        String iznajmice = request.getParameter("iznajmica");
        //  String korisnik = request.getParameter("korisnik");
        HttpSession sesija = request.getSession(true);

        Korisnik k = (Korisnik) sesija.getAttribute("regularnikorisnik");
        System.out.println(k);

        String[] iznajmiceLista = iznajmice.split(",");
        Iznajmica iznajmica = new Iznajmica();
        String knjigaIdString = iznajmiceLista[0];
        String datumOd = iznajmiceLista[1];
        String datumDo = iznajmiceLista[2];
        Knjiga knjiga = ControllerPL.getInstanca().vratiKnjigu(Integer.parseInt(knjigaIdString));
        try {
            knjiga.setStanjeNaLageru(knjiga.getStanjeNaLageru()-1);
            ControllerPL.getInstanca().izmeniKnjigu(knjiga);

            SimpleDateFormat sdf = new SimpleDateFormat("dd-MM-yyyy");
            Date OdDatuma = sdf.parse(datumOd);
            Date DoDatuma = sdf.parse(datumDo);

            iznajmica = new Iznajmica();
            iznajmica.setDatumIzdavanja(OdDatuma);
            iznajmica.setDatumPovracaja(DoDatuma);
            iznajmica.setKnjigaID(knjiga);
            iznajmica.setKorisnikID(k);

            ControllerPL.getInstanca().unesiIznajmicu(iznajmica);
        } catch (ParseException ex) {

            Logger.getLogger(DodajRacunAction.class.getName()).log(Level.SEVERE, null, ex);
        }

        sesija.setAttribute("poruka", "Uspešno ste iznajmili knjigu!!");

        sesija.setAttribute("sub-poruka", "Iznajmili ste knjigu \"" + knjiga.getNaziv() + "\" i vaša iznajmica traje od " + datumOd + ", do datuma " + datumDo + ". Uživajte!");
        return "iznajmljeneKnjige";
    }

}

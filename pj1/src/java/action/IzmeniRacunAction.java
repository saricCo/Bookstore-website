/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package action;

import controller.pl.ControllerPL;
import domen.Racun;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Pumpkin
 */
public class IzmeniRacunAction extends AbstractAction {

    @Override
    public String izvrsi(HttpServletRequest request) {

        try {
            String dtm = request.getParameter("datumRacun");
            String[] dtmArray = dtm.split("-");

            String datum2 = dtmArray[2] + "-" + dtmArray[1] + "-" + dtmArray[0];
            SimpleDateFormat sdf = new SimpleDateFormat("dd-MM-yyyy");
            Date datum = sdf.parse(datum2);
            Double popust = Double.parseDouble(request.getParameter("popust")) / 100;

            int racunID = Integer.parseInt(request.getParameter("racunID"));
            Double iznos = Double.parseDouble(request.getParameter("iznos"));
            iznos = Double.parseDouble(Math.round(iznos) + "");
            Racun r = ControllerPL.getInstanca().vratiRacun(racunID);

            r.setPopust(popust);
            r.setVreme(datum);
            r.setIznos(iznos);
            ControllerPL.getInstanca().izmeniRacun(r);

        } catch (ParseException ex) {
            HttpSession sesija = request.getSession(true);
            sesija.setAttribute("poruka", "Sistem  ne može da izmeni račun");
            sesija.setAttribute("sub-poruka", "Greška prilikom izmene računa u bazi.");

            Logger.getLogger(IzmeniRacunAction.class.getName()).log(Level.SEVERE, null, ex);
        }

        HttpSession sesija = request.getSession(true);

        sesija.setAttribute("poruka", "Sistem je izmenio račun");
        sesija.setAttribute("sub-poruka", "Uspešna promena računa!");

        return "racuni";
    }

}

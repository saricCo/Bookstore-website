/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package action;

import controller.pl.ControllerPL;
import domen.Racun;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Pumpkin
 */
public class ObrisiRacunAction extends AbstractAction {

    @Override
    public String izvrsi(HttpServletRequest request) {

        String s = request.getParameter("racunID");
        Racun r= ControllerPL.getInstanca().vratiRacun(Integer.parseInt(s));
        ControllerPL.getInstanca().izbrisiRacun(Integer.parseInt(s));
        HttpSession sesija = request.getSession(true);
       
        sesija.setAttribute("poruka","Uspešno ste obrisali račun");
        sesija.setAttribute("sub-poruka","Račun čiji je kupac bio "+r.getKupacID().getUser().getImeIPrezime()+ " je uspešno obrisan! ");
        return "racuni";
    }

}

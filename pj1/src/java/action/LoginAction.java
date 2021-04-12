/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package action;

import controller.pl.ControllerPL;
import domen.Admin;
import domen.Korisnik;
import domen.User;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Pumpkin
 */
public class LoginAction extends AbstractAction {

    @Override
    public String izvrsi(HttpServletRequest request) {

        String user = request.getParameter("username");
        String pass = request.getParameter("password");
        Korisnik rk = ControllerPL.getInstanca().vratiKorisnika(user, pass);

        if (rk != null) {

            int broj = ControllerPL.getInstanca().vratiIznamiceZaKorisnika(rk.getKorisnikID());

            HttpSession sesija = request.getSession(true);
            sesija.setAttribute("regularnikorisnik", rk);
            sesija.setAttribute("admin", null);
            sesija.setAttribute("poruka", "Login uspesan!");
            if (broj > 0) {
                sesija.setAttribute("sub-poruka", "Poštovani uspešno ste se ulogovali u sistem, trenutno imate " + broj + " iznamljenih knjiga");

            } else {

                sesija.setAttribute("sub-poruka", "Poštovani uspešno ste se ulogovali u sistem");
            }
            return "index";
        }

        Admin a = ControllerPL.getInstanca().vratiAdmina(user, pass);
        if (a != null) {
            
            ControllerPL.getInstanca().obradiIznajmice();
            HttpSession sesija = request.getSession(true);
            sesija.setAttribute("regularnikorisnik", null);
            sesija.setAttribute("admin", a);
            sesija.setAttribute("poruka", "Login uspesan!");
            sesija.setAttribute("sub-poruka", "Poštovani uspešno ste se ulogovali u sistem");
            return "index";
        }
        HttpSession sesija = request.getSession(true);
        sesija.setAttribute("poruka", "Greška prilikom logovanja!");
        sesija.setAttribute("sub-poruka", "Korisnik sa unetim korisničkim imenom i šifrom ne postoji, pokuštajte ponoov i proverite da li ste "
                + "uneli vaše podatke ispravno!");
        return "index";
    }

}

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package action;

import com.sun.org.apache.bcel.internal.generic.L2D;
import controller.pl.ControllerPL;
import domen.Korisnik;
import domen.User;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.LinkedList;
import java.util.List;
import java.util.Random;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Pumpkin
 */
public class DodajKorisnikaAction extends AbstractAction {

    @Override
    public String izvrsi(HttpServletRequest request) {
         User u = new User();
        try {
           
            u.setImeIPrezime(request.getParameter("imeIPrezime"));
            u.setUsername(request.getParameter("username"));
            u.setPassword(request.getParameter("password"));
            u.setEmail(request.getParameter("email"));
            String startDateStr = request.getParameter("datumRodjenja");

            if (ControllerPL.getInstanca().vratiUsera(u.getUsername()) != null) {

                int x = 10;
                int i = 0;
                List<String> slobodna = new LinkedList<String>();
                while (true) {
                    i++;
                    if (i > 4) {
                        x = 100;
                    }
                    Random rand = new Random();
                    int value = rand.nextInt(x);
                    String broj = value + "";
                    String ime = u.getUsername() + broj;
                    if (ControllerPL.getInstanca().vratiUsera(ime) == null) {
                        if (!slobodna.contains(ime)) {
                            slobodna.add(ime);
                            if (slobodna.size() == 3) {
                                break;
                            }
                        }
                    }

                }

                HttpSession sesija = request.getSession(true);
                String povratna = "Greska prilikom registracije. Korisničko ime " + u.getUsername() + " već postoji, probajte neko od ponuđenih: ";
                for (String s : slobodna) {

                    povratna += s + ", ";
                }

                sesija.setAttribute("greskaRegistracija", povratna.substring(0, povratna.length() - 2));
                return "index";
            }

            int broj = ControllerPL.getInstanca().vratiUserMaxID();
            u.setUserID(broj);
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            Date d = sdf.parse(startDateStr);
            Korisnik rk = new Korisnik(broj, request.getParameter("eRacun"), d, new Date(), u);
            u.setRegularankorisnik(rk);
            ControllerPL.getInstanca().dodajUsera(u);

            HttpSession sesija = request.getSession(true);
            String povratna = "Uspešno ste se registrovali! ";
            sesija.setAttribute("uspesnaRegistracija", povratna);
            return "index";

        } catch (ParseException ex) {
            Logger.getLogger(DodajKorisnikaAction.class.getName()).log(Level.SEVERE, null, ex);
        }
       // HttpSession sesija = request.getSession(true);
        //sesija.setAttribute("poruka", "Uspesno ste se registrovali!");
        //sesija.setAttribute("sub-poruka", ""+u.getImeIPrezime()+" dobro nam došli! Nadamo se da ćete naći ono što vas zanima. Ukoliko imate neki predlog možete nas"
         //       + "kontaktirati na 064-425 5352");
        return "index";
    }

}

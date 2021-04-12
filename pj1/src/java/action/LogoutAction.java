/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package action;

import domen.Korisnik;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Pumpkin
 */
public class LogoutAction extends AbstractAction {

    @Override
    public String izvrsi(HttpServletRequest request) {

        HttpSession session = request.getSession(false);
        if (session != null) {
            session.invalidate();
        }
        HttpSession sesija = request.getSession(true);
        sesija.setAttribute("poruka", "Uspesno ste se izlogovali!");
        sesija.setAttribute("sub-poruka", "Hvala na poseti, dođite nam opet!");
        return "index";
    }

}

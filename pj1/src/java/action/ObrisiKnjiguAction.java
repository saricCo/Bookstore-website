/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package action;

import action.dao.KnjigeDao;
import controller.pl.ControllerPL;
import domen.Knjiga;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Pumpkin
 */
public class ObrisiKnjiguAction extends AbstractAction {

    @Override
    public String izvrsi(HttpServletRequest request) {

        int knjigaID = Integer.parseInt(request.getParameter("knjigaID"));

        Knjiga k = ControllerPL.getInstanca().vratiKnjigu(knjigaID);
        ControllerPL.getInstanca().izbrisiKnjigu(knjigaID);

        //request.setAttribute("greska", "Sistem ne moze da obrise klub");
        // request.setAttribute("poruka", "Sistem ne moze da obrise klub");
        HttpSession sesija = request.getSession(true);
        sesija.setAttribute("poruka", "Sistem je obrisao knjigu!");
        sesija.setAttribute("sub-poruka", "Obrisana je knjiga sa nazivom \"" + k.getNaziv() + "\"");
        return "index";
    }

}

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package action;

import controller.pl.ControllerPL;
import domen.Knjiga;
import domen.Zanr;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Pumpkin
 */
public class IzmeniKnjiguAction extends AbstractAction {

    @Override
    public String izvrsi(HttpServletRequest request) {

        Knjiga k = new Knjiga();
        k.setKnjigaID(Integer.parseInt(request.getParameter("knjigaID")));
        k.setCena(Double.parseDouble(request.getParameter("cena")));
        k.setGodinaIzdavanja(Integer.parseInt(request.getParameter("godinaIzdanja")));
        k.setPisac(request.getParameter("pisac"));
        k.setNaziv(request.getParameter("nazivKnjige"));
        k.setOpis(request.getParameter("opis"));
        k.setIzdavac(request.getParameter("nazivIzdavaca"));
        k.setStanjeNaLageru(Integer.parseInt(request.getParameter("brojZaUnos")));
        k.setStatus(request.getParameter("namena1"));
        
        String zanroviString = request.getParameter("zanr");
        String[] zanrovi = zanroviString.split(", ");
        List<Zanr> lista = ControllerPL.getInstanca().vratiZanr();
        List<Zanr> listaZanrova = new ArrayList<>();
        for (String s : zanrovi) {
            for (Zanr z : lista) {

                if (z.getNaziv().equals(s)) {
                    Zanr z1 = new Zanr(z.getZanrID(), s);
                    listaZanrova.add(z1);
                    break;
                }
            }

        }

        k.setZanrList(listaZanrova);
        

        
        ControllerPL.getInstanca().izmeniKnjigu(k);
         
        HttpSession sesija = request.getSession(true);
        sesija.setAttribute("poruka", "Sistem је zapamtio promene!");
        sesija.setAttribute("sub-poruka", "Uspešno su izvršene promene u bazi.");
        
        
        return "index";
    }

}

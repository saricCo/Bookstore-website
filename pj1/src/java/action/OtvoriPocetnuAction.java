/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Pumpkin
 */
public class OtvoriPocetnuAction extends AbstractAction{

    @Override
    public String izvrsi(HttpServletRequest request) {
        
      //  HttpSession sesija = request.getSession(true);
       //sesija.setAttribute("poruka", "Sistem ne može da prikaže traženu knjigu");
        // sesija.setAttribute("sub-poruka", "Pokušajt ponovo, ukoliko se ova greška ponovo pojavi, molimo vas da nas kontaktirate na broj 064-425 5352");
        
        return "index";
    }
    
}

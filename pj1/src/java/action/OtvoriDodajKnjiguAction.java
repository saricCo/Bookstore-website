/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package action;

import domen.Korisnik;
import javax.servlet.http.HttpServletRequest;

/**
 *
 * @author Pumpkin
 */
public class OtvoriDodajKnjiguAction extends AbstractAction{

    @Override
    public String izvrsi(HttpServletRequest request) {
        
       
        return "dodaj_knjigu";
                }
    
}

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package action;

/**
 *
 * @author FON
 */
public class ActionFactory {

    public static AbstractAction napraviAkciju(String action) {
        AbstractAction command = null;
        if (action.equals("dodaj_knjigu")) {
            command = new OtvoriDodajKnjiguAction();
        }
        if (action.equals("index")) {
            command = new OtvoriPocetnuAction();
        }
        if (action.equals("unesi_knjigu")) {
            command = new DodajKnjiguAction();
        }
        if (action.equals("login")) {
            command = new LoginAction();
        }
        if (action.equals("logout")) {
            command = new LogoutAction();
        }
        if (action.equals("registracija")) {
            command = new DodajKorisnikaAction();
        }
        if (action.equals("korpa")) {
            command = new OtvoriDodajRacunAction();
        }
        if (action.equals("napravi_racun")) {
            command = new DodajRacunAction();
        }
        if (action.equals("izmeni_knjigu")) {
            command = new IzmeniKnjiguAction();
        }
        if (action.equals("obrisi_knjigu")) {
            command = new ObrisiKnjiguAction();
        }
        if (action.equals("racuni")) {
            command = new OtvoriRacuneAction();
        }
        if (action.equals("obrisi_racun")) {
            command = new ObrisiRacunAction();
        }
        if (action.equals("izmeni_racun")) {
            command = new IzmeniRacunAction();
        }
        if (action.equals("iznajmljeneKnjige")) {
            command = new OtvoriIznajmljeneKnjigeAction();
        }
        if (action.equals("iznajmiKnjiguAkcija")) {
            command = new DodajIznajmicuAction();
        }
        return command;
    }
}

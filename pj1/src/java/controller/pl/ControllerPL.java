/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller.pl;

import action.dao.AdminDao;
import action.dao.IznajmicaDao;
import action.dao.KnjigeDao;
import action.dao.KorisnikDao;
import action.dao.RacunDao;
import action.dao.StavkaRacunaDao;
import action.dao.UserDao;
import action.dao.ZanrDao;
import domen.Admin;
import domen.Iznajmica;
import domen.Knjiga;
import domen.Racun;
import domen.Korisnik;
import domen.User;
import domen.Zanr;
import java.util.List;
import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

/**
 *
 * @author Pumpkin
 */
public class ControllerPL {
    
    private static ControllerPL instanca;
    EntityManagerFactory emf;
 
    private ControllerPL() {
        emf = Persistence.createEntityManagerFactory("pj1PU");
    }
    
    public static ControllerPL getInstanca() {
        if (instanca == null) {
            instanca = new ControllerPL();
        }
        return instanca;
    }
    
    public List<Zanr> vratiZanr() {
        return new ZanrDao().getAll();
        /* EntityManager em = emf.createEntityManager();
         em.getTransaction().begin();

         List<Zanr> listaKorisnika = em.createQuery("SELECT z FROM Zanr z").getResultList();
         return listaKorisnika;*/
    }
    
    public List<Knjiga> vratiKnjige() {
        return new KnjigeDao().getAll();
        /*  EntityManager em = emf.createEntityManager();
         em.getTransaction().begin();

         List<Knjiga> lista = em.createQuery("SELECT k FROM Knjiga k").getResultList();

         return lista;*/
    }
    
    public void dodajKnjigu(Knjiga k) {
        /*  new KnjigeDao().save(k);
       
         List<Zanr> lista = new LinkedList<>();
         double broj = 10;
         //      k=new Knjiga(Integer.SIZE, "sag", "gad", "gsag", 1000, "ggsa", broj ,1,"gsaga",lista);
         EntityManager em = emf.createEntityManager();
         em.getTransaction().begin();
         try {
         em.persist(k);
         em.getTransaction().commit();
         em.close();
         return null;
         } catch (Exception ex) {
         return "Sistem ne moze da kreira knjigu";
         }
         */
    }
// servis klasa i dao kalsa, dao patern, paypall da se doda

    public void sacuvajKnjigu(Knjiga k) {
        new KnjigeDao().save(k);
        /*
         EntityManager em = emf.createEntityManager();
         em.getTransaction().begin();
         try {
         em.persist(k);
         em.getTransaction().commit();
         em.close();
         return null;
         } catch (Exception ex) {
         return "Sistem ne moze da kreira knjigu";
         }*/
    }
    
    
    
    
    
    public String vratiKodovanaSlova(String s) {
        // č, ć, dž, đ, lj, nj, š and ž
        String finalni = "";
        for (char c : s.toCharArray()) {
            
            if (c == 'č') {
                finalni += "^c";
            } else if (c == 'ć') {
                finalni += "^^c";
            } else if (c == 'đ') {
                finalni += "^d";
            } else if (c == 'š') {
                finalni += "^s";
            } else if (c == 'ž') {
                finalni += "^z";
            } else {
                finalni += c;
            }
        }
        
        return finalni;
    }
    
    public String dekodujSlova(String s) {
        
        String finalni = s;
        
        finalni = finalni.replace("^^c", "ć");
        finalni = finalni.replace("^c", "č");
        finalni = finalni.replace("^z", "ž");
        finalni = finalni.replace("^s", "š");
        finalni = finalni.replace("^d", "đ");
        finalni = finalni.replace("^^-c", "Ć");
        finalni = finalni.replace("^-c", "Č");
        finalni = finalni.replace("^-z", "Ž");
        finalni = finalni.replace("^-s", "Š");
        finalni = finalni.replace("^-d", "Đ");
        
        return finalni;
    }
    
    public Korisnik vratiKorisnika(String user, String pass) {
        return new KorisnikDao().get(user, pass);

        /*
         EntityManager em = emf.createEntityManager();
         em.getTransaction().begin();

         List<Korisnik> listaKorisnika = em.createQuery("SELECT k FROM Korisnik k").getResultList();

         for (Korisnik korisnik : listaKorisnika) {
         if (korisnik.getUser().getUsername().equals(user) && korisnik.getUser().getPassword().equals(pass)) {
         System.out.println("Nasao sam korisnika:" + korisnik.getUser().getImeIPrezime());
         return korisnik;

         }
         }
         return null;*/
    }
    
    public void dodajKorisnika(Korisnik rk) {
        
        new KorisnikDao().save(rk);
        /* EntityManager em = emf.createEntityManager();
         em.getTransaction().begin();
         try {
         em.persist(rk);
         em.getTransaction().commit();
         em.close();
         return null;
         } catch (Exception ex) {
         return "Sistem ne moze da kreira korisnika";
         }*/
        
    }
    
    public void dodajUsera(User u) {
        new UserDao().save(u);

        /*
         EntityManager em = emf.createEntityManager();
         em.getTransaction().begin();
         try {
         em.persist(u);
         em.getTransaction().commit();
         em.close();
         return null;
         } catch (Exception ex) {
         return "Sistem ne moze da kreira korisnika";
         }
         */
    }
    
    public int vratiUserMaxID() {
        
        return new UserDao().vratiMaxID();
        /*EntityManager em = emf.createEntityManager();
         em.getTransaction().begin();

         int broj = (int) em.createQuery("SELECT max(u.userID) FROM User u").getSingleResult();

         return broj + 1;*/
        
    }
    
    public int vratiRacunMaxID() {
        return new RacunDao().vratiMaxID();

        /*EntityManager em = emf.createEntityManager();
         em.getTransaction().begin();

         int broj = (int) em.createQuery("SELECT max(r.racunID) FROM Racun r").getSingleResult();

         return broj + 1;*/
    }
    
    public int vratiStavkaRacunMaxID() {
        
        return new StavkaRacunaDao().vratiMaxID();
        /*EntityManager em = emf.createEntityManager();
         em.getTransaction().begin();
         int broj = 0;
         try {
         broj = (int) em.createQuery("SELECT max(sr.stavkaRacunaID) FROM Stavkaracuna sr").getSingleResult();
         } catch (Exception ex) {
         return 1;
         }
         return broj + 1;*/
        
    }
    
    public void sacuvajRacun(Racun r) {
        new RacunDao().save(r);
        /* EntityManager em = emf.createEntityManager();
         em.getTransaction().begin();
         try {
         em.persist(r);
         for (Stavkaracuna sr : r.getStavkaracunaList()) {
         em.persist(sr);
         }

         em.getTransaction().commit();
         em.close();
         return null;
         } catch (Exception ex) {
         return "Sistem ne moze da kreira knjigu";
         }
         */
    }
    
    public void izmeniKnjigu(Knjiga k) {
        new KnjigeDao().update(k);
        /* EntityManager em = emf.createEntityManager();

         em.getTransaction().begin();
         Knjiga zaIzmenu = em.find(Knjiga.class, k.getKnjigaID());
         if (zaIzmenu != null) {
         zaIzmenu = em.merge(k);
         em.getTransaction().commit();
         em.close();
         return null;
         } else {
         return "Sistem ne moze da promeni klub";
         }
         */
    }
    
    public Admin vratiAdmina(String user, String pass) {
        return new AdminDao().get(user, pass);
        /*
         EntityManager em = emf.createEntityManager();
         em.getTransaction().begin();

         List<Admin> listaAdmina = em.createQuery("SELECT a FROM Admin a").getResultList();

         for (Admin admin : listaAdmina) {
         if (admin.getUser().getUsername().equals(user) && admin.getUser().getPassword().equals(pass)) {
         System.out.println("Nasao sam korisnika:" + admin.getUser().getImeIPrezime());
         return admin;

         }
         }
         return null;*/
    }
    
    public void izbrisiKnjigu(int knjigaID) {
        new KnjigeDao().delete(new Knjiga(knjigaID));
        /* EntityManager em = emf.createEntityManager();
         em.getTransaction().begin();
         Knjiga knjiga = em.find(Knjiga.class, knjigaID);
         em.remove(knjiga);
         em.getTransaction().commit();*/
    }
    
    public String unesiIznajmicu(Iznajmica iznajmica) {
        
        EntityManager em = emf.createEntityManager();
        em.getTransaction().begin();
        try {
            em.persist(iznajmica);
            em.getTransaction().commit();
            em.close();
            return null;
        } catch (Exception ex) {
            return "Sistem ne moze da kreira knjigu";
        }
        
    }
    
    public List<Racun> vratiRacune() {
        return new RacunDao().getAll();
        
    }
    
    public void izbrisiRacun(int racunID) {
        
        new RacunDao().delete(new Racun(racunID));

        /*izbrisiStavke(racunID);
         EntityManager em = emf.createEntityManager();
         em.getTransaction().begin();

         Racun racun = em.find(Racun.class, racunID);
         em.remove(racun);
         em.getTransaction().commit();*/
    }
    
    private void izbrisiStavke(int racunID) {

        /*EntityManager em = emf.createEntityManager();
         em.getTransaction().begin();
         List<Racun> lista = vratiRacune();
         Racun r1 = new Racun();
         for (Racun r : lista) {
         if (r.getRacunID() == racunID) {
         r1 = r;
         break;
         }
         }

         for (Stavkaracuna sr : r1.getStavkaracunaList()) {
         Stavkaracuna sr1 = em.find(Stavkaracuna.class, sr.getStavkaRacunaID());
         em.remove(sr1);

         }
         em.getTransaction().commit();*/
    }
    
    public void izmeniRacun(Racun r) {
        new RacunDao().update(r);
       /* EntityManager em = emf.createEntityManager();
        
        em.getTransaction().begin();
        Racun zaIzmenu = em.find(Racun.class, r.getRacunID());
        if (zaIzmenu != null) {
            zaIzmenu = em.merge(r);
            em.getTransaction().commit();
            em.close();
            return null;
        } else {
            return "Sistem ne moze da promeni racun";
        }
        */
    }
    
    public Racun vratiRacun(int racunID) {
        
        return new RacunDao().get(racunID);
        /*EntityManager em = emf.createEntityManager();
        em.getTransaction().begin();
        
        Racun r = (Racun) em.createQuery("SELECT r FROM Racun r WHERE r.racunID=" + racunID).getSingleResult();
        return r;*/
    }

    public User vratiUsera(String username) {
        return new UserDao().get(username);
    
    
    
    }
    
    public Knjiga vratiKnjigu(int id){
        return new KnjigeDao().findKnjiga(id);
    }

    public int vratiIznamiceZaKorisnika(Integer korisnikID) {
    return new IznajmicaDao().getCount(korisnikID);
    
    }
    
    public List<Iznajmica> vratiIznajmiceZaKor(Korisnik k){
       
        return new IznajmicaDao().getForUser(k);
    }

    public void obradiIznajmice() {
     new IznajmicaDao().izbrisiVraceneKnjige();
    }
    
}

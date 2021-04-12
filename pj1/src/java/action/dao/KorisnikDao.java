/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package action.dao;

import domen.Korisnik;
import java.util.List;
import java.util.Optional;
import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

/**
 *
 * @author Pumpkin
 */
public class KorisnikDao implements Dao<Korisnik> {

    EntityManagerFactory emf = Persistence.createEntityManagerFactory("pj1PU");


  

    @Override
    public List<Korisnik> getAll() {
        EntityManager em = emf.createEntityManager();
        em.getTransaction().begin();

        return em.createQuery("SELECT k FROM Korisnik k").getResultList();

    }

    @Override
    public void save(Korisnik rk) {

        EntityManager em = emf.createEntityManager();
        em.getTransaction().begin();
        try {
            em.persist(rk);
            em.getTransaction().commit();
            em.close();
        } catch (Exception ex) {
            System.out.println("Greska: " + ex);
        }
    }

    @Override
    public void update(Korisnik t) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public void delete(Korisnik t) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public Korisnik get(Object... args) {
       String user = (String) args[0];
        String pass = (String) args[1];
        EntityManager em = emf.createEntityManager();
        em.getTransaction().begin();

        List<Korisnik> listaKorisnika = getAll();

        for (Korisnik korisnik : listaKorisnika) {
            if (korisnik.getUser().getUsername().equals(user) && korisnik.getUser().getPassword().equals(pass)) {
                System.out.println("Nasao sam korisnika:" + korisnik.getUser().getImeIPrezime());
                return korisnik;

            }
        }
        return null;  }

}

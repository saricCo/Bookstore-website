/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package action.dao;

import domen.Knjiga;
import domen.Zanr;
import java.util.LinkedList;
import java.util.List;
import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

/**
 *
 * @author Pumpkin
 */
public class KnjigeDao implements Dao<Knjiga> {

    EntityManagerFactory emf = Persistence.createEntityManagerFactory("pj1PU");

    @Override
    public Knjiga get(Object... args) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public List<Knjiga> getAll() {
        EntityManager em = emf.createEntityManager();
        em.getTransaction().begin();

        List<Knjiga> lista = em.createQuery("SELECT k FROM Knjiga k").getResultList();
        em.close();
        return lista;
    }

    @Override
    public void save(Knjiga k) {
        EntityManager em = emf.createEntityManager();
        em.getTransaction().begin();
        try {
            em.persist(k);
            em.getTransaction().commit();
            em.close();
        } catch (Exception ex) {
            System.out.println("Greska: " + ex);
        }

    }

    @Override
    public void update(Knjiga k) {

        EntityManager em = emf.createEntityManager();

        em.getTransaction().begin();
        Knjiga zaIzmenu = em.find(Knjiga.class, k.getKnjigaID());
        if (zaIzmenu != null) {
            zaIzmenu = em.merge(k);
            em.getTransaction().commit();
            em.close();
        } else {
            System.out.println("Greska: Ne postoji data knjiga u bazi. ");
        }

    }

    @Override
    public void delete(Knjiga k) {
        EntityManager em = emf.createEntityManager();
        em.getTransaction().begin();
        Knjiga knjiga = em.find(Knjiga.class, k.getKnjigaID());
        em.remove(knjiga);
        em.getTransaction().commit();

    }

    public Knjiga findKnjiga(int id) {
        Knjiga a = new Knjiga();
        EntityManager em = emf.createEntityManager();
        em.getTransaction().begin();

        List<Knjiga> listaKnjiga = getAll();

        for (Knjiga k : listaKnjiga) {
            if (k.getKnjigaID() == id) {
                return k;

            }
        }
        return null;

    }

}

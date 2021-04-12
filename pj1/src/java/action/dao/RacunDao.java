/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package action.dao;

import domen.Racun;
import domen.Stavkaracuna;
import java.util.List;
import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

/**
 *
 * @author Pumpkin
 */
public class RacunDao implements Dao<Racun> {

    EntityManagerFactory emf = Persistence.createEntityManagerFactory("pj1PU");

    @Override
    public Racun get(Object... args) {
        int racunID = (int) args[0];
        EntityManager em = emf.createEntityManager();
        em.getTransaction().begin();

        Racun r = (Racun) em.createQuery("SELECT r FROM Racun r WHERE r.racunID=" + racunID).getSingleResult();
        return r;
    }

    @Override
    public List<Racun> getAll() {
        EntityManager em = emf.createEntityManager();
        em.getTransaction().begin();
        List<Racun> listaRacuna = em.createQuery("SELECT r FROM Racun r").getResultList();
        return listaRacuna;
    }

    @Override
    public void save(Racun r) {
        EntityManager em = emf.createEntityManager();
        em.getTransaction().begin();
        try {
            em.persist(r);
            for (Stavkaracuna sr : r.getStavkaracunaList()) {
                em.persist(sr);
            }

            em.getTransaction().commit();
            em.close();

        } catch (Exception ex) {
            System.out.println("Greska: " + ex);
        }

    }

    @Override
    public void update(Racun t) {
        EntityManager em = emf.createEntityManager();

        em.getTransaction().begin();
        Racun zaIzmenu = em.find(Racun.class, t.getRacunID());
        if (zaIzmenu != null) {
            zaIzmenu = em.merge(t);
            em.getTransaction().commit();
            em.close();
        } else {
            System.out.println("Greska: Ne postoji dati racun u bazi. ");
        }

    }

    @Override
    public void delete(Racun r) {

        new StavkaRacunaDao().deleteAll(r);
        EntityManager em = emf.createEntityManager();
        em.getTransaction().begin();

        Racun racun = em.find(Racun.class, r.getRacunID());
        em.remove(racun);
        em.getTransaction().commit();
    }

    public int vratiMaxID() {

        EntityManager em = emf.createEntityManager();
        em.getTransaction().begin();

        int broj = (int) em.createQuery("SELECT max(r.racunID) FROM Racun r").getSingleResult();

        return broj + 1;
    }

}
